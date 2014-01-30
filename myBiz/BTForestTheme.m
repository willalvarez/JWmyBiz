//
//  BTForestTheme.m
//  myBiz
//
//  Created by Will Alvarez on 1/14/14.
//

#import "BTForestTheme.h"

@implementation BTForestTheme

- (UIColor*)backgroundColor {
    return [UIColor colorWithPatternImage:
			[UIImage imageNamed:@"bg_forest.png"]];
}

- (UIImage*)imageForNavigationBar {
    return [[UIImage imageNamed:@"nav_forest_portrait.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 100.0, 0.0, 100.0)];
}
- (UIImage*)imageForNavigationBarLandscape{
    return [[UIImage imageNamed:@"nav_forest_landscape.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 100.0, 0.0, 100.0)];
}



- (NSDictionary*)navBarTextDictionary { return @{
                                                 NSFontAttributeName:[UIFont fontWithName:@"Optima" size:24.0], NSForegroundColorAttributeName:
                                                     [UIColor colorWithRed:0.910 green:0.914 blue:0.824
                                                                     alpha:1.000]
                                                 };
}

-(UIImage*)imageForNavigationBarShadow{
	return [UIImage imageNamed:@"topShadow_forest.png"];
}

- (UIImage*)imageForBarButtonNormal {
	return [[UIImage imageNamed:@"barbutton_forest_uns.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (UIImage*)imageForBarButtonHighlighted {
	return [[UIImage imageNamed:@"barbutton_forest_sel.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (UIImage*)imageForBarButtonDoneNormal {
	return [[UIImage imageNamed:@"barbutton_forest_done_uns.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (UIImage*)imageForBarButtonDoneHighlighted {
	return [[UIImage imageNamed:@"barbutton_forest_done_sel.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (UIImage*)imageForBarButtonNormalLandscape {
	return [[UIImage imageNamed:
			 @"barbutton_forest_landscape_uns.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (UIImage*)imageForBarButtonHighlightedLandscape {
	return [[UIImage imageNamed:
			 @"barbutton_forest_landscape_sel.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (UIImage*)imageForBarButtonDoneNormalLandscape {
	return [[UIImage imageNamed:
			 @"barbutton_forest_done_landscape_uns.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (UIImage*)imageForBarButtonDoneHighlightedLandscape {
	return [[UIImage imageNamed:
			 @"barbutton_forest_done_landscape_sel.png"]
			resizableImageWithCapInsets:UIEdgeInsetsMake(
														 0.0, 5.0, 0.0, 5.0)]; }
- (NSDictionary*)barButtonTextDictionary  {
	return @{
             NSFontAttributeName:[UIFont fontWithName:@"Optima" size:18.0],
             NSForegroundColorAttributeName:[UIColor colorWithRed:0.965 green:0.976
                                                       blue:0.875 alpha:1.000]
             };
}

- (UIColor*)pageTintColor {
	return [UIColor colorWithRed:0.973 green:0.984
							blue:0.875 alpha:1.000];
}

- (UIColor*)pageCurrentTintColor {
	return [UIColor colorWithRed:0.063 green:0.169
							blue:0.071 alpha:1.000];
}

- (UIImage*)imageForStepperUnselected{
	return [UIImage imageNamed:@"stepper_forest_bg_uns.png"];
}
- (UIImage*)imageForStepperSelected{
	return [UIImage imageNamed:@"stepper_forest_bg_sel.png"];
}
- (UIImage*)imageForStepperDecrement{
	return [UIImage imageNamed:@"stepper_forest_decrement.png"];
}
- (UIImage*)imageForStepperIncrement{
	return [UIImage imageNamed:@"stepper_forest_increment.png"];
}
- (UIImage*)imageForStepperDividerUnselected{
	return [UIImage imageNamed:@"stepper_forest_divider_uns.png"];
}
- (UIImage*)imageForStepperDividerSelected{
	return [UIImage imageNamed:@"stepper_forest_divider_sel.png"];
}

- (UIColor*)switchOnTintColor {
    return [UIColor colorWithRed:0.192 green:0.298
                            blue:0.200 alpha:1.000];
}
- (UIColor*)switchThumbTintColor {
    return [UIColor colorWithRed:0.643 green:0.749
                            blue:0.651 alpha:1.000];
}
- (UIImage*)imageForSwitchOn{
    return [UIImage imageNamed:@"tree_on.png"];
}
- (UIImage*)imageForSwitchOff{
    return [UIImage imageNamed:@"tree_off.png"];
}

- (UIColor*)progressBarTintColor {
    return [UIColor colorWithRed:0.200 green:0.345
                            blue:0.212 alpha:1.000];
}
- (UIColor*)progressBarTrackTintColor {
    return [UIColor colorWithRed:0.541 green:0.647
                            blue:0.549 alpha:1.000];
}

- (NSDictionary*)labelTextDictionary  {
	return @{
             NSFontAttributeName:[UIFont fontWithName:@"Optima"
                                                 size:18.0],
             NSForegroundColorAttributeName:[UIColor colorWithRed:0.965
                                                      green:0.976 blue:0.875 alpha:1.000]
             };
}

- (NSDictionary*)buttonTextDictionary  {
	return @{
             NSFontAttributeName:[UIFont fontWithName:@"Optima" size:15.0],
             NSForegroundColorAttributeName:
                 [UIColor colorWithRed:0.965 green:0.976
                                  blue:0.875 alpha:1.000]
             };
}
- (UIImage*)imageForButtonNormal {
    return [[UIImage imageNamed:@"button_forest_uns.png"]
            resizableImageWithCapInsets:
            UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)];
}
- (UIImage*)imageForButtonHighlighted {
    return [[UIImage imageNamed:@"button_forest_sel.png"]
            resizableImageWithCapInsets:
            UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)];
}

//UITableviewcell customizations

- (UIColor*)upperGradient{
    return [UIColor colorWithRed:0.976 green:0.976
                            blue:0.937 alpha:1.000];
}
- (UIColor*)lowerGradient {
    return [UIColor colorWithRed:0.969 green:0.976
                            blue:0.878 alpha:1.000];
}
- (UIColor*)seperatorColor {
    return [UIColor colorWithRed:0.753 green:0.749
                            blue:0.698 alpha:1.000];
}
- (NSDictionary*)tableViewCellTextDictionary { return @{
                                                        NSFontAttributeName:[UIFont fontWithName:@"Optima" size:24.0],
                                                        NSForegroundColorAttributeName:
                                                            [UIColor colorWithRed:0.169 green:0.169
                                                                             blue:0.153 alpha:1.000]
                                                        };
}

@end
