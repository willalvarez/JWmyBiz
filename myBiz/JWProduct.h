//
//  JWProduct.h
//  myBiz
//
//  Created by Will Alvarez on 12/25/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWProduct : NSObject


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemDesc;
@property (nonatomic, strong) NSNumber *itemPrice;
@property (nonatomic, strong) NSNumber *qty_Ordered;
@property (nonatomic, strong) NSNumber *itemLineTotal;


@end
