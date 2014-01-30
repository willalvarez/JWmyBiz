//
//  CheckoutProductCell.m
//  myBiz
//
//  Created by Will Alvarez on 12/31/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "CheckoutProductCell.h"



@implementation CheckoutProductCell

#define ROW_MARGIN 8.0f
#define ROW_HEIGHT 173.0f

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /*
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
        self.priceLabel.textColor = [UIColor colorWithRed:14.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        self.priceLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        self.priceLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
        self.priceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.priceLabel];
        */
        
        
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews {
    CGFloat x = ROW_MARGIN;
    CGFloat y = ROW_MARGIN;
    self.backgroundView.frame = CGRectMake(x, y, self.frame.size.width - ROW_MARGIN*2.0f, 167.0f);
    x += 10.0f;
    
    self.imageView.frame = CGRectMake(x, y + 1.0f, 100.0f, 145.0f);
    
    x += 120.0f + 5.0f;
    y += 30.0f;
    
     [self.priceLabel sizeToFit];
     CGFloat priceX = self.frame.size.width - self.priceLabel.frame.size.width - ROW_MARGIN - 10.0f;
     self.priceLabel.frame = CGRectMake(priceX, ROW_MARGIN + 10.0f, 30, self.priceLabel.frame.size.height);
 /*
    // qty_Ordered
    x += 120.0f + 5.0f;
    y += 30.0f;
    
    [self.qty_Ordered sizeToFit];
    CGFloat priceQ = self.frame.size.width - self.qty_Ordered.frame.size.width - ROW_MARGIN - 10.0f;
    self.qty_Ordered.frame = CGRectMake(priceQ, ROW_MARGIN + 10.0f, self.qty_Ordered.frame.size.width, self.qty_Ordered.frame.size.height);
*/
  }


#pragma mark - UITableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}






@end
