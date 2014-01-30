//
//  BTDefaultTheme.m
//  myBiz
//
//  Created by Will Alvarez on 1/14/14.
//

#import "BTDefaultTheme.h"

@implementation BTDefaultTheme



- (UIColor*)backgroundColor { return [UIColor whiteColor];};
- (UIImage*)imageForNavigationBar{return nil;}
- (UIImage*)imageForNavigationBarLandscape{return nil;}
- (NSDictionary*)navBarTextDictionary { return nil; }
- (UIImage*)imageForNavigationBarShadow{return nil;}
// UInavBarButton defaults
- (UIImage*)imageForBarButtonNormal { return nil; }
- (UIImage*)imageForBarButtonHighlighted { return nil; }
- (UIImage*)imageForBarButtonNormalLandscape { return nil; }
- (UIImage*)imageForBarButtonHighlightedLandscape {return nil;}
- (UIImage*)imageForBarButtonDoneNormal { return nil; }
- (UIImage*)imageForBarButtonDoneHighlighted { return nil; }
- (UIImage*)imageForBarButtonDoneNormalLandscape { return nil; }
- (UIImage*)imageForBarButtonDoneHighlightedLandscape
{ return nil; }




- (NSDictionary*)barButtonTextDictionary { return @{
                                                    NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f],
                                                    NSForegroundColorAttributeName:[UIColor whiteColor]};
}


// UIButton items
- (NSDictionary*)buttonTextDictionary { return nil; }
- (UIImage*)imageForButtonNormal { return nil; }
- (UIImage*)imageForButtonHighlighted { return nil; }

// Gradient layer
- (UIColor*)upperGradient{ return [UIColor whiteColor];
}
- (UIColor*)lowerGradient {
    return [UIColor whiteColor]; }
- (UIColor*)seperatorColor { return [UIColor blackColor];
}
- (Class)gradientLayer {
    return [BTGradientLayer class]; }
- (NSDictionary*)tableViewCellTextDictionary { return @{
                                                        NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0] };
}

@end



@implementation BTGradientLayer - (id)init{
    
    if(self = [super init]) {
        UIColor *colorOne = [[BTThemeManager sharedTheme]
                             upperGradient]; UIColor *colorTwo = [[BTThemeManager sharedTheme]
                                                                  lowerGradient]; UIColor *colorThree = [[BTThemeManager sharedTheme]
                                                                                                         seperatorColor];
        NSArray *colors = [NSArray arrayWithObjects: (id)colorOne.CGColor, colorTwo.CGColor,
                           colorThree.CGColor, nil];
        self.colors = colors;
        NSNumber *stopOne = [NSNumber numberWithFloat:0.0]; NSNumber *stopTwo = [NSNumber numberWithFloat:0.98]; NSNumber *stopThree = [NSNumber numberWithFloat:1.0];
        NSArray *locations = [NSArray arrayWithObjects: stopOne,
                              stopTwo, stopThree, nil];
        self.locations = locations;
        self.startPoint = CGPointMake(0.5, 0.0);
        self.endPoint = CGPointMake(0.5, 1.0); }
    return self; }

@end


