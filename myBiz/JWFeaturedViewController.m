//
//  JWFeaturedViewController.m
//  myBiz
//
//  Created by Will Alvarez on 12/25/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "JWFeaturedViewController.h"
#import "JWCheckoutCart.h"
#import "JWProduct.h"
#import "JWProducts.h"
#import "BTTheme.h"

@interface JWFeaturedViewController () <UITabBarControllerDelegate, UITabBarDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *lblitemName;
@property (strong, nonatomic) IBOutlet UILabel *lblitemDesc;
@property (strong, nonatomic) IBOutlet UIButton *btnAddToCart;
@property (strong, nonatomic) IBOutlet UILabel *lblitemPrice;

@property (strong, nonatomic) itemOrdered *item;



@end

@implementation JWFeaturedViewController

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
    [BTThemeManager customizeButton:_btnAddToCart];

}

- (IBAction)addToCart:(id)sender {
    
    
    JWCheckoutCart* checkoutCart = [JWCheckoutCart sharedInstance];

    if (!self.btnAddToCart.selected) {
        
        [checkoutCart addProduct:self.product];
        self.btnAddToCart.selected = YES;
    }
    else {
        [checkoutCart removeProduct:self.product];
        self.btnAddToCart.selected = NO;
    }
    
    // Default transition to Products view, reset add to cart button
    
    [self.tabBarController setSelectedIndex:2];
}


- (void)viewWillAppear:(BOOL)animated
{
    JWCheckoutCart* checkoutCart = [JWCheckoutCart sharedInstance];
    self.btnAddToCart.selected = [checkoutCart containsProduct:self.product] ? YES : NO;

	
//    self.product = ([DataStore instance].wallImages[[DataStore instance].selectedIndex]);
 
    // Make sure a selection was made
    NSInteger ix = [DataStore instance].selectedIndex;

    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Selected Item"
                                                     message:@"Please make a selection"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];    
   
    

    
    // Make sure product wall is not empty before accessing via index
    NSInteger xcount;
    xcount = [DataStore instance].wallImages.count;
 

    
    
    if (xcount  > 0)  {        
    self.product = ([DataStore instance].wallImages[ix]);
        self.btnAddToCart.enabled = TRUE;
    }
    else {
        [alert show];
        self.btnAddToCart.enabled = FALSE;
    }
 
    self.image.image = self.product.image;
    self.lblitemName.text =  self.product.itemName;
    self.lblitemDesc.text = self.product.itemDesc;
    NSNumber *pNumber = self.product.itemPrice;
    NSNumberFormatter *nfp = [[NSNumberFormatter alloc] init];
    [nfp setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *dollarprice = [nfp stringFromNumber:pNumber];
    self.lblitemPrice.text = dollarprice;
    
    self.btnAddToCart.selected = NO;
    [BTThemeManager customizeView:self.view];
}



@end
