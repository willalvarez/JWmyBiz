//
//  DetailViewController.h
//  myBiz
//
//  Created by Will Alvarez on 12/15/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
