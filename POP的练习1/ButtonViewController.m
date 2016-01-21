//
//  ButtonViewController.m
//  POP的练习1
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "ButtonViewController.h"
#import "FlatButton.h"

@interface ButtonViewController ()

@property (weak, nonatomic) IBOutlet FlatButton *flatButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Button Animation";
    self.infoLabel.layer.opacity = 0.0;
}

- (IBAction)buttonClick:(id)sender {
    self.flatButton.userInteractionEnabled =NO;
    [self hiddenLabel];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self shakeButton];
        [self showLabel];
    });
    
}

- (void)shakeButton {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnimation.velocity = @(2000);
    positionAnimation.springBounciness = 20;
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.flatButton.userInteractionEnabled = YES;
    }];
    [self.flatButton.layer pop_addAnimation:positionAnimation forKey:nil];
}
- (void)showLabel {
    self.infoLabel.layer.opacity = 1.0;
    POPSpringAnimation *layerScaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness = 18;
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.infoLabel.layer pop_addAnimation:layerScaleAnimation forKey:nil];
    
    POPSpringAnimation *layerPosistionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPosistionAnimation.toValue = @(self.flatButton.layer.position.y+25+self.flatButton.layer.bounds.size.height/2);
    layerPosistionAnimation.springBounciness = 12;
    [self.infoLabel.layer pop_addAnimation:layerPosistionAnimation forKey:nil];
}
- (void)hiddenLabel {
    POPBasicAnimation *layerScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
    [self.infoLabel.layer pop_addAnimation:layerScaleAnimation forKey:nil];
    
    POPBasicAnimation *layerPositionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(self.flatButton.layer.position.y);
    [self.infoLabel.layer pop_addAnimation:layerPositionAnimation forKey:nil];
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
