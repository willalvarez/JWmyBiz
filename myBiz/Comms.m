//
//  Comms.m
//  myBiz
//
//  Created by Will Alvarez on 12/16/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "Comms.h"
#import "NSOperationQueue+SharedQueue.h"

NSString * const N_ImageDownloaded = @"N_ImageDownloaded";
NSString * const N_ImageUploaded = @"N_ImageUploaded";

@implementation Comms

+ (void) login:(id<CommsDelegate>)delegate
{
	// Basic User information and your friends are part of the standard permissions
	// so there is no reason to ask for additional permissions
	[PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
		// Was login successful ?
		if (!user) {
			if (!error) {
                NSLog(@"The user cancelled the Facebook login.");
            } else {
                NSLog(@"An error occurred: %@", error.localizedDescription);
            }
            
			// Callback - login failed
			if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
				[delegate commsDidLogin:NO];
			}
		} else {
			if (user.isNew) {
				NSLog(@"User signed up and logged in through Facebook!");
			} else {
				NSLog(@"User logged in through Facebook!");
			}
            
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
                    // Store the Facebook Id
                    [[PFUser currentUser] setObject:me.id forKey:@"fbId"];
                    [[PFUser currentUser] saveInBackground];
                    [DataStore instance].FBid = me.id;
                    // 1
                    FBRequest *friendsRequest = [FBRequest requestForMyFriends];
                    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                  NSDictionary* result,
                                                                  NSError *error) {
                        // 2
                        NSArray *friends = result[@"data"];
                        for (NSDictionary<FBGraphUser>* friend in friends) {
                          //  NSLog(@"Found a friend: %@", friend.name);
                            // 3
                            // Add the friend to the list of friends in the DataStore
                            [[DataStore instance].fbFriends setObject:friend forKey:friend.id];
                        }
                        
                        // 4
                        // Callback - login successful
                        if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
                            [delegate commsDidLogin:YES];
                        }
                    }];
                    // Add the User to the list of friends in the DataStore
                    [[DataStore instance].fbFriends setObject:me forKey:me.id];
                }
                
             }];
		}
	}];
}

+ (void) uploadImage:(UIImage *)image withComment:(NSString *)comment forDelegate:(id<CommsDelegate>)delegate
{
    // 1
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // 2
    PFFile *imageFile = [PFFile fileWithName:@"img" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 3
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
            
            ItemsObject[@"image"] = imageFile;
            ItemsObject[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
            ItemsObject[@"user"] = [PFUser currentUser].username;
            
            [ItemsObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // 4
                    PFObject *ItemsCommentObject = [PFObject objectWithClassName:@"ItemsComment"];
                    ItemsCommentObject[@"comment"] = comment;
                    ItemsCommentObject[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
                    ItemsCommentObject[@"user"] = [PFUser currentUser].username;
                    ItemsCommentObject[@"imageObjectId"] = ItemsObject.objectId;
                    
                    [ItemsCommentObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        // 5
                        if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                            [delegate commsUploadImageComplete:YES];
                        }
                    }];
                } else {
                    // 6
                    if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                        [delegate commsUploadImageComplete:NO];
                    }
                }
            }];
        } else {
            // 7
            if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                [delegate commsUploadImageComplete:NO];
            }
        }
    } progressBlock:^(int percentDone) {
        // 8
        if ([delegate respondsToSelector:@selector(commsUploadImageProgress:)]) {
            [delegate commsUploadImageProgress:percentDone];
        }
    }];
}

