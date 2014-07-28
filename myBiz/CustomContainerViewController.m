//
//  CustomContainerViewController.m
//  myBiz
//
//  Created by Will Alvarez on 12/27/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "CustomContainerViewController.h"
#import "BTTheme.h"
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
- (void)viewWillAppear:(BOOL)animated
{
    [[[self.tabBarController.viewControllers objectAtIndex:0]tabBarItem]setEnabled:TRUE];
    [[[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem]setEnabled:FALSE];
    [[[self.tabBarController.viewControllers objectAtIndex:2]tabBarItem]setEnabled:FALSE];
    
    [BTThemeManager customizeView:self.view];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array = [self viewControllers];
NSLog(@"The content of array is%@",array);
	// Do any additional setup after loading the view.
    // Reset the DataStore so that we are starting from a fresh Login
	// as we could have come to this screen from the Logout navigation
	[[DataStore instance] reset];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
