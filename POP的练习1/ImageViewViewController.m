//
//  ImageViewViewController.m
//  POP的练习1
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "ImageViewViewController.h"
#import "DRImageView.h"

typedef struct {
    CGFloat progress;
    CGFloat toValue;
    CGFloat currentValue;
}AnimationInfo;

@interface ImageViewViewController ()

@property (weak, nonatomic) IBOutlet DRImageView *imageView;

@end

@implementation ImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPanGesture];
}
- (void)addPanGesture {
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.imageView addGestureRecognizer:panG];
    self.imageView.image = [UIImage imageNamed:@"boat.jpg"];
    [self scaleDownView:_imageView];
}
#pragma mark === 点击事件
- (IBAction)touchDownAction:(DRImageView *)sender {
    [self pauseAllAnimations:YES forLayer:sender.layer];
}
- (IBAction)touchUpInsideAction:(DRImageView *)sender {
    AnimationInfo animationInfo = [self animationInfoForLayer:sender.layer];
    BOOL hasAnimations = sender.layer.pop_animationKeys.count;
    
    if (hasAnimations && animationInfo.progress < 0.98) {
        [self pauseAllAnimations:NO forLayer:sender.layer];
        return;
    }
    [sender.layer pop_removeAllAnimations];
    if (animationInfo.toValue == 1 || sender.layer.affineTransform.a == 1) {
        [self scaleDownView:sender];
        return;
    }
    [self scaleUpView:sender];
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self scaleDownView:recognizer.view];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.dynamicsTension = 10.f;
        positionAnimation.dynamicsFriction = 1.0f;
        positionAnimation.springBounciness = 12.0f;
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

#pragma mark === 动画事件
- (void)scaleDownView:(UIView *)view {
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    scaleAnimation.springBounciness = 10.0;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}
- (void)scaleUpView:(UIView *)view {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
    [view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnimation.springBounciness = 10.0;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}
- (void)pauseAllAnimations:(BOOL)pause forLayer:(CALayer *)layer {
    for (NSString *key in layer.pop_animationKeys) {
        POPAnimation *anim = [layer pop_animationForKey:key];
        [anim setPaused:pause];
    }
}
- (AnimationInfo)animationInfoForLayer:(CALayer *)layer {
    POPSpringAnimation *animation = [layer pop_animationForKey:@"scaleAnimation"];
    CGPoint toValue = [animation.toValue CGPointValue];
    CGPoint currentValue = [[animation valueForKey:@"currentValue"] CGPointValue];
    CGFloat min = MIN(toValue.x, currentValue.x);
    CGFloat max = MAX(toValue.x, currentValue.x);
    AnimationInfo info ;
    info.toValue = toValue.x;
    info.currentValue = currentValue.x;
    info.progress = min/max;
    return info;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
