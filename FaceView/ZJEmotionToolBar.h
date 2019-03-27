//
//  ZJEmotionToolBar.h
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/14.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJEmotionToolBar;
typedef enum{
//    ZJEmotionTypeDefault,   //默认键盘
    ZJEmotionTypeRecent,  // 最近
    ZJEmotionTypeEmoji,    // Emoji
    ZJEmotionTypeDelete       // 删除
}ZJEmotionType;

@protocol ZJEmotionToolBarDelegate <NSObject>

-(void)emotionToolbar:(ZJEmotionToolBar *)toolbar didSelectedButton:(ZJEmotionType)emotionType;

@end

@interface ZJEmotionToolBar : UIView
@property (nonatomic, assign) id<ZJEmotionToolBarDelegate> delegate;
@end
