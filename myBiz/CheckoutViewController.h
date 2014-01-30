//
//  CheckoutViewController.h
//  myBiz
//
//  Created by Will Alvarez on 12/23/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWProduct.h"

@interface CheckoutViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;

@property (strong, nonatomic) JWProduct* product;
@property (strong, nonatomic) JWProduct* newproduct;
@end
