//
//  PagerButtonViewController.m
//  POP的练习1
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "PagerButtonViewController.h"
#import "PagerButton.h"

@interface PagerButtonViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PagerButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBarButton];
    [self addTitleLabel];
}
- (void)addBarButton {
    PagerButton *button = [PagerButton pagerButton];
    button->PagerButtonAnimationDuration = 0.3;
    [button addTarget:self action:@selector(animateTitleLabel:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)addTitleLabel {
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:26.f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1];
    [self setTitleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.titleLabel];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(80)-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
}
- (void)animateTitleLabel:(id)sender {
    CGFloat toValue = CGRectGetMidX(self.view.bounds);
    
    POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    onscreenAnimation.toValue = @(toValue);
    onscreenAnimation.springBounciness = 10.f;
    
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation easeInAnimation];
    offscreenAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionX];
    offscreenAnimation.toValue = @(-toValue);
    offscreenAnimation.duration = 0.2f;
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [self setTitleLabel];
        [self.titleLabel.layer pop_addAnimation:onscreenAnimation forKey:@"onscreenAnimation"];
    }];
    [self.titleLabel.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
}

- (void)setTitleLabel {
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    NSString *title = @"List";
    if ([self.titleLabel.text isEqualToString:title]) {
        title = @"Menu";
    }
    self.titleLabel.text = title;
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
