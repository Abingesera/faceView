//
//  ZJEmotionToolBar.m
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/14.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "ZJEmotionToolBar.h"

@interface ZJEmotionToolBar ()

/** 记录当前选中的按钮  */
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation ZJEmotionToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1、在工具条上添加4个按钮
//        [self setupButton:@"" tag:ZJEmotionTypeDefault];//键盘
        [self setupButton:@"" tag:ZJEmotionTypeRecent];
        [self setupButton:@"" tag:ZJEmotionTypeEmoji];//emoji
        [self setupButton:@"" tag:ZJEmotionTypeDelete];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  表情选中
 */
-(void)emotionDidSelected:(NSNotification *)note
{
    if (self.selectedButton.tag == ZJEmotionTypeRecent){
        [self buttonClick:self.selectedButton];
    }
}

/**
 *  在工具条上添加4个按钮
 *
 *  @param title 按钮上的文字
 */
-(UIButton *)setupButton:(NSString *)title tag:(ZJEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    // 普通状态下文字的颜色
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 选中状态下文字的颜色
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    // 监听按钮的点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    // 文字的大小
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 将按钮添加到工具条上
    [self addSubview:button];
    
    
        // 设置按钮的背景图片
//    if (tag == ZJEmotionTypeDefault) {//键盘
//
////        [button setImage:[UIImage imageNamed:@"Ic keyboard"] forState:UIControlStateNormal];
////        [button setImage:[UIImage imageNamed:@"Ic keyboard_h"] forState:UIControlStateNormal];
//
//    }else
if (tag == ZJEmotionTypeRecent){//最近
        [button setImage:[UIImage imageNamed:@"History"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"History_h"] forState:UIControlStateSelected];
    }else if (tag == ZJEmotionTypeEmoji){//EMOJI
    
        [button setImage:[UIImage imageNamed:@"Face"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Face_h"] forState:UIControlStateSelected];
        
    }else if (tag == ZJEmotionTypeDelete){//删除
        [button setImage:[UIImage imageNamed:@"delete_KF"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"delete_h"] forState:UIControlStateSelected];
        
    }
    

    return button;
}


/**
 *  监听按钮的点击
 */
-(void)buttonClick:(UIButton *)button
{
    // 1、控制按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2、通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]){
        [self.delegate emotionToolbar:self didSelectedButton:(ZJEmotionType)button.tag];
    }
}

-(void)setDelegate:(id<ZJEmotionToolBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 获得“默认”按钮
    UIButton *defaultButton = (UIButton *)[self viewWithTag:ZJEmotionTypeEmoji];
    
    self.selectedButton = defaultButton;
    
    // 默认选中”默认"按钮
    [self buttonClick:defaultButton];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.width / 3;
    CGFloat buttonH = self.height - HOME_INDICATOR_HEIGHT;
    for (int i = 0; i < 3; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.mj_x = i * buttonW;
    }
}

@end
