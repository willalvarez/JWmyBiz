//
//  ImageWallProductCell.h
//  myBiz
//
//  Created by Will Alvarez on 12/23/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWallProductCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, strong) UIButton *sizeButton;


@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) UILabel *priceLabel;

@end
