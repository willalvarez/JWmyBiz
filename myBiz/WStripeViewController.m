//
//  WStripeViewController.m
//  myBiz
//
//  Created by Will Alvarez on 1/23/14.
//  Copyright (c) 2014 Will Alvarez. All rights reserved.
//

#import "WStripeViewController.h"
#import "JWCheckoutCart.h"
#import "Stripe.h"
#import "BTTheme.h"

//Live KEY
#define STRIPE_TEST_PUBLIC_KEY @"pk_live_7OpifX1eqYDmiElAyCHiGfkQ"
//Test KEY
//#define STRIPE_TEST_PUBLIC_KEY @"pk_test_qoNf5gbCNMTNbioJG9JSJdrw"
#define STRIPE_TEST_POST_URL


@interface WStripeViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton* completeButton;
@property (strong, nonatomic) JWCheckoutCart* checkoutCart;
@property (strong, nonatomic) NSString *curritemName;
@property (strong, nonatomic) NSMutableArray *itemsInCart;

@property (strong, nonatomic) IBOutlet UITextField* nameTextField;
@property (strong, nonatomic) IBOutlet UITextField* emailTextField;
@property (strong, nonatomic) IBOutlet UITextField* expirationDateTextField;
@property (strong, nonatomic) IBOutlet UITextField* cardNumber;
@property (strong, nonatomic) IBOutlet UITextField* CVCNumber;

@property (strong, nonatomic) NSArray* monthArray;
//@property (strong, nonatomic) NSMutableArray* arr;
@property (strong, nonatomic) NSNumber* selectedMonth;
@property (strong, nonatomic) NSNumber* selectedYear;
@property (strong, nonatomic) UIPickerView *expirationDatePicker;

