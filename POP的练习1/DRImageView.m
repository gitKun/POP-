//
//  DRImageView.m
//  POP的练习1
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "DRImageView.h"

@implementation DRImageView
{
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    [_imageView setImage:image];
    _image = image;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    NSLog(@"bounds = %@",NSStringFromCGRect(self.bounds));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
