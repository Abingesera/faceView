//
//  ZJEmotionTool.h
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/15.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJEmotionTool : NSObject

/**
 *  默认表情
 */
+(NSArray *)emojiEmotions;

/**
 *  最近表情
 */
+(NSArray *)recentEmotions;

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+(ZJEmotion *)emotionWithDesc:(NSString *)desc;

/**
 *  保存最近使用的表情
 */
+(void)addRecentEmotion:(ZJEmotion *)emotion;

@end
