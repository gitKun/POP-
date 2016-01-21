//
//  ModelViewController.h
//  POP的练习1
//
//  Created by apple on 1/8/16.
//  Copyright © 2016 CaiFu. All rights reserved.
//

#import "BaseViewController.h"

@class ModelViewController;

@protocol ModelViewControllerDelegate <NSObject>

- (void)modelViewController:(ModelViewController *)mvc clickAtDismissButton:(UIButton *)dismissButton;

@end

@interface ModelViewController : BaseViewController

@property (nonatomic, weak) id<ModelViewControllerDelegate>mDelegate;

@end