+ (void) uploadItem:(UIImage *)image withNSArray:(NSArray *)myDataArray forDelegate:(id<CommsDelegate>)delegate
{
    // 1
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // 2
    PFFile *imageFile = [PFFile fileWithName:@"img" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 3
            PFObject *ItemsObject = [PFObject objectWithClassName:@"Items"];
            ItemsObject[@"number"] = @"";
            ItemsObject[@"category"]=@"";
  
 
         
            ItemsObject[@"name"] = myDataArray[0];
            ItemsObject[@"description"] = myDataArray[1];
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber * myNumber = [f numberFromString:myDataArray[2]];
            ItemsObject[@"price"] = myNumber;
            myNumber = [f numberFromString:myDataArray[3]];
            ItemsObject[@"quantityAvailable"]=myNumber;
            ItemsObject[@"discountrate"] = @00;
            ItemsObject[@"active"] = @YES;
            ItemsObject[@"featured"] = @NO;
            
            ItemsObject[@"image"] = imageFile;
            ItemsObject[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
            ItemsObject[@"user"] = [PFUser currentUser].username;
            
            [ItemsObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // 4
                    PFObject *ItemsCommentObject = [PFObject objectWithClassName:@"ItemsComment"];
//                    ItemsCommentObject[@"comment"] = comment;
                    ItemsCommentObject[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
                    ItemsCommentObject[@"user"] = [PFUser currentUser].username;
                    ItemsCommentObject[@"imageObjectId"] = ItemsObject.objectId;
                    
                    [ItemsCommentObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        // 5
                        if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                            [delegate commsUploadImageComplete:YES];
                        }
                    }];
                } else {
                    // 6
                    if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                        [delegate commsUploadImageComplete:NO];
                    }
                }
            }];
        } else {
            // 7
            if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                [delegate commsUploadImageComplete:NO];
            }
        }
    } progressBlock:^(int percentDone) {
        // 8
        if ([delegate respondsToSelector:@selector(commsUploadImageProgress:)]) {
            [delegate commsUploadImageProgress:percentDone];
        }
    }];
}

+ (void) getWallImagesSince:(NSDate *)lastUpdate forDelegate:(id<CommsDelegate>)delegate
{
	// 1
	// Get the complete list of friend ids
	//NSArray *meAndMyFriends = [DataStore instance].fbFriends.allKeys;
    
	// 2
	// Create a PFQuery, Parse Query object
	PFQuery *imageQuery = [PFQuery queryWithClassName:@"Items"];
	[imageQuery orderByAscending:@"createdAt"];
	[imageQuery whereKey:@"updatedAt" greaterThan:lastUpdate];
//	[imageQuery whereKey:@"userFBId" containedIn:meAndMyFriends];
	[imageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		// 3
		__block NSDate *newLastUpdate = lastUpdate;
        
		if (error) {
			NSLog(@"Objects error: %@", error.localizedDescription);
		} else {
			// 4
			// Go through the returned PFObjects
			[objects enumerateObjectsUsingBlock:^(PFObject *wallImageObject, NSUInteger idx, BOOL *stop) {
				// 5
				// Get the Facebook User Id of the user that uploaded the image
				NSDictionary<FBGraphUser> *user = [[DataStore instance].fbFriends objectForKey:wallImageObject[@"userFBId"]];
                
				// 6
				// Construct a WallImage object
				WallImage *wallImage = [[WallImage alloc] init];
				wallImage.objectId = wallImageObject.objectId;
				wallImage.user = user;
				wallImage.createdDate = wallImageObject.updatedAt;
                
				[[NSOperationQueue pffileOperationQueue] addOperationWithBlock:^ {
                    wallImage.image = [UIImage imageWithData:[(PFFile *)wallImageObject[@"image"] getData]];
                    NSString *itemName = [wallImageObject objectForKey:@"name"];
                    wallImage.itemName = itemName;
                    NSString *itemDesc = [wallImageObject objectForKey:@"description"];
                    wallImage.itemDesc = itemDesc;
                    NSNumber *itemPrice = [wallImageObject objectForKey:@"price"];
                    wallImage.itemPrice = itemPrice;
                    
                    // Notify - Image Downloaded from Parse
                    [[NSNotificationCenter defaultCenter] postNotificationName:N_ImageDownloaded object:nil];
                    
                }];
                
				// 7
				// Update the last update timestamp with the most recent update
				if ([wallImageObject.updatedAt compare:newLastUpdate] == NSOrderedDescending) {
					newLastUpdate = wallImageObject.updatedAt;
				}
                
				// 8
				// Store the WallImage object in the DataStore collections
				[[DataStore instance].wallImages insertObject:wallImage atIndex:0];
				[[DataStore instance].wallImageMap setObject:wallImage forKey:wallImage.objectId];
			}];
		}
        
		// Callback
		if ([delegate respondsToSelector:@selector(commsDidGetNewWallImages:)]) {
			[delegate commsDidGetNewWallImages:newLastUpdate];
		}
	}];
}

@end





