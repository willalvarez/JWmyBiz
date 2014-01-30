//
//  CustomContainerViewController.m
//  myBiz
//
//  Created by Will Alvarez on 12/27/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "CustomContainerViewController.h"

@interface CustomContainerViewController () <CommsDelegate>
{
    
}

@end

@implementation CustomContainerViewController

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
    NSArray *array = [self viewControllers];
NSLog(@"The content of array is%@",array);
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
