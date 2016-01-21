//
//  DecayViewController.m
//  POP的练习1
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "DecayViewController.h"

/*
 pop 动画 在对同一个 layer 或 view 的同一个属性进行动画时,通过 pop_addAnimation:forKey: 添加动画时 设置同一个 key 时 当执行这个key对应动画时 如果当前动画的就是这个key对应的一个动画 那么此动画会在执行下一个动画时自动停止 (pop的动画是基于 CADisplayLink 来直接改变属性做的动画效果,和 coreAnimation 的动画机制并不相同 但是接口很相似)
 */

@interface DecayViewController ()<POPAnimationDelegate>

@property (nonatomic, strong) UIControl *dragView;

@end

@implementation DecayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DecayAnimation";
    [self addDragView];
}


- (void)addDragView {
#if 0
    self.dragView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.dragView.center = self.view.center;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.dragView.bounds];
    CAShapeLayer *maskLayr = [CAShapeLayer layer];
    maskLayr.frame = self.dragView.bounds;
    maskLayr.path = path.CGPath;
    maskLayr.fillColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1].CGColor;
    [self.dragView.layer addSublayer:maskLayr];
    [self.dragView addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.dragView addGestureRecognizer:recognizer];
#endif
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.dragView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.dragView.center = self.view.center;
    self.dragView.layer.cornerRadius = CGRectGetWidth(self.dragView.bounds)/2;
    self.dragView.backgroundColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    [self.dragView addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self.dragView addGestureRecognizer:recognizer];
    [self.view addSubview:self.dragView];
}

- (void)touchDown {
    [self.dragView.layer pop_removeAllAnimations];
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
#if 0
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.delegate = self;
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:nil];//见备注1
        //用 pop 时 如果涉及到对同一个属性进行 多次动画时 应该 设置同一个 key 当执行下一个相同key的动画时 就会把 上一个动画移除
    }
#endif
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.delegate = self;
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}
#pragma mark === POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim {
    BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.view.frame, self.dragView.frame);
    if (isDragViewOutsideOfSuperView) {
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
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
