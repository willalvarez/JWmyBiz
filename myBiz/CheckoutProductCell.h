//
//  CheckoutProductCell.h
//  myBiz
//
//  Created by Will Alvarez on 12/31/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckoutProductCell :  UITableViewCell 

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UITextField *qty_Ordered;

@end
