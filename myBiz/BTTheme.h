//
//  BTTheme.h
//  myBiz
//
//  Created by Will Alvarez on 1/14/14.
//

#import <Foundation/Foundation.h>

@protocol BTTheme

// VC backgroundColor customization
- (UIColor*)backgroundColor;

// Navigation Bar customization
- (UIImage*)imageForNavigationBar;
- (UIImage*)imageForNavigationBarLandscape;
- (NSDictionary*)navBarTextDictionary;
- (UIImage*)imageForNavigationBarShadow;

// navBar Buttons customization
- (UIImage*)imageForBarButtonNormal;
- (UIImage*)imageForBarButtonHighlighted;
- (UIImage*)imageForBarButtonNormalLandscape;
- (UIImage*)imageForBarButtonHighlightedLandscape;
- (UIImage*)imageForBarButtonDoneNormal;
- (UIImage*)imageForBarButtonDoneHighlighted;
- (UIImage*)imageForBarButtonDoneNormalLandscape;
- (UIImage*)imageForBarButtonDoneHighlightedLandscape;
- (NSDictionary*)barButtonTextDictionary;

// Buttons
- (NSDictionary*)buttonTextDictionary;
- (UIImage*)imageForButtonNormal;
- (UIImage*)imageForButtonHighlighted;

// UITableViewCell Gradient layers
- (UIColor*)upperGradient;
- (UIColor*)lowerGradient;
- (UIColor*)seperatorColor;
- (Class)gradientLayer;
- (NSDictionary*)tableViewCellTextDictionary;

@end

@interface BTThemeManager : NSObject
+ (id<BTTheme>)sharedTheme;
+ (void)setSharedTheme:(id<BTTheme>)inTheme; + (void)applyTheme;
+ (void)customizeView:(UIView *)view;
+ (void)customizeNavigationBar:(UINavigationBar *)navigationBar;
+ (void)customizeButton:(UIButton*)button;
+ (void)customizeTableViewCell:(UITableViewCell*)tableViewCell;
@end