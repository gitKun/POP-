//
//  ListCell.m
//  POP的练习1
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "ListCell.h"
#import "POP.h"

@interface ListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ListCell

- (void)awakeFromNib {
    self.nameLabel.layer.cornerRadius = 5;
    self.nameLabel.layer.masksToBounds = YES;
}
- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.nameLabel pop_addAnimation:scaleAnimation forKey:nil];
    }else {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness = 20.0f;
        [self.nameLabel pop_addAnimation:scaleAnimation forKey:nil];
    }
}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
