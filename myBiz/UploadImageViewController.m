//
//  UploadImageViewController.m
//  myBiz
//
//  Created by Will Alvarez on 12/17/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "UploadImageViewController.h"
#import "UIImage+Scaling.h"
#import "BTTheme.h"

@interface UploadImageViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, CommsDelegate>
@property (strong, nonatomic) IBOutlet UITextField *itemName;
@property (strong, nonatomic) IBOutlet UITextField *itemDesc;
@property (strong, nonatomic) IBOutlet UITextField *itemPrice;
@property (strong, nonatomic) IBOutlet UITextField *itemQuantityAvailable;
@property (strong, nonatomic) IBOutlet UIButton *btnUpload;
@property (strong, nonatomic) IBOutlet UIButton *btnCamera;
@property (strong, nonatomic) IBOutlet UILabel *lblChooseAnImage;
@property (strong, nonatomic) IBOutlet UIImageView *imgToUpload;
@property (strong, nonatomic) IBOutlet UIButton *btnPhotoAlbum;
@property (strong, nonatomic) IBOutlet UIView *vProgressUpload;
@property (strong, nonatomic) IBOutlet UIProgressView *progressUpload;

@end

@implementation UploadImageViewController

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
    [BTThemeManager customizeView:self.view];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Check which types of Image Picker Source are available
	// For example, in the simulator, we won't be able to take a new photo with the camera
	[_btnPhotoAlbum setEnabled:[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]];
	[_btnCamera setEnabled:[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]];
     [BTThemeManager customizeButton:_btnCamera];
    [BTThemeManager customizeButton:_btnPhotoAlbum];
    [BTThemeManager customizeButton:_btnUpload];

}


- (IBAction)choseImageFromPhotoAlbum:(id)sender {
	UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
}
- (IBAction)createImageWithCamera:(id)sender {
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
}

- (IBAction)uploadImage:(id)sender
{
    // Disable the Upload button to prevent multiple touches
	[_btnUpload setEnabled:NO];
    
	// Check that we have an image selected
	if (!_imgToUpload.image) {
		[[[UIAlertView alloc] initWithTitle:@"Upload Error"
									message:@"Please choose an image before uploading"
								   delegate:self
						  cancelButtonTitle:@"Ok"
						  otherButtonTitles:nil] show];
		[_btnUpload setEnabled:YES];
		return;
	}
    
	// Check that we have Item Description
	if (_itemDesc.text.length == 0) {
		[[[UIAlertView alloc] initWithTitle:@"Upload Error"
									message:@"Please provide a Item-Name for the image before uploading"
								   delegate:self
						  cancelButtonTitle:@"Ok"
						  otherButtonTitles:nil] show];
		[_btnUpload setEnabled:YES];
		return;
	}
    
	// Check that we have Item Description
	if (_itemDesc.text.length == 0) {
		[[[UIAlertView alloc] initWithTitle:@"Upload Error"
									message:@"Please provide a Item-Description for the image before uploading"
								   delegate:self
						  cancelButtonTitle:@"Ok"
						  otherButtonTitles:nil] show];
		[_btnUpload setEnabled:YES];
		return;
	}
	
	// Check that we have Item Price
	if (_itemPrice.text.length == 0) {
		[[[UIAlertView alloc] initWithTitle:@"Upload Error"
									message:@"Please provide a Price for this Item before uploading"
								   delegate:self
						  cancelButtonTitle:@"Ok"
						  otherButtonTitles:nil] show];
		[_btnUpload setEnabled:YES];
		return;
	}
    
	// Show progress
	[_vProgressUpload setHidden:NO];
    

 
    // Assemble the PFObject (Item File) to be passed to Comms
    NSArray * myDataArray = [NSArray arrayWithObjects:_itemName.text, _itemDesc.text,_itemPrice.text,
                             _itemQuantityAvailable.text, nil];
    
    
    /*
    PFObject *ItemsObject = [PFObject objectWithClassName:@"Items"];
    ItemsObject[@"number"] = @"";
    ItemsObject[@"category"]=@"";
    ItemsObject[@"name"] = @"";
    ItemsObject[@"description"]=@"";
    ItemsObject[@"price"] = @00;
    ItemsObject[@"quantityAvailable"]=@00;
    ItemsObject[@"discountrate"] = @00;
    ItemsObject[@"active"] = @NO;
    ItemsObject[@"featured"] = @NO;
    
    ItemsObject[@"image"] = self.imgToUpload.image;
    ItemsObject[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
    ItemsObject[@"user"] = [PFUser currentUser].username;
*/
	// Upload the Item to Parse (For JW Store to sell online)
    
    
      
//	[Comms uploadImage:self.imgToUpload.image withComment:txtComment forDelegate:self];
    [Comms uploadItem:self.imgToUpload.image withNSArray:myDataArray forDelegate:self];
    
}

- (void) commsUploadImageComplete:(BOOL)success
{
	// Reset the UI
	[_vProgressUpload setHidden:YES];
	[_btnUpload setEnabled:YES];
	[_lblChooseAnImage setHidden:NO];
	[_imgToUpload setImage:nil];
    
	// Did the upload work ?
	if (success) {
		[self.navigationController popViewControllerAnimated:YES];
        // Notify that a new image has been uploaded
		[[NSNotificationCenter defaultCenter] postNotificationName:N_ImageUploaded object:nil];
	} else {
		[[[UIAlertView alloc] initWithTitle:@"Upload Error"
                                    message:@"Error uploading image. Please try again."
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
	}
}

- (void) commsUploadImageProgress:(short)progress
{
	NSLog(@"Uploaded: %d%%", progress);
	[_progressUpload setProgress:(progress/100.0f)];
}


#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// We've chosen an image, so hide the hint text.
	[_lblChooseAnImage setHidden:YES];
    
	// Close the image picker
    [picker dismissViewControllerAnimated:YES completion:nil];
	
	// We're going to Scale the Image to fit the image view.
	// This is just to keep traffic size down.
    
	UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];
	[_imgToUpload setImage:[image imageScaledToFitSize:_imgToUpload.frame.size]];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

@end
