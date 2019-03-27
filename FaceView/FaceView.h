//
//  FaceView.h
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/14.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "ZJBaseView.h"
#import "FaceButton.h"
#import "ZJEmotionToolBar.h"
#import "ZJEmotionTool.h"

@protocol selectFaceDelegate <NSObject>

- (void)selectFaceWithDict:(NSMutableDictionary *)dict;

@end

@interface FaceView : ZJBaseView<ZJEmotionToolBarDelegate>

@property (nonatomic,assign)id <selectFaceDelegate>delegate;

@property (nonatomic, strong) NSArray *emotions;

@property (nonatomic,strong)ZJEmotionToolBar *toolBar;

@end
