//
//  BTPrettyInPinkTheme.m
//  myBiz
//
//  Created by Will Alvarez on 1/15/14.
//

#import "BTPrettyInPinkTheme.h"

@implementation BTPrettyInPinkTheme
/*
- (UIColor*)backgroundColor {
    return [UIColor colorWithPatternImage:
            [UIImage imageNamed:@"bg_prettyinpink.png"]];
}

- (UIColor*)upperGradient{
    return [UIColor colorWithRed:0.961 green:0.878
                            blue:0.961 alpha:1.000];
}

- (UIColor*)lowerGradient {
    return [UIColor colorWithRed:0.906 green:0.827 blue:0.906 alpha:1.000];
}

- (UIColor*)separatorColor {
    return [UIColor colorWithRed:0.871 green:0.741 blue:0.878 alpha:1.000];
}

- (UIColor*)progressBarTintColor {
    return [UIColor colorWithRed:0.600 green:0.416 blue:0.612 alpha:1.000];
}

- (UIColor*)progressBarTrackTintColor {
    return [UIColor colorWithRed:0.749 green:0.561 blue:0.757 alpha:1.000];
}

- (UIColor*)switchTintColor {
    return [UIColor colorWithRed:0.749 green:0.561 blue:0.757 alpha:1.000];
}

- (UIColor*)switchThumbTintColor {
    return [UIColor colorWithRed:0.918 green:0.839 blue:0.922 alpha:1.000];
}

- (UIColor*)pageTintColor {
    return [UIColor colorWithRed:0.290 green:0.051 blue:0.302 alpha:1.000];
}

- (UIColor*)pageCurrentTintColor {
    return [UIColor colorWithRed:0.749 green:0.561 blue:0.757 alpha:1.000];
}

- (UIImage*)imageForBarButtonNormal {
    return [[UIImage imageNamed:@"barbutton_pretty_uns.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 9.0, 0.0, 9.0)];
}

- (UIImage*)imageForBarButtonHighlighted {
    return [[UIImage imageNamed:@"barbutton_pretty_sel.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 9.0, 0.0, 9.0)];
}

- (UIImage*)imageForBarButtonDoneNormal {
    return [[UIImage imageNamed:@"barbutton_pretty__done_uns.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 9.0, 0.0, 9.0)];
}

- (UIImage*)imageForBarButtonDoneHighlighted {
    return [[UIImage imageNamed:@"barbutton_pretty_done_sel.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 9.0, 0.0, 9.0)];
}



- (UIImage*)imageForBarButtonNormalLandscape {
    return [[UIImage imageNamed:@"barbutton_pretty_landscape_uns.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 7.0, 0.0, 8.0)];
}

- (UIImage*)imageForBarButtonHighlightedLandscape {
    return [[UIImage imageNamed:@"barbutton_pretty_landscape_sel.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 7.0, 0.0, 8.0)];
}

- (UIImage*)imageForBarButtonDoneNormalLandscape {
    return [[UIImage imageNamed:@"barbutton_pretty_done_landscape_uns.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 7.0, 0.0, 8.0)];
}

- (UIImage*)imageForBarButtonDoneHighlightedLandscape {
    return [[UIImage imageNamed:@"barbutton_pretty_done_landscape_sel.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 7.0, 0.0, 8.0)];
}

- (UIImage*)imageForButtonNormal {
    return [[UIImage imageNamed:@"button_pretty_uns.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 13.0, 0.0, 13.0)];
}

- (UIImage*)imageForButtonHighlighted {
    return [[UIImage imageNamed:@"button_pretty_sel.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 13.0, 0.0, 13.0)];
}

- (UIImage*)imageForNavigationBar{
    return [[UIImage imageNamed:@"nav_pretty_portrait.png"]
            resizableImageWithCapInsets: UIEdgeInsetsMake(0.0, 12.0, 0.0, 12.0)];
}

- (UIImage*)imageForNavigationBarLandscape{
    return [[UIImage imageNamed:@"nav_pretty_landscape.png"] resizableImageWithCapInsets:
            UIEdgeInsetsMake(0.0, 12.0, 0.0, 11.0)];
}
- (UIImage*)imageForNavigationBarShadow{
    return [UIImage imageNamed:@"topShadow_pretty.png"]; }
- (UIImage*)imageForSwitchOn{
    return [UIImage imageNamed:@"floweron.png"];
}

- (UIImage*)imageForSwitchOff{
    return [UIImage imageNamed:@"floweroff.png"];
}
- (UIImage*)imageForStepperUnselected{
    return [UIImage imageNamed:@"stepper_pretty_bg_uns.png"];
}
- (UIImage*)imageForStepperSelected{
    return [UIImage imageNamed:@"stepper_pretty_bg_sel.png"]; }
- (UIImage*)imageForStepperDecrement{
    return [UIImage imageNamed:@"stepper_pretty_decrement.png"];
}
- (UIImage*)imageForStepperIncrement{
    return [UIImage imageNamed:@"stepper_pretty_increment.png"]; }
- (UIImage*)imageForStepperDividerUnselected{ return [UIImage imageNamed:
                                                      @"stepper_pretty_divider_uns.png"];
}
- (UIImage*)imageForStepperDividerSelected{
    return [UIImage imageNamed: @"stepper_pretty_divider_sel.png"];
}

- (NSDictionary*)navBarTextDictionary { return @{
                                                 UITextAttributeFont:
                                                     [UIFont fontWithName:@"Arial Rounded MT Bold" size:18.0], UITextAttributeTextColor:
                                                     [UIColor colorWithRed:0.290 green:0.051 blue:0.302 alpha:1.000],
                                                 UITextAttributeTextShadowColor:
                                                     [UIColor colorWithRed:0.965 green:0.945
                                                                      blue:0.965 alpha:1.000], UITextAttributeTextShadowOffset:
                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 1)]
                                                 }; }

- (NSDictionary*)barButtonTextDictionary { return @{
                                                    UITextAttributeFont:
                                                        [UIFont fontWithName:@"Arial Rounded MT Bold" size:15.0], UITextAttributeTextColor:
                                                        [UIColor colorWithRed:0.506 green:0.314
                                                                         blue:0.510 alpha:1.000], UITextAttributeTextShadowColor:
                                                        [UIColor colorWithRed:0.965 green:0.945 blue:0.965 alpha:1.000],
                                                    UITextAttributeTextShadowOffset:
                                                        [NSValue valueWithUIOffset:UIOffsetMake(0, 1)] };
}

- (NSDictionary*)buttonTextDictionary { return @{
                                                 UITextAttributeFont:
                                                     [UIFont fontWithName:@"Arial Rounded MT Bold" size:18.0], UITextAttributeTextColor:
                                                     [UIColor colorWithRed:0.290 green:0.051 blue:0.302 alpha:1.000],
                                                 UITextAttributeTextShadowColor:
                                                     [UIColor colorWithRed:0.965 green:0.945
                                                                      blue:0.965 alpha:1.000], UITextAttributeTextShadowOffset:
                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 1)]
                                                 }; }
- (NSDictionary*)labelTextDictionary { return @{
                                                UITextAttributeFont:
                                                    [UIFont fontWithName:@"Arial Rounded MT Bold" size:18.0], UITextAttributeTextColor:
                                                    [UIColor colorWithRed:0.290 green:0.051 blue:0.302 alpha:1.000],
                                                UITextAttributeTextShadowColor:
                                                    [UIColor colorWithRed:0.965 green:0.945
                                                                     blue:0.965 alpha:1.000], UITextAttributeTextShadowOffset:
                                                    [NSValue valueWithUIOffset:UIOffsetMake(0, 1)]
                                                }; }
- (NSDictionary*)tableViewCellTextDictionary { return @{
                                                        UITextAttributeFont:
                                                            [UIFont fontWithName:@"Arial Rounded MT Bold" size:18.0], UITextAttributeTextColor:
                                                            [UIColor colorWithRed:0.290 green:0.051 blue:0.302 alpha:1.000],
                                                        UITextAttributeTextShadowColor:
                                                            [UIColor colorWithRed:0.965 green:0.945 blue:0.965 alpha:1.000],
                                                        UITextAttributeTextShadowOffset:
                                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 1)] };
}
*/
@end
