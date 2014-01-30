/* Initialize the Stripe and Mailgun Cloud Modules */
var Stripe = require('stripe');
// Test Key
//Stripe.initialize('sk_test_hIFslJOcxD6SRUZOBBijNKdu');
//Live Key
Stripe.initialize('sk_live_IQscSIogjRckIAhy5YjAtEgU');


var Mailgun = require('mailgun');
Mailgun.initialize("winmobilesales.com", "key-286trpqja-myp4jwr9117m0sjiq2a626");

/*
 * Purchase  items from the JW Mobile Store(s) using the Stripe
 * Cloud Module.
 *
 * Expected input (in request.params):
 *   cardToken      : String, the credit card token returned to the client from Stripe
 *   itemName       : String An array of items ordered (name,desc, price, qty ordered, line total
 *   totalCharges   : Order total charges, may include tax, shipping/handling charges
 *   name           : String, the buyer's name
 *   email          : String, the buyer's email address
 *   address        : String, the buyer's street address
 *   city_state_zip     : String, the buyer's city and state and zip code
  *
 * Also, please note that on success, "Success" will be returned. 
 */
Parse.Cloud.define("purchaseOrder", function(request, response) {
  // The Item and Order tables are completely locked down. We 
  // ensure only Cloud Code can get access by using the master key.
  Parse.Cloud.useMasterKey();

  // Top level variables used in the promise chain. Unlike callbacks,
  // each link in the chain of promise has a separate context.
  var item, order, arry=[request.params.orderItems];
  var will = 1;
  // We start in the context of a promise to keep all the
  // asynchronous code consistent. This is not required.
  Parse.Promise.as().then(function() {
    // Find the item to purchase.
    var itemQuery = new Parse.Query('Items');
    itemQuery.equalTo('name', request.params.itemName);

    // Find the resuts. We handle the error here so our
    // handlers don't conflict when the error propagates.
    // Notice we do this for all asynchronous calls since we
    // want to handle the error differently each time.
    return itemQuery.first().then(null, function(error) {
      return Parse.Promise.error('Sorry, this item is no longer available.');
    });

  }).then(function(result) {
    // Make sure we found an item and that it's not out of stock.
    if (!result) {
      return Parse.Promise.error('Sorry, this item is no longer available.');
    } else if (result.get('quantityAvailable') <= 0) { // Cannot be 0
      return Parse.Promise.error('Sorry, this item is out of stock.');
    }

    // Decrease the quantity.
    item = result;
    item.increment('quantityAvailable', -1);

    // Save item.
    return item.save().then(null, function(error) {
      console.log('Decrementing quantity failed. Error: ' + error);
      return Parse.Promise.error('An error has occurred(Save item). Your credit card was not charged.');
    });

  }).then(function(result) {
    // Make sure a concurrent request didn't take the last item.
    item = result;
    if (item.get('quantityAvailable') < 0) { // can be 0 if we took the last
      return Parse.Promise.error('Sorry, this item is out of stock.');
    }

    // We have items left! Let's create our order item before 
    // charging the credit card (just to be safe).
    order = new Parse.Object('Order');
    order.set('name', request.params.name);
    order.set('email', request.params.email);
    order.set('address', request.params.address);
    order.set('city_state_zip', request.params.city_state_zip);
    order.set('totalCharges', request.params.totalCharges);
    order.set('fulfilled', false);
    order.set('charged', false); // set to false until we actually charge the card

    // Create new order
    return order.save().then(null, function(error) {
      // This would be a good place to replenish the quantity we've removed.
      // We've ommited this step in this app.
      console.log('Creating order object failed. Error: ' + error);
      return Parse.Promise.error('An error has occurred(Create new order). Your credit card was not charged.');
    });

  }).then(function(order) {
    // amount: item.get('price') * 100, // express dollars in cents
    // Now we can charge the credit card using Stripe and the credit card token.
       //   var totalamount = parseFloat(request.params.totalCharges);
    return Stripe.Charges.create({
      amount: request.params.totalCharges * 100,
      currency: 'usd',
      card: request.params.cardToken
    }).then(null, function(error) {
      console.log('Charging with stripe failed. Error: ' + error);
      return Parse.Promise.error('An error has occurred(charge credit card). Your credit card was not charged.');
    });

  }).then(function(purchase) {
    // Credit card charged! Now we save the ID of the purchase on our
    // order and mark it as 'charged'.
    order.set('stripePaymentId', purchase.id);
    order.set('charged', true);

    // Save updated order
    return order.save().then(null, function(error) {
      // This is the worst place to fail since the card was charged but the order's
      // 'charged' field was not set. Here we need the user to contact us and give us
      // details of their credit card (last 4 digits) and we can then find the payment
      // on Stripe's dashboard to confirm which order to rectify. 
      return Parse.Promise.error('A critical error has occurred with your order. Please ' + 
                                 'contact wcalvarez@optonline.com at your earliest convenience. ');
    });

  }).then(function(order) {
    // Credit card charged and order item updated properly!
    // We're done, so let's send an email to the user.
  
    // Generate the email body string.
    var willItem=[];
   var itemlist = [request.params.orderItems];
    var itemName = itemlist[1];
    var body = "We've received and processed your order for the following item(s): \n\n" +
    
      //"Item: " + request.params.itemName + "\n";
      "You purchased: " + itemlist + "\n"; // shows text: ItemA, ItemB, ItemC.best as of 1/6/13, *parse it and itemize prices

           if (request.params.size && request.params.size !== "N/A") {
      body += "Size: " + request.params.size + "\n";
    }
    //body += "\nPrice: $" + item.get('price') + ".00 \n" +
    body += "Total Amount: $" + request.params.totalCharges + "\n" +
            "Shipping Address: \n" +
            request.params.name + "\n" +
            request.params.address + "\n" +
	     request.params.city_state_zip + "\n" +
            "\nWe will send your items as soon as possible. " + 
            "Let us know if you have any questions!\n\n" +
            "Thank you,\n" +
            "The JW Mobile Store Team";

    // Send the email.
    return Mailgun.sendEmail({
      to: request.params.email,
      from: 'wcalvarez@optonline.net',
      bcc: 'wcalvarez@optonline.net',
      subject: 'Your order from JW Mobile Store was successful!',
      text: body
    }).then(null, function(error) {
      return Parse.Promise.error('Your purchase was successful, but we were not able to ' +
                                 'send you an email. Contact us at wcalvarez@optonline.net if ' +
                                 'you have any questions.');
    });


  }).then(function() {
    // And we're done!
    response.success('Success');

  // Any promise that throws an error will propagate to this handler.
  // We use it to return the error from our Cloud Function using the 
  // message we individually crafted based on the failure above.
  }, function(error) {
    response.error(error);
  });
});
