//
//  ShippingInfoViewController.m
//  myBiz
//
//  Created by Will Alvarez on 1/13/14.
//  Copyright (c) 2014 Will Alvarez. All rights reserved.
//

#import "ShippingInfoViewController.h"
#import "BTTheme.h"

@interface ShippingInfoViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *shiptoAddress1;
@property (strong, nonatomic) IBOutlet UITextField *shiptoAddress2;
@property (strong, nonatomic) IBOutlet UITextField *shiptoCity;
@property (strong, nonatomic) IBOutlet UITextField *shiptoState;
@property (strong, nonatomic) IBOutlet UITextField *shiptoZipcode;
@property (strong, nonatomic) IBOutlet UIButton *btnContinue_toPayment;


@end

@implementation ShippingInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
     [BTThemeManager customizeView:self.view];
    [[[self.tabBarController.viewControllers objectAtIndex:0]tabBarItem]setEnabled:FALSE];
    [[[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem]setEnabled:FALSE];
    [[[self.tabBarController.viewControllers objectAtIndex:2]tabBarItem]setEnabled:FALSE];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [BTThemeManager customizeButton:_btnContinue_toPayment];
    
}

- (IBAction)continuetoPayment:(id)sender {
    [shippingInfo sharedInstance].shippingAddress1 = self.shiptoAddress1.text;
    [shippingInfo sharedInstance].shippingAddress2 = self.shiptoAddress2.text;
    [shippingInfo sharedInstance].shippingCity = self.shiptoCity.text;
    [shippingInfo sharedInstance].shippingState = self.shiptoState.text;
    [shippingInfo sharedInstance].shippingZip = self.shiptoZipcode.text;
}


-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

@end
