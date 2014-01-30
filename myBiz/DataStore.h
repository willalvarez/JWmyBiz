//
//  DataStore.h
//  myBiz
//
//  Created by Will Alvarez on 12/18/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WallImage : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) id objectId;
@property (nonatomic, strong) NSDictionary<FBGraphUser> *user;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemDesc;
@property (nonatomic, strong) NSNumber *itemPrice;
@property (nonatomic, strong) NSNumber *qty_Ordered;


@end

@interface DataStore : NSObject

@property (nonatomic, strong) NSMutableDictionary *fbFriends;
@property (nonatomic, strong) NSMutableArray *wallImages;
@property (nonatomic, strong) NSMutableDictionary *wallImageMap;
//@property (nonatomic, strong) NSMutableArray *itemsInCart;
@property (nonatomic, strong) NSMutableArray *ordersInCart;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) NSInteger editedIndex;
@property (strong, nonatomic) NSString* FBid;


+ (DataStore *) instance;
- (void) reset;

@end

@interface itemOrdered : NSObject
@property (nonatomic, strong) NSString *ord_itemName;
@property (nonatomic, strong) NSString *ord_itemDesc;
@property (nonatomic, strong) UIImage *ord_image;
@property (nonatomic, strong) NSNumber *ord_itemPrice;
@property (nonatomic, strong) NSNumber *ord_Ordered;



+ (itemOrdered*) sharedInstance;

@end

@interface itemSelected : NSObject
@property (nonatomic, strong) NSString *sel_itemName;
@property (nonatomic, strong) NSString *sel_itemDesc;
@property (nonatomic, strong) UIImage *sel_image;
@property (nonatomic, strong) NSNumber *sel_itemPrice;
@property (nonatomic, strong) NSNumber *qty_Ordered;

+ (itemSelected*) sharedInstance;

@end

@interface shippingInfo : NSObject
@property (nonatomic, strong) NSString *shippingAddress1;
@property (nonatomic, strong) NSString *shippingAddress2;
@property (nonatomic, strong) NSString *shippingCity;
@property (nonatomic, strong) NSString *shippingState;
@property (nonatomic, strong) NSString *shippingZip;





+ (shippingInfo*) sharedInstance;

@end