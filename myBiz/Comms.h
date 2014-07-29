//
//  Comms.h
//  myBiz
//
//  Created by Will Alvarez on 12/16/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

extern NSString * const N_ImageDownloaded;
extern NSString * const N_ProfilePictureLoaded;
extern NSString * const N_CommentUploaded;
extern NSString * const N_ImageUploaded;


@protocol CommsDelegate <NSObject>
@optional
//- (void) commsDidLogin:(BOOL)loggedIn;
- (void) commsUploadImageProgress:(short)progress;
- (void) commsUploadImageComplete:(BOOL)success;
- (void) commsDidGetNewWallImages:(NSDate *)updated;
- (void) commsDidGetNewWallImageComments:(NSDate *)updated;
@end

@interface Comms : NSObject

//+ (void) login:(id<CommsDelegate>)delegate;
+ (void) uploadImage:(UIImage *)image withComment:(NSString *)comment forDelegate:(id<CommsDelegate>)delegate;
+ (void) uploadItem:(UIImage *)image withNSArray:(NSArray *)myDataArray forDelegate:(id<CommsDelegate>)delegate;
+ (void) getWallImagesSince:(NSDate *)lastUpdate forDelegate:(id<CommsDelegate>)delegate;
//+ (void) getWallImageCommentsSince:(NSDate *)lastUpdate forDelegate:(id<CommsDelegate>)delegate;
//+ (void) shareImage:(UIImage *)image;

@end
