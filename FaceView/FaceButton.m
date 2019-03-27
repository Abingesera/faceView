//
//  FaceButton.m
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/14.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "FaceButton.h"

@implementation FaceButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.titleLabel.font             = [UIFont systemFontOfSize:32.0];
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setEmotion:(ZJEmotion *)emotion
{
    _emotion               = emotion;
    if (emotion.code) {
        [self setTitle:self.emotion.code.emoji forState:UIControlStateNormal];
    } else if (emotion.face_name) {
        [self setImage:[UIImage imageNamed:self.emotion.face_name] forState:UIControlStateNormal];
    }
}

@end
