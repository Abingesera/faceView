//
//  NSString+Extension.h
//  NewHoldGold
//
//  Created by 掌金 on 2017/11/14.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (NSString *)emoji;

- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font;

- (NSString *)originName;

+ (NSString *)currentName;

- (NSString *)firstStringSeparatedByString:(NSString *)separeted;
@end
