//
//  UIProductViewCell.h
//  myBiz
//
//  Created by Will Alvarez on 12/21/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIProductViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *lblitemName;
@property (strong, nonatomic) IBOutlet UILabel *lblitemDesc;
@property (strong, nonatomic) IBOutlet UIButton *btnBuy;

@end
