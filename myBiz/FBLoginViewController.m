//
//  FBLoginViewController.m
//  myBiz
//
//  Created by Will Alvarez on 12/16/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "FBLoginViewController.h"
#import "BTTheme.h"

@interface FBLoginViewController () <CommsDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityLogin;

@end

@implementation FBLoginViewController

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
    // Ensure the User is Logged out when loading this View Controller
    // Going forward, we would check the state of the current user and bypass the Login Screen
    // but here, the Login screen is an important part of the tutorial

       [PFUser logOut];
}

- (void)viewWillAppear:(BOOL)animated
{
[[[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem]setEnabled:FALSE];
[[[self.tabBarController.viewControllers objectAtIndex:2]tabBarItem]setEnabled:FALSE];
[[[self.tabBarController.viewControllers objectAtIndex:3]tabBarItem]setEnabled:FALSE];
    
     [BTThemeManager customizeView:self.view];
}
// Outlet for FBLogin button
- (IBAction) loginPressed:(id)sender

{
	// Disable the Login button to prevent multiple touches
	[_btnLogin setEnabled:NO];
	
	// Show an activity indicator
	[_activityLogin startAnimating];
	
	// Reset the DataStore so that we are starting from a fresh Login
	// as we could have come to this screen from the Logout navigation
	[[DataStore instance] reset];
    
	
	// Do the login
	[Comms login:self];
    
}

- (void) commsDidLogin:(BOOL)loggedIn {
	// Re-enable the Login button
	[_btnLogin setEnabled:YES];
    
	// Stop the activity indicator
	[_activityLogin stopAnimating];
    
	// Did we login successfully ?
	if (loggedIn) {        
       [self.tabBarController setSelectedIndex:2];
	} else {
		// Show error alert
		[[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                    message:@"Facebook Login failed. Please try again"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
	}
}

@end
