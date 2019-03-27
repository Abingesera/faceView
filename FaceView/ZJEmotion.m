//
//  ZJEmotion.m
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/14.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "ZJEmotion.h"

@implementation ZJEmotion
- (BOOL)isEqual:(ZJEmotion *)emotion
{
    return [self.face_name isEqualToString:emotion.face_name] || [self.code isEqualToString:emotion.code];
}
@end
