//
//  ZJEmotionTool.m
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/15.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "ZJEmotionTool.h"

@implementation ZJEmotionTool

/**   emoji表情   */
static NSArray *_emojiEmotions;

/**   最近表情   */
static NSMutableArray *_recentEmotions;

+(NSArray *)emojiEmotions
{
    if (!_emojiEmotions){
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"Moreemoji.plist" ofType:nil];
        _emojiEmotions = [ZJEmotion mj_objectArrayWithFile:plist];
    }
    return _emojiEmotions;
}

+(NSArray *)recentEmotions
{
    
    
    if (!_recentEmotions) {
        // 到沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:ZJRecentFilePath];
        
        if (!_recentEmotions){  // 如果沙盒中没有任何数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

+(void)addRecentEmotion:(ZJEmotion *)emotion
{
    // 加载最近的表情数据
    [self recentEmotions];
    
    // 删除之前的表情
    [_recentEmotions removeObject:emotion];
    
    // 添加最新的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 存储到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:ZJRecentFilePath];
}


+(ZJEmotion *)emotionWithDesc:(NSString *)desc
{
    if (!desc) return  nil;
    
    __block ZJEmotion *foundEmotion = nil;
    // 从默认表情中找
    [[self emojiEmotions] enumerateObjectsUsingBlock:^(ZJEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.face_name] || [desc isEqualToString:emotion.face_id]){
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    if (foundEmotion) return foundEmotion;
    
    return foundEmotion;
}
@end
