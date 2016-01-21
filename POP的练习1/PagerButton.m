//
//  PagerButton.m
//  POP的练习1
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "PagerButton.h"
#import "POP.h"

@implementation PagerButton {
    CALayer *_topLayer;
    CALayer *_middleLayer;
    CALayer *_bottomLayer;
    BOOL _showMenu;
}

+ (instancetype)pagerButton {
    return [self pagerButtonWithOrigine:CGPointZero];
}
+ (instancetype)pagerButtonWithOrigine:(CGPoint)origin {
    return [[self alloc] initWithFrame:CGRectMake(origin.x, origin.y, 24, 17)];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)tintColorDidChange {
    CGColorRef color = [self.tintColor CGColor];
    _topLayer.backgroundColor = color;
    _middleLayer.backgroundColor = color;
    _bottomLayer.backgroundColor = color;
}

/** 生成成员变量 */
- (void)setup {
    PagerButtonAnimationDuration = PagerButtonAnimationDuration?:0.3;
    CGFloat height = 2.0;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius = 1.0;
    CGColorRef color = [self.tintColor CGColor];
    
    _topLayer = [CALayer layer];
    _topLayer.frame = CGRectMake(0, CGRectGetMinY(self.bounds), width, height);
    _topLayer.cornerRadius = cornerRadius;
    _topLayer.backgroundColor = color;
    
    _middleLayer = [CALayer layer];
    _middleLayer.frame = CGRectMake(0, CGRectGetMidY(self.bounds)-height/2, width, height);
    _middleLayer.cornerRadius = cornerRadius;
    _middleLayer.backgroundColor = color;
    
    _bottomLayer = [CALayer layer];
    _bottomLayer.frame = CGRectMake(0, CGRectGetMaxY(self.bounds)-height, width, height);
    _bottomLayer.cornerRadius = cornerRadius;
    _bottomLayer.backgroundColor = color;
    
    [self.layer addSublayer:_topLayer];
    [self.layer addSublayer:_bottomLayer];
    [self.layer addSublayer:_middleLayer];
    
    [self addTarget:self action:@selector(touchUpInsideHandler:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUpInsideHandler:(PagerButton *)sender {
    if (_showMenu) {
        [self animateToMenu];
    }else {
        [self animateToClose];
    }
    _showMenu = !_showMenu;
}
- (void)removeAllAniamtion {
    [_topLayer pop_removeAllAnimations];
    [_middleLayer pop_removeAllAnimations];
    [_bottomLayer pop_removeAllAnimations];
}

#pragma mark === 动画
- (void)animateToMenu {
    [self removeAllAniamtion];
    CGFloat height = CGRectGetHeight(_topLayer.bounds);
    
    POPBasicAnimation *fadAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadAnimation.duration = PagerButtonAnimationDuration;
    fadAnimation.toValue = @(1);
    
    POPBasicAnimation *positionTopAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.duration = PagerButtonAnimationDuration;
    positionTopAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds), roundf(CGRectGetMinY(self.bounds)+(height/2)))];
    
    POPBasicAnimation *positionBottomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionBottomAnimation.duration = PagerButtonAnimationDuration;
    positionBottomAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds), roundf(CGRectGetMaxY(self.bounds)-(height/2)))];
    
    POPSpringAnimation *transfromTopAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transfromTopAnimation.toValue = @(0);
    transfromTopAnimation.springBounciness = 20.0;
    transfromTopAnimation.springSpeed = 20;
    transfromTopAnimation.dynamicsTension = 1000;
    
    POPSpringAnimation *transfomBottomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transfomBottomAnimation.toValue = @(0);
    transfomBottomAnimation.springBounciness = 20.0;
    transfomBottomAnimation.springSpeed = 20;
    transfomBottomAnimation.dynamicsTension = 1000;
    
    [_topLayer pop_addAnimation:positionTopAnimation forKey:@"positionTopAnimation"];
    [_topLayer pop_addAnimation:transfromTopAnimation forKey:@"rotationTopAnimation"];
    [_middleLayer pop_addAnimation:fadAnimation forKey:@"fadAnimation"];
    [_bottomLayer pop_addAnimation:positionBottomAnimation forKey:@"positionBottomAnimation"];
    [_bottomLayer pop_addAnimation:transfomBottomAnimation forKey:@"rotationBottomAnimation"];
}
- (void)animateToClose {
    [self removeAllAniamtion];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    POPBasicAnimation *fadeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadeAnimation.toValue = @0;
    fadeAnimation.duration = PagerButtonAnimationDuration;
    
    POPBasicAnimation *positionTopAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionTopAnimation.duration = PagerButtonAnimationDuration;
    
    POPBasicAnimation *positionBottomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionBottomAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionTopAnimation.duration = PagerButtonAnimationDuration;
    
    POPSpringAnimation *transformTopAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformTopAnimation.toValue = @(M_PI_4);
    transformTopAnimation.springBounciness = 20.f;
    transformTopAnimation.springSpeed = 20;
    transformTopAnimation.dynamicsTension = 1000;
    
    POPSpringAnimation *transformBottomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformBottomAnimation.toValue = @(-M_PI_4);
    transformBottomAnimation.springBounciness = 20.0f;
    transformBottomAnimation.springSpeed = 20;
    transformBottomAnimation.dynamicsTension = 1000;
    
    [_topLayer pop_addAnimation:positionTopAnimation forKey:@"positionTopAnimation"];
    [_topLayer pop_addAnimation:transformTopAnimation forKey:@"rotateTopAnimation"];
    [_middleLayer pop_addAnimation:fadeAnimation forKey:@"fadeAnimation"];
    [_bottomLayer pop_addAnimation:positionBottomAnimation forKey:@"positionBottomAnimation"];
    [_bottomLayer pop_addAnimation:transformBottomAnimation forKey:@"rotateBottomAnimation"];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
