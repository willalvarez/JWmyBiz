//
//  JWCheckoutCart.m
//  myBiz
//
//  Created by Will Alvarez on 12/24/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "JWCheckoutCart.h"
#import "JWProduct.h"


@interface JWCheckoutCart()

@property (strong, nonatomic) NSMutableArray* itemsArray;
@property (strong, nonatomic) NSMutableArray* productsArray;
@property (strong, nonatomic) JWProduct *newproduct;
@property (strong, nonatomic) NSNumber* eidx;

@end


@implementation JWCheckoutCart
- (id)init {
    self = [super init];
    if (self) {
        //Custom initialization
       // self.itemsArray = [[NSMutableArray alloc] init];
        self.productsArray = [[NSMutableArray alloc] init];
    
    }
    return self;
}


+ (JWCheckoutCart *)sharedInstance {
    static JWCheckoutCart*  _sharedCart;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedCart = [[JWCheckoutCart alloc] init];
    });
    
    return _sharedCart;
}

- (NSArray*)itemsInCart {
    return self.itemsArray;
}

- (NSArray*)productsInCart {
    return self.productsArray;
}


- (BOOL)containsProduct:(JWProduct*)product {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"itemName=%@", product.itemName];
    NSArray* duplicateProducts = [self.productsArray filteredArrayUsingPredicate:predicate];
    return (duplicateProducts.count > 0) ? YES : NO;
}



- (void)addProduct:(JWProduct*)product {
    if (![self containsProduct:product]) {
        // qty_Ordered defaults to 1
        NSNumber *one = [[NSNumber alloc] initWithInteger:1];
        product.qty_Ordered = one;
        [self.productsArray addObject:product];
    }
}

- (void)addeditedProduct:(JWProduct*)product {
    if (![self containsProduct:product]) {
        [self.productsArray addObject:product];
    }
}

- (void)replaceProduct:(JWProduct*)product {
    
        NSInteger x = [DataStore instance].editedIndex;
        [self.productsArray replaceObjectAtIndex:x withObject:product];
}

- (void)removeProduct:(JWProduct*)product {
    [self.productsArray removeObject:product];
}


- (void)clearCart {
    self.productsArray = [[NSMutableArray alloc] init];
}

- (NSNumber*)total {
    
    double total = 0.0;
    for (JWProduct* product in self.productsInCart) {
        //total += [product.itemPrice doubleValue];
        double unitPrice = [product.itemPrice doubleValue];
        double qtyOrd    = [product.qty_Ordered doubleValue];
        double lineTotal = unitPrice * qtyOrd;
        total += lineTotal;
    }
    return @(total);
}

@end
