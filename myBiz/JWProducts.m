//
//  JWProducts.m
//  myBiz
//
//  Created by Will Alvarez on 12/30/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "JWProducts.h"
#import "JWProduct.h"

@implementation JWProducts
+ (JWProducts *)sharedInstance {
    static JWProducts*  _sharedProducts;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedProducts = [[JWProducts alloc] init];
    });
    
    return _sharedProducts;
}

- (id)init
{
    if((self = [super init]))
    {
        _allProducts = [self loadProductsFromDataStore];
    }
    return self;
}

- (NSArray *)loadProductsFromDataStore {
    /*  JW
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"dogs" ofType:@"json"];
    
    NSError* error;
    NSData* jsonData =  [NSData dataWithContentsOfFile:filePath options:NSDataReadingUncached error:&error];
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    */
    NSArray* datastoreArray = [DataStore instance].wallImages;
    NSMutableArray* productArray = [[NSMutableArray alloc] initWithCapacity:datastoreArray.count];

    
    
    //:NOTE TO Will:Replace this with JWProduct.h fields
    for (NSDictionary* productDictionary in datastoreArray) {
        
        JWProduct* product = [[JWProduct alloc] init];
        product.image = productDictionary[@"image"];
        product.itemName = productDictionary[@"itemName"];
        product.itemDesc = productDictionary[@"itemDesc"];
        /*
        puppy.ID = puppyDictionary[@"id"];
        puppy.name = puppyDictionary[@"name"];
        puppy.breedName = puppyDictionary[@"breed"];
        puppy.photoURL = puppyDictionary[@"photo-large"];
        puppy.maxHeight = puppyDictionary[@"max_weight"];
        puppy.maxWeight = puppyDictionary[@"max_height"];
        puppy.cuddleFactor = puppyDictionary[@"cuddle_factor"];
        puppy.price = puppyDictionary[@"price"];
         */
        [productArray addObject:product];
    }
    
    return productArray;
}

@end
