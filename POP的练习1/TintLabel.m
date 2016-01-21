//
//  TintLabel.m
//  自带动画的控件
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "TintLabel.h"

@implementation TintLabel

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.textColor = self.tintColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
