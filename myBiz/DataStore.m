//
//  DataStore.m
//  myBiz
//
//  Created by Will Alvarez on 12/18/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "DataStore.h"

@implementation WallImage
- (id) init
{
    self = [super init];
    if (self) {
        // Init array of comments
       // _comments = [[NSMutableArray alloc] init];
    }
    return self;
}
@end


@implementation DataStore

static DataStore *instance = nil;
+ (DataStore *) instance
{
    @synchronized (self) {
        if (instance == nil) {
            instance = [[DataStore alloc] init];
        }
    }
    return instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        _fbFriends = [[NSMutableDictionary alloc] init];
        _wallImages = [[NSMutableArray alloc] init];
        _wallImageMap = [[NSMutableDictionary alloc] init];
        _ordersInCart = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void) reset
{
    [_fbFriends removeAllObjects];
    [_wallImages removeAllObjects];
    [_wallImageMap removeAllObjects];
    [_ordersInCart removeAllObjects];
    
}

@end

@implementation itemSelected


+ (itemSelected*) sharedInstance {
    static itemSelected *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
    }
    return myInstance;
}
@end

@implementation shippingInfo


+ (shippingInfo*) sharedInstance {
    static shippingInfo *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
    }
    return myInstance;
}
@end

@implementation itemOrdered


+ (itemOrdered*) sharedInstance {
    static itemOrdered *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
    }
    return myInstance;
}
@end