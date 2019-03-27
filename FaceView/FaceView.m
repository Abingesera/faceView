//
//  FaceView.m
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/14.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "FaceView.h"

@interface FaceView () <UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation FaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self creatUI];
    }
    return self;
}


- (void)creatUI {
    //1/添加表情列表
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 15, self.width, self.height-45-HOME_INDICATOR_HEIGHT - 30)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    // 2、添加表情工具条
    ZJEmotionToolBar *toolbar = [[ZJEmotionToolBar alloc] initWithFrame:CGRectMake(0, self.scrollView.bottom, self.width, 45 + HOME_INDICATOR_HEIGHT)];
    toolbar.delegate = self;
    [self addSubview:toolbar];
    self.toolBar = toolbar;
    
    CGFloat inset            = 15;
    NSUInteger count         = self.emotions.count;
//    CGFloat btnW             = (self.width - 2*inset)/7;
    CGFloat btnW             = self.width / 7;
    CGFloat btnH             = btnW;
    
    for (int i = 0; i < count; i ++) {
        FaceButton *btn = self.scrollView.subviews[i];//因为已经加了一个deleteBtn了
        btn.width            = btnW;
        btn.height           = btnH;
        btn.mj_x                = inset + (i % 7)*btnW;
        btn.mj_y                = inset + (i / 7)*btnH;
        [self.scrollView addSubview:btn];
    }
    NSInteger rowNum =  (CGRectGetHeight(self.scrollView.frame) / btnH);
    NSInteger colNum =  (CGRectGetWidth(self.frame) / btnW);
    NSInteger numOfPage = ceil((float)count / (float)(rowNum * colNum));
    
    _pageControl=[[UIPageControl alloc] init];
    _pageControl.originY = self.toolBar.originY - 10;
    _pageControl.centerX = self.centerX;
    [_pageControl setNumberOfPages:numOfPage];
    [_pageControl setPageIndicatorTintColor:ZJHEXRGBCOLOR(0x999999)];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    _pageControl.hidden = YES;
    [self addSubview:_pageControl];
    if (numOfPage > 1) {
        _pageControl.hidden = NO;
    }

}

#pragma mark - 设置frame
/**
 *  设置frame
 */
-(void)layoutSubviews
{
    [super layoutSubviews];

    // 1、设置工具条的frame
    self.toolBar.width = self.width;
    self.toolBar.height = 44 + HOME_INDICATOR_HEIGHT;
    //    self.toolBar.x = 0;
    self.toolBar.mj_y = self.height - self.toolBar.height;

    // 2、设置表情的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.toolBar.mj_y - 30;
    self.pageControl.originY = self.toolBar.originY - 10;

//    CGFloat inset            = 15;
    NSUInteger count         = self.emotions.count;
//    CGFloat btnW             = (self.width - 2*inset)/7;
    CGFloat btnW             = self.width / 7;
    CGFloat btnH             = btnW;
    
    NSInteger rowNum =  (CGRectGetHeight(self.scrollView.frame) / btnH);
    NSInteger colNum =  (CGRectGetWidth(self.frame) / btnW);
    NSInteger numOfPage = ceil((float)count / (float)(rowNum * colNum));
    self.scrollView.contentSize = CGSizeMake(self.width * numOfPage, self.scrollView.height);
    NSInteger row = 0;
    NSInteger column = 0;
    NSInteger page = 0;
    for (int i = 0; i < count; i++) {
        //换行算法
        if (i % (rowNum * colNum) == 0) {
            page ++;
            row = 0;
            column = 0;
        }else if (i % colNum == 0) {
            // NewLine
            row += 1;
            column = 0;
        }
        CGRect currentRect = CGRectMake(((page-1) * self.width) + (column * btnW),
                                        row * btnH,
                                        btnW ,
                                        btnH);
        
        FaceButton *btn = self.scrollView.subviews[i];//因为已经加了一个deleteBtn了
        btn.frame = currentRect;
        column++;
    }
    
    if (numOfPage > 1) {
        _pageControl.hidden = NO;
    }else{
        _pageControl.hidden = YES;
    }

//    for (int i = 0; i < count; i ++) {
//        FaceButton *btn = self.scrollView.subviews[i];//因为已经加了一个deleteBtn了
//        btn.width            = btnW;
//        btn.height           = btnH;
//        btn.mj_x                = inset + (i % 7)*btnW;
//        btn.mj_y                = inset + (i / 7)*btnH;
//    }
}


- (void)setEmotions:(NSArray *)emotions
{
    [self.scrollView removeAllSubviews];
    _emotions                   = emotions;
    NSUInteger count            = emotions.count;
    for (int i = 0; i < count; i ++) {
        FaceButton *button = [[FaceButton alloc] init];
        [self.scrollView addSubview:button];
        button.emotion          = emotions[i];
        [button addTarget:self action:@selector(emotionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
//    NSInteger idx = ceilf(count / 7);
//    self.scrollView.contentSize = CGSizeMake(self.width, (self.width - 2*15)/7 * idx+15*2+45);
    // 重新布局子控件
    [self setNeedsLayout];
    // 表情滚动到最前面
//    self.scrollView.contentOffset = CGPointZero;
}

#pragma mark 点击表情
- (void)emotionBtnClicked:(FaceButton *)button {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:button.emotion forKey:@"face_code"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectFaceWithDict:)]) {
        [self.delegate selectFaceWithDict:userInfo];
    }
    // 保存使用记录
    [ZJEmotionTool addRecentEmotion:button.emotion];
}
#pragma mark - ZJEmotionToolbarDelegate 点击toolbar四个按钮代理
-(void)emotionToolbar:(ZJEmotionToolBar *)toolbar didSelectedButton:(ZJEmotionType)emotionType {
    
    switch (emotionType) {
//        case ZJEmotionTypeDefault:   // 默认键盘
//            
//      //发出一个切换默认键盘的事件
//            [[NSNotificationCenter defaultCenter] postNotificationName:ZJEmotionDefaultNotification object:nil userInfo:nil];
//
//            break;
        case ZJEmotionTypeRecent:   // 最近
           
              [[NSNotificationCenter defaultCenter] postNotificationName:ZJEmotionRecentNotification object:nil userInfo:nil];
             self.emotions = [ZJEmotionTool recentEmotions];
            break;
            
        case ZJEmotionTypeEmoji:   // emoji
           
             [[NSNotificationCenter defaultCenter] postNotificationName:ZJEmotionEmojiNotification object:nil userInfo:nil];
            self.emotions = [ZJEmotionTool emojiEmotions];
            break;
            
        case ZJEmotionTypeDelete:   // 删除
           [[NSNotificationCenter defaultCenter] postNotificationName:ZJEmotionDeleteNotification object:nil userInfo:nil];
            
            break;
    }
}

#pragma mark UIScrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    [_pageControl setCurrentPage:index];
}







@end
