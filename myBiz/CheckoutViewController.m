//
//  CheckoutViewController.m
//  myBiz
//
//  Created by Will Alvarez on 12/23/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "CheckoutViewController.h"
#import "JWCheckoutCart.h"
#import "CheckoutProductCell.h"
#import "ItemOrdered.h"
#import "JWSubtotalCell.h"
#import "BTTheme.h"


#define ROW_MARGIN 8.0f
#define ROW_HEIGHT 173.0f
static NSString *CellIdentifier = @"Cell";

@interface CheckoutViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *continueButtonView;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) UITextField *theTextField;

@property (strong, nonatomic) JWCheckoutCart* checkoutCart;
@property (strong, nonatomic) JWProduct *editedproduct;
@property (strong, nonatomic) NSArray *itemsArray;

@end

@implementation CheckoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
      self.checkoutCart = [JWCheckoutCart sharedInstance];
    [BTThemeManager customizeButton:_continueButton];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[[self.tabBarController.viewControllers objectAtIndex:0]tabBarItem]setEnabled:TRUE];
    [[[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem]setEnabled:TRUE];
    [[[self.tabBarController.viewControllers objectAtIndex:2]tabBarItem]setEnabled:TRUE];
    self.theTextField.delegate = self;


  //  [self.tableView reloadData];
    
   self.checkoutCart = [JWCheckoutCart sharedInstance];
    [self.tableView reloadData];
    ///////
    ////// Don't display if cart is empty

    if ([self.checkoutCart total] > 0)
    {
        // Make sure cart is not empty
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Shop first!"
                                                         message:@"Your shopping cart is empty"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        
        if (self.checkoutCart.productsInCart.count == 0) {
            [alert show];
         //   [self.tabBarController setSelectedIndex:0];
            [self.navigationController popToRootViewControllerAnimated:YES];
     
            
        }
        
    }

    //////
    //////
    [BTThemeManager customizeView:self.view];
    
    
}

/*
- (IBAction)acceptPayment:(id)sender {
    [self performSegueWithIdentifier:@"creditCardPayment" sender:self];
}
*/
#pragma mark - Table view data source

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (section == 0) ? @"Products " : @"";
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; //(2 would show total lie
    // One section per WallImage
    //return 1; // for testing w/o total
   // return  [JWCheckoutCart sharedInstance].itemsInCart.count;
   // return [DataStore instance].ordersInCart.count;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return (section == 0) ? self.checkoutCart.productsInCart.count : 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        JWProduct *product = self.checkoutCart.productsInCart[indexPath.row];
        CheckoutProductCell *cell = [[CheckoutProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.editing = TRUE;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.imageView.image= product.image;
        
        // Get Item Name
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(145.0, 0.0,200.0, 30.0)];
        textLabel.tag = 4223;
        textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
        textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
        textLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        textLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = product.itemName;
        [cell.contentView addSubview:textLabel];

        // Get Item Price
        NSNumber *pNumber = product.itemPrice;
        NSNumberFormatter *nfp = [[NSNumberFormatter alloc] init];
        [nfp setNumberStyle:NSNumberFormatterCurrencyStyle];
        NSString *dollarprice = [nfp stringFromNumber:pNumber];
        UILabel *textLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(145.0, 30.0,60.0, 30.0)];
        textLabel3.tag = 4226;
        textLabel3.text = dollarprice;
        [cell.contentView addSubview:textLabel3];



        // Get qty_Ordered
        NSNumber *qty = product.qty_Ordered;
        NSNumberFormatter *qf = [[NSNumberFormatter alloc] init];
        [qf setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *qtystring = [qf stringFromNumber:qty];
        UITextField *qtyOrderedText = [[UITextField alloc] initWithFrame:CGRectMake(145.0, 60.0,50.0, 30.0)];
      //  qtyOrderedText.tag = 4225;
        qtyOrderedText.tag = 4225;
     
        qtyOrderedText.text = qtystring;
        qtyOrderedText.delegate  = self;
        
        self.theTextField = qtyOrderedText;
        //////
        //////
        


        NSString *stringQty = qtyOrderedText.text;
        
        NSNumber *number = @([stringQty intValue]);
        product.qty_Ordered = number;
        

        qtyOrderedText.backgroundColor = [UIColor grayColor];
        [qtyOrderedText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [qtyOrderedText setReturnKeyType:UIReturnKeyDone];
        
        
        [cell.contentView addSubview:qtyOrderedText];
  
        // Calculate lineTotal(s)
        
        float unitPrice = [product.itemPrice floatValue];
        float qtyOrd    = [product.qty_Ordered floatValue];
   //     NSNumber *aNumber = product.itemPrice;
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
   //     NSString *dollarprice = [nf stringFromNumber:aNumber];
        float lineTotal = unitPrice * qtyOrd;
        NSString *str = [NSString stringWithFormat:@"%.2f", lineTotal];
        
        /// line up subtotal layouts
 
        UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(250.0, 60.0,60.0, 30.0)];
 
        textLabel2.tag = 4224;
        //cell.priceLabel.text = dollarprice;
        //textLabel2.text = dollarprice;
    
        textLabel2.text = str;
        [cell.contentView addSubview:textLabel2];
        
        return cell;
    }
    else {
        
       JWSubtotalCell *cell2 = [self.tableView dequeueReusableCellWithIdentifier:@"TotalCell"];
        cell2.totalLabel.text = [NSString stringWithFormat:@"$%@", [self.checkoutCart total]];

        return cell2;
        
    }
    
    
    return nil;
    
}

// Edit qty_Ordered
//UITableViewCell *cell =(UITableViewCell *) textField.superview.superview.superview;
//NSIndexPath *indexPath = [tblView indexPathForCell:cell];


// Delete Cell

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        JWProduct* product = self.checkoutCart.productsInCart[indexPath.row];
        [self.checkoutCart removeProduct:product];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate methods
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"SectionWill: %ld, Row: %ld", (long)indexPath.section, (long)indexPath.row);
}
*/

- (void)textFieldDidEndEditing:(UITextField *)textField{

    CGPoint location = [self.tableView convertPoint:textField.frame.origin fromView:textField.superview];
    NSIndexPath *eindexPath = [self.tableView indexPathForRowAtPoint:location];
 //   NSLog(@"Qty changed");
    NSLog(@"Section: %ld, Row: %ld", (long)eindexPath.section, (long)eindexPath.row);
    
    NSString *stringQty = textField.text;
    NSLog(@"%@",stringQty);
    NSNumber *number = @([stringQty intValue]);
       JWProduct *newproduct = self.checkoutCart.productsInCart[eindexPath.row];
    newproduct.qty_Ordered = number;
  

    [DataStore instance].editedIndex  = eindexPath.row;
    [self.checkoutCart replaceProduct:newproduct];
    
    [self.tableView reloadData];
    
    
    

}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

# pragma Respond to Action




@end
