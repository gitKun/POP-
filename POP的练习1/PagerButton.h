//
//  PagerButton.h
//  POP的练习1
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagerButton : UIControl
{
    @public
    CGFloat PagerButtonAnimationDuration;
}

+ (instancetype)pagerButton;
+ (instancetype)pagerButtonWithOrigine:(CGPoint)origin;

@end
