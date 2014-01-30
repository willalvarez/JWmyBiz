//
//  BTTheme.m
//  myBiz
//
//  Created by Will Alvarez on 1/14/14.
//

#import "BTTheme.h" 
#import "BTDefaultTheme.h"
@implementation BTThemeManager static id<BTTheme> _theme = nil;
+ (id<BTTheme>)sharedTheme { return _theme;
}
+ (void)setSharedTheme:(id<BTTheme>)inTheme { _theme = inTheme;
    [self applyTheme];
    
}
+ (void)applyTheme {id<BTTheme>
    theme = [self sharedTheme];
    
    // Navigation Bar
    
    UINavigationBar *NavBarAppearance = [UINavigationBar appearance];
    [NavBarAppearance setBackgroundImage:[theme imageForNavigationBar] forBarMetrics:UIBarMetricsDefault];
    [NavBarAppearance setBackgroundImage:[theme imageForNavigationBarLandscape] forBarMetrics:UIBarMetricsLandscapePhone];
    [NavBarAppearance setTitleTextAttributes:[theme navBarTextDictionary]];
    //Theme change is hard-coded for now, use this on PHASE TO (if you want configurable THEME for clients)
    /*
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification
                                                            notificationWithName:kThemeChange object:nil]];
     */
    [NavBarAppearance setShadowImage:[theme imageForNavigationBarShadow]];
    
    // UIButtons customization methods
    
    UIBarButtonItem* barButton = [UIBarButtonItem appearance];
    [barButton setBackgroundImage:[theme imageForBarButtonNormal] forState:UIControlStateNormal
                       barMetrics:UIBarMetricsDefault]; [barButton setBackgroundImage:[theme
                                                                                       imageForBarButtonHighlighted] forState:UIControlStateHighlighted
                                                                           barMetrics:UIBarMetricsDefault]; [barButton setBackgroundImage:[theme
                                                                                                                                           imageForBarButtonNormalLandscape] forState:UIControlStateNormal
                                                                                                                               barMetrics:UIBarMetricsLandscapePhone];
    [barButton setBackgroundImage:[theme imageForBarButtonHighlightedLandscape]
                         forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
    [barButton setBackgroundImage:[theme imageForBarButtonDoneNormal]
                         forState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault];
    [barButton setBackgroundImage:[theme imageForBarButtonDoneHighlighted]
                         forState:UIControlStateHighlighted style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault];
    [barButton setBackgroundImage:[theme imageForBarButtonDoneNormalLandscape]
                         forState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsLandscapePhone];
    [barButton setBackgroundImage:[theme imageForBarButtonDoneHighlightedLandscape]
                         forState:UIControlStateHighlighted style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsLandscapePhone];
    [barButton setTitleTextAttributes:[theme barButtonTextDictionary]
                             forState:UIControlStateNormal];
    [barButton setTitleTextAttributes:[theme barButtonTextDictionary]
                             forState:UIControlStateNormal];
    
}


- (UIColor*)backgroundColor {
    return [UIColor whiteColor];
}

+ (void)customizeView:(UIView *)view {
    id <BTTheme> theme = [self sharedTheme];
    UIColor *backgroundColor = [theme backgroundColor]; [view setBackgroundColor:backgroundColor];
}

+ (void)customizeNavigationBar:(UINavigationBar *)navigationBar { id <BTTheme> theme = [self sharedTheme];
    [navigationBar setBackgroundImage:[theme imageForNavigationBar] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundImage:[theme imageForNavigationBarLandscape] forBarMetrics:UIBarMetricsLandscapePhone];
    [navigationBar setTitleTextAttributes:[theme navBarTextDictionary]];
    [navigationBar setShadowImage:[theme imageForNavigationBarShadow]];
}

+ (void)customizeButton:(UIButton*)button { id <BTTheme> theme = [self sharedTheme];
    [button setTitleColor:
     [theme buttonTextDictionary][NSForegroundColorAttributeName]
                 forState:UIControlStateNormal]; [[button titleLabel] setFont:
                                                  [theme buttonTextDictionary][NSFontAttributeName]]; [button setBackgroundImage:
                                                                                                       [theme imageForButtonNormal]? [theme imageForButtonNormal] : nil
                                                                                                                        forState:UIControlStateNormal]; [button setBackgroundImage:
                                                                                                                                                         [theme imageForButtonHighlighted]? [theme imageForButtonHighlighted]:nil
                                                                                                                                                                          forState:UIControlStateHighlighted];
}

+ (void)customizeTableViewCell:(UITableViewCell*)tableViewCell { id <BTTheme> theme = [self sharedTheme];
    [[tableViewCell textLabel] setTextColor:
     [theme tableViewCellTextDictionary][NSForegroundColorAttributeName]];
    [[tableViewCell textLabel] setFont:
     [theme tableViewCellTextDictionary][NSFontAttributeName]];
}


@end