//@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;
@property (strong, nonatomic) STPCard* stripeCard;
//@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation WStripeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // [[[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem]setEnabled:FALSE];
    // [[[self.tabBarController.viewControllers objectAtIndex:2]tabBarItem]setEnabled:FALSE];
    [BTThemeManager customizeView:self.view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [BTThemeManager customizeButton:_completeButton];
    self.checkoutCart = [JWCheckoutCart sharedInstance];
    
    
    self.monthArray = @[@"01 - January", @"02 - February", @"03 - March",
                        @"04 - April", @"05 - May", @"06 - June", @"07 - July", @"08 - August", @"09 - September",
                        @"10 - October", @"11 - November", @"12 - December"];
    [self configurePickerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Stripe

- (IBAction)completeButtonTapped:(id)sender {
    
    // Make sure cart is not empty
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Shop first!"
                                                     message:@"Your shopping cart is empty"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    if (self.checkoutCart.productsInCart.count == 0) {
        [alert show];
        
        
    }else {
        
        
        //ONE tap and disallow...trigger-happy tapping
        self.completeButton.enabled = NO;
        
        //1
        self.stripeCard = [[STPCard alloc] init];
        self.stripeCard.name = self.nameTextField.text;
        self.stripeCard.number = self.cardNumber.text;
        self.stripeCard.cvc = self.CVCNumber.text;
        self.stripeCard.expMonth = [self.selectedMonth integerValue];
        self.stripeCard.expYear = [self.selectedYear integerValue];
        
        //2
        if ([self validateCustomerInfo]) {
            [self performStripeOperation];
        } else {
            self.completeButton.enabled = YES;
        }
    }
}




- (BOOL)validateCustomerInfo {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please try again"
                                                     message:@"Please enter all required information"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    //1. Validate name & email
    if (self.nameTextField.text.length == 0 ||
        self.emailTextField.text.length == 0) {
        
        [alert show];
        return NO;
    }
    
    //2. Validate card number, CVC, expMonth, expYear
    NSError* error = nil;
    [self.stripeCard validateCardReturningError:&error];
    
    //3
    if (error) {
        alert.message = [error localizedDescription];
        [alert show];
        return NO;
    }
    
    return YES;
}

- (void)performStripeOperation {
    //1
    //   self.hud.labelText = @"Authorizing...";
    self.completeButton.enabled = NO;
    
    //2
    /*
     [Stripe createTokenWithCard:self.stripeCard
     publishableKey:STRIPE_TEST_PUBLIC_KEY
     success:^(STPToken* token) {
     [self postStripeToken:token.tokenId];
     } error:^(NSError* error) {
     [self handleStripeError:error];
     }];
     */
    
    
    [Stripe createTokenWithCard:self.stripeCard
                 publishableKey:STRIPE_TEST_PUBLIC_KEY
                     completion:^(STPToken* token, NSError* error) {
                         if(error)
                             [self handleStripeError:error];
                         else
                             // keep original for Order-Header logic
                             [self postStripeToken:token.tokenId];
                     }];
}

- (void)postStripeToken:(NSString* )token {
    //  self.hud.labelText = @"Charging...";
    //   take self.totalCharges from checkoutCart
    NSArray *itemsOrdered = self.checkoutCart.productsInCart;
    //JWProduct *currItem = itemsOrdered[0];
    //    NSString *curritemName = [[NSString alloc] init];
    
    
    // create array of itemName(s) ordered and Qtys (for line-item email to customer)
    //  NSArray *arr =  [[NSArray alloc] init];
    NSMutableArray *myitems, *myQtys;
    myitems = [NSMutableArray arrayWithObjects: nil];
    myQtys = [NSMutableArray arrayWithObjects: nil];
    
    
    for(int i = 0; i < [itemsOrdered count]; i++) {
        JWProduct *currItem = itemsOrdered[i];
        self.curritemName = currItem.itemName;
        NSString *lineColor = self.curritemName;
        [myitems addObject: lineColor];
        
    }
    
    
    
    
    
    NSMutableArray *arr =  [[NSMutableArray alloc] initWithObjects:myitems, nil];
    NSNumber *total = [self.checkoutCart total];
    
    
    NSString *citystatezip;
    citystatezip = [shippingInfo sharedInstance].shippingCity;
    citystatezip = [citystatezip stringByAppendingString:@", "];
    citystatezip = [citystatezip stringByAppendingString:[shippingInfo sharedInstance].shippingState];
    citystatezip = [citystatezip stringByAppendingString:@" "];
    citystatezip = [citystatezip stringByAppendingString:[shippingInfo sharedInstance].shippingZip];
    
    
    NSDictionary *orderInfo = @{
                                @"cardToken": token,
                                @"itemName":self.curritemName,
                                @"orderItems":arr,
                                @"size":@"N/A",
                                @"totalCharges":total,
                                @"name":self.nameTextField.text,
                                @"email": self.emailTextField.text,
                                @"address": [shippingInfo sharedInstance].shippingAddress1,
                                @"city_state_zip":citystatezip
                                };
    [PFCloud callFunctionInBackground:@"purchaseOrder"
                       withParameters:orderInfo
                                block:^(id object, NSError *error) {
                                    if (error) {
                                        [self chargeDidNotSuceed];
                                        self.completeButton.enabled = YES;
                                        
                                    } else {
                                        [self chargeDidSucceed];
                                        // prevent accidental multiple charging, once successful,
                                        // the only way to charge is if it's another order.....
                                        self.completeButton.enabled = NO;
                                    }
                                }];
    
    // self.completeButton.enabled = YES;
    
}

- (void)handleStripeError:(NSError *) error {
    //Implement
}


- (void)chargeDidSucceed {
    //1
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"Thank you for your Order."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    JWCheckoutCart* checkoutCart = [JWCheckoutCart sharedInstance];
    [checkoutCart clearCart];
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)chargeDidNotSuceed {
    //2
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment not successful"
                                                    message:@"Please try again later."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark - UIPicker data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return (component == 0) ? 12 : 10;
}

#pragma mark - UIPicker delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        //Expiration month
        return self.monthArray[row];
    }
    else {
        //Expiration year
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSInteger currentYear = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
     //   return [NSString stringWithFormat:@"%i", currentYear + row];
        return [NSString stringWithFormat:@"%tu", currentYear + row];
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.selectedMonth = @(row + 1);
    }
    else {
        NSString *yearString = [self pickerView:self.expirationDatePicker titleForRow:row forComponent:1];
        self.selectedYear = @([yearString integerValue]);
    }
    
    
    if (!self.selectedMonth) {
        [self.expirationDatePicker selectRow:0 inComponent:0 animated:YES];
        self.selectedMonth = @(1); //Default to January if no selection
    }
    
    if (!self.selectedYear) {
        [self.expirationDatePicker selectRow:0 inComponent:1 animated:YES];
        NSString *yearString = [self pickerView:self.expirationDatePicker titleForRow:0 forComponent:1];
        self.selectedYear = @([yearString integerValue]); //Default to current year if no selection
    }
    
    self.expirationDateTextField.text = [NSString stringWithFormat:@"%@/%@", self.selectedMonth, self.selectedYear];
    self.expirationDateTextField.textColor = [UIColor blackColor];
}

#pragma mark - UIPicker configuration

- (void)configurePickerView {
    self.expirationDatePicker = [[UIPickerView alloc] init];
    self.expirationDatePicker.delegate = self;
    self.expirationDatePicker.dataSource = self;
    self.expirationDatePicker.showsSelectionIndicator = YES;
    
    //Create and configure toolabr that holds "Done button"
    UIToolbar *pickerToolbar = [[UIToolbar alloc] init];
    pickerToolbar.barStyle = UIBarStyleBlackTranslucent;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil
                                          action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(pickerDoneButtonPressed)];
    
    [pickerToolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    
    self.expirationDateTextField.inputView = self.expirationDatePicker;
    self.expirationDateTextField.inputAccessoryView = pickerToolbar;
    self.nameTextField.inputAccessoryView = pickerToolbar;
    self.emailTextField.inputAccessoryView = pickerToolbar;
    self.cardNumber.inputAccessoryView = pickerToolbar;
    self.CVCNumber.inputAccessoryView = pickerToolbar;
}

- (void)pickerDoneButtonPressed {
    [self.view endEditing:YES];
}

@end
