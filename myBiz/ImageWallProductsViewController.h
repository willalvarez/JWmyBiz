//
//  ImageWallProductsViewController.h
//  myBiz
//
//  Created by Will Alvarez on 12/23/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWallProductsViewController : UIViewController
//@property (nonatomic, strong) UIButton *orderButton;
@property (strong, nonatomic) IBOutlet UIButton *orderButton;
@property (strong, nonatomic) IBOutlet UIButton *btnUpload;

@property (strong, nonatomic) IBOutlet UIImageView *image;
@end
