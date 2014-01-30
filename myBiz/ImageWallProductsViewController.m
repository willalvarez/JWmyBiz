//
//  ImageWallProductsViewController.m
//  myBiz
//
//  Created by Will Alvarez on 12/23/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "ImageWallProductsViewController.h"
#import "ImageWallProductCell.h"
#import "BTTheme.h"

static NSString *CellIdentifier = @"Cell";



@interface ImageWallProductsViewController () <UITableViewDataSource,UITabBarControllerDelegate,
CommsDelegate> {
	NSDate *_lastImageUpdate;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

//@property (strong, nonatomic) IBOutlet UIButton *orderButton;

@end
//////
////// Event Handling-START
//////
@interface UIView (ParentCell)

- (UITableViewCell *)parentCell;

@end

@implementation UIView (ParentCell)

- (UITableViewCell *)parentCell
{
    UIView *superview = self.superview;
    while( superview != nil ) {
        if( [superview isKindOfClass:[UITableViewCell class]] )
            return (UITableViewCell *)superview;
        
        superview = superview.superview;
    }
    
    return nil;
}

@end
//////
//////
//////

@implementation ImageWallProductsViewController

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

    // Initialize the last updated dates
    _lastImageUpdate = [NSDate distantPast];
   [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    
    // If we are using iOS 6+, put a pull to refresh control in the table
    /*
    if (NSClassFromString(@"UIRefreshControl") != Nil) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
        [refreshControl addTarget:self action:@selector(refreshImageWall:) forControlEvents:UIControlEventValueChanged];
        self.refreshControl = refreshControl;
    }
     */
    //////////
    //////////
    if (NSClassFromString(@"UIRefreshControl") != Nil) {
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tableView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];

    [self.refreshControl addTarget:self action:@selector(refreshImageWall:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = _refreshControl;
    tableViewController.refreshControl = self.refreshControl;
    }
    //////////
    //////////
    
    // Get the Wall Images from Parse
    //[Comms getWallImagesSince:_lastImageUpdate forDelegate:self];
    [self refreshImageWall:nil];
 
    // Listen for image downloads so that we can refresh the image wall
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageDownloaded:)
                                                 name:N_ImageDownloaded
                                               object:nil];
    // Listen for new image uploads so that we can refresh the image wall table
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(imageUploaded:)
												 name:N_ImageUploaded
											   object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // Determine if logged-in user is 'owner-level'
    NSString *bigBoss = @"727388131";
    NSString *currentfbuser = [DataStore instance].FBid;
    
    if ([bigBoss isEqualToString:currentfbuser]) {
        self.btnUpload.enabled = TRUE;
    } else {
            self.btnUpload.enabled = FALSE;
    }


    //Remove Login from tab bar items
    [[[self.tabBarController.viewControllers objectAtIndex:0]tabBarItem]setEnabled:FALSE];
    // Disable Detail View until a selection is made
    [[[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem]setEnabled:TRUE];
    [[[self.tabBarController.viewControllers objectAtIndex:2]tabBarItem]setEnabled:TRUE];
    [[[self.tabBarController.viewControllers objectAtIndex:3]tabBarItem]setEnabled:TRUE];
    
    // set customization of appearance
    [BTThemeManager customizeView:self.view];
}

- (void) refreshImageWall:(UIRefreshControl *)refreshControl
{
	if (refreshControl) {
        
		[_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Refreshing data..."]];
        [_refreshControl setEnabled:NO];
	}
    
	// Get any new Wall Images since the last update
	[Comms getWallImagesSince:_lastImageUpdate forDelegate:self];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // One section per WallImage
	return [DataStore instance].wallImages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImageWallProductCell *cell = [[ImageWallProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Configure the cell...
	// Get the WallImage from the indexPath.section
	WallImage *wallImage = ([DataStore instance].wallImages[indexPath.section]);
    cell.imageView.image=wallImage.image;
    
    // Get Item Name
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(145.0, 0.0,200.0, 30.0)];
    textLabel.tag = 4223;
    textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    textLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    textLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = wallImage.itemName;
    [cell.contentView addSubview:textLabel];
    
    // Get Item Description    
    UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(145.0, 30.0,150.0, 30.0)];
    textLabel2.tag = 4224;
  
    textLabel2.text = wallImage.itemDesc;
    [cell.contentView addSubview:textLabel2];
    
    
    // Get Item Price
    // convert to currency-formatted string
    NSNumber *aNumber = wallImage.itemPrice;
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *dollarprice = [nf stringFromNumber:aNumber];
    cell.priceLabel.text = dollarprice;
 
    //////
 
    // Set 'Buy' Button
   /*
    self.orderButton.frame = CGRectMake(200.0, 80.0, 120.0f, 35.0f);
    self.orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderButton setTitle:NSLocalizedString(@"Add to Cart", @"Add to Cart") forState:UIControlStateNormal];
    self.orderButton.titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
    self.orderButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -0.5f);
    self.orderButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
    
    UIImage *orderImage = [UIImage imageNamed:@"ButtonOrder.png"];
    UIImage *orderPressedImage = [UIImage imageNamed:@"ButtonOrderPressed.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(orderImage.size.height/2, orderImage.size.width/2, orderImage.size.height/2, orderImage.size.width/2);
    [self.orderButton setBackgroundImage:[orderImage resizableImageWithCapInsets:insets] forState:UIControlStateNormal];
    [self.orderButton setBackgroundImage:[orderPressedImage resizableImageWithCapInsets:insets] forState:UIControlStateHighlighted];
  //  [cell.contentView addSubview:_orderButton];
*/
    //////
    //////
    cell.orderButton.tag = indexPath.row;
    [cell.orderButton addTarget:self action:@selector(addToCart:)
               forControlEvents:UIControlEventTouchUpInside];
    //////
    //////
    
    return cell;
    
}



- (void) commsDidGetNewWallImages:(NSDate *)updated {
	// Update the update timestamp
	_lastImageUpdate = updated;
 
    
	// Refresh the table data to show the new images
	[self.tableView reloadData];
}

- (void) imageUploaded:(NSNotification *)notification
{
	[self refreshImageWall:nil];
}

- (void) imageDownloaded:(NSNotification *)notification {
	[self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */


#pragma mark - Event handlers


-(IBAction) addToCart:(id) sender{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)
                              [[sender superview] superview]];
    WallImage *wallImage = ([DataStore instance].wallImages[indexPath.section]);
   
    // Save details of selected Item in singleton class
    
    [itemSelected sharedInstance].sel_itemName = wallImage.itemName;
    [itemSelected sharedInstance].sel_itemDesc = wallImage.itemDesc;
    [itemSelected sharedInstance].sel_image = wallImage.image;
    [itemSelected sharedInstance].sel_itemPrice = wallImage.itemPrice;
    
    // move to Item Details view
    NSInteger idx = indexPath.section;
    
    [DataStore instance].selectedIndex = idx;
    
    
    [self.tabBarController setSelectedIndex:1];
    
   
    
}



- (IBAction) logoutPressed:(id)sender
{
	[PFUser logOut];
	
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction) uploadPressed:(id)sender
{
	// Seque to the Image Uploader
	[self performSegueWithIdentifier:@"UploadImage" sender:self];
}

@end




