//
//  ImageWallProductCell.m
//  myBiz
//
//  Created by Will Alvarez on 12/23/13.
//  Copyright (c) 2013 Will Alvarez. All rights reserved.
//

#import "ImageWallProductCell.h"
#import "BTTheme.h"
#define ROW_MARGIN 8.0f
#define ROW_HEIGHT 173.0f

@implementation ImageWallProductCell

+(Class)layerClass{
    return [[BTThemeManager sharedTheme] gradientLayer];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
        self.priceLabel.textColor = [UIColor colorWithRed:14.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        self.priceLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        self.priceLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
        self.priceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.priceLabel];
        
     
        
        self.orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.orderButton setTitle:NSLocalizedString(@"Order", @"Order") forState:UIControlStateNormal];
        self.orderButton.titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        self.orderButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -0.5f);
        self.orderButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        
        UIImage *orderImage = [UIImage imageNamed:@"ButtonOrder.png"];
        UIImage *orderPressedImage = [UIImage imageNamed:@"ButtonOrderPressed.png"];
        UIEdgeInsets insets = UIEdgeInsetsMake(orderImage.size.height/2, orderImage.size.width/2, orderImage.size.height/2, orderImage.size.width/2);
        [self.orderButton setBackgroundImage:[orderImage resizableImageWithCapInsets:insets] forState:UIControlStateNormal];
        [self.orderButton setBackgroundImage:[orderPressedImage resizableImageWithCapInsets:insets] forState:UIControlStateHighlighted];
        [self addSubview:self.orderButton];



    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews {
    CGFloat x = ROW_MARGIN;
    CGFloat y = ROW_MARGIN;
    self.backgroundView.frame = CGRectMake(x, y, self.frame.size.width - ROW_MARGIN*2.0f, 167.0f);
    x += 10.0f;
    
    self.imageView.frame = CGRectMake(x, y + 1.0f, 120.0f, 165.0f);
 //// Moved by Will
    
    x += 120.0f + 5.0f;
    y += 10.0f;
 /*
    [self.priceLabel sizeToFit];
    CGFloat priceX = self.frame.size.width - self.priceLabel.frame.size.width - ROW_MARGIN - 10.0f;
    self.priceLabel.frame = CGRectMake(priceX, ROW_MARGIN + 10.0f, self.priceLabel.frame.size.width, self.priceLabel.frame.size.height);
     */
//// moved
    y = self.sizeButton ? 45.0f : 55.0f;
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = CGRectMake(x + 2.0f, y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    y += self.textLabel.frame.size.height + 2.0f;
    
    if (self.sizeButton) {
        self.sizeButton.frame = CGRectMake(x, y, 157.0f, 40.0f);
        y += self.sizeButton.frame.size.height + 5.0f;
    } else {
        y += 6.0f;
    }
    
    y+=40; // Will's changes
    //x+=55;
    self.orderButton.frame = CGRectMake(x, y, 80.0f, 35.0f);
    
    /////// Will moved priceLabel here
    [self.priceLabel sizeToFit];
    CGFloat priceX = self.frame.size.width - self.priceLabel.frame.size.width - ROW_MARGIN - 10.0f;
   // self.priceLabel.frame = CGRectMake(priceX, ROW_MARGIN + 10.0f, self.priceLabel.frame.size.width, self.priceLabel.frame.size.height);
    self.priceLabel.frame = CGRectMake(priceX, y, self.priceLabel.frame.size.width, self.priceLabel.frame.size.height);

    //////
}


#pragma mark - UITableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.sizeButton removeFromSuperview];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
