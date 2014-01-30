//
//  JWProducts.h
//  myBiz
//
//  Created by Will Alvarez on 12/30/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWProducts : NSObject
// This class just provides a central location for storing the available puppies

@property (strong, readonly, nonatomic) NSArray *allProducts;

+ (JWProducts *)sharedInstance;


@end
