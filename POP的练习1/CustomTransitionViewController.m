//
//  CustomTransitionViewController.m
//  POP的练习1
//
//  Created by apple on 1/8/16.
//  Copyright © 2016 CaiFu. All rights reserved.
//

#import "CustomTransitionViewController.h"
#import "CustonPresentAnimator.h"
#import "customDismissAnimator.h"
#import "ModelViewController.h"

@interface CustomTransitionViewController ()<UIViewControllerTransitioningDelegate,ModelViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *testImgView;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation CustomTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CustomTransitionAnimation";
    UIImage *image = [UIImage imageNamed:@"yilian_auth_icon.jpg"];
    //image = [image imageWithRenderingMode:UIImageRenderingModeAutomatic];
    //self.testImgView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    //self.testImgView.tintColor = [UIColor redColor];
    self.testImgView.image = image;
    
    self.testBtn.tintColor = [UIColor colorWithRed:214/255.0 green:10/255.8 blue:52/255.0 alpha:1];
//    self.testBtn.tint
    
    //self.testLabel.tintColor = [UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1];
    self.testLabel.textColor = [UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1];
}

- (IBAction)presentButtonClick:(UIButton *)sender {
    ModelViewController *mvc = [ModelViewController new];
    mvc.transitioningDelegate = self;
    mvc.modalPresentationStyle = UIModalPresentationCustom;
    mvc.mDelegate = self;
    [self.navigationController presentViewController:mvc animated:YES completion:nil];
    
}

#pragma mark == ModelViewControllerDelegate
- (void)modelViewController:(ModelViewController *)mvc clickAtDismissButton:(UIButton *)dismissButton {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark == UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [customDismissAnimator new];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CustonPresentAnimator new];
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
