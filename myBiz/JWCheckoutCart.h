//
//  JWCheckoutCart.h
//  myBiz
//
//  Created by Will Alvarez on 12/24/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWProduct.h"

@interface JWCheckoutCart : NSObject
+ (JWCheckoutCart *)sharedInstance;

//- (NSArray*)itemsInCart;
- (NSArray*)productsInCart;
- (BOOL)containsProduct:(JWProduct*)product;
- (void)addProduct:(JWProduct*)product;
- (void)addeditedProduct:(JWProduct*)product;
- (void)replaceProduct:(JWProduct*)product;
- (void)removeProduct:(JWProduct*)product;
- (void)clearCart;

- (NSNumber*)total;
@end
