//
//  ItemOrdered.h
//  myBiz
//
//  Created by Will Alvarez on 12/28/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemOrdered : NSObject
@property (nonatomic, strong) NSString *ord_itemName;
@property (nonatomic, strong) NSString *ord_itemDesc;
@property (nonatomic, strong) UIImage *ord_image;
@property (nonatomic, strong) NSNumber *ord_itemPrice;
@property (nonatomic, strong) NSNumber *ord_Ordered;

@end
