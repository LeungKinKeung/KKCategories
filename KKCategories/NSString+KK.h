//
//  NSString+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2018/8/21.
//  Copyright © 2018年 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KK)

/// MD5
@property (nonatomic, readonly) NSString *MD5;

/// SHA1
@property (nonatomic, readonly) NSString *SHA1;

/// 序列化为URL(某些符号添加百分比符号)
@property (nonatomic, readonly) NSString *URLEncodedString;

/// URL反序列化(移除百分比符号)
@property (nonatomic, readonly) NSString *URLDecodedString;

/// 判断是否是纯汉字
@property (nonatomic, readonly) BOOL isChinese;

/// 判断是否含有汉字
@property (nonatomic, readonly) BOOL isContainsChinese;

/// 中文拼音(带音标和空格)
@property (nonatomic, readonly) NSString *pinyin;

/// 中文拼音(不带音标和空格)
@property (nonatomic, readonly) NSString *mandarinLatin;

/// 是数字文本
@property (nonatomic, readonly) BOOL isNumberText;

/// 字符串相同(不区分大小写)
- (BOOL)isLikeToString:(NSString *)aString;

/// 提取字符串
- (NSString *)substringWithLoc:(NSInteger)location len:(NSInteger)length;

/// 包含字符串
- (BOOL)containsText:(NSString *)text;

/// 搜索字符串范围
- (NSRange)searchText:(NSString *)text;

/// 移除characters里的字符
- (NSString *)stringByRemoveCharacters:(NSString *)characters;

/// 过滤并保留characters里字符
- (NSString *)stringByRetainsCharacters:(NSString *)characters;

/// 为 nil 和 @"" 时都为 YES
OBJC_EXTERN BOOL NSStringIsEmpty(NSString *string);

/// 取出字符串
OBJC_EXTERN NSString *KKSubstring(NSString *string, NSInteger loc, NSInteger len);

/// 为 nil 或不为 NSString * 时返回 @""
OBJC_EXTERN NSString *KKSafeString(NSString *string);

/// 相同的CFString
OBJC_EXTERN BOOL CFStringIsEqual(CFStringRef cfstring1,
                                 CFStringRef cfstring2);

/// 格式化为字符串
OBJC_EXTERN NSString *IntStr(NSInteger value);

/// 格式化为字符串
OBJC_EXTERN NSString *UIntStr(NSUInteger value);

/// 格式化为字符串，if YES return @"true";if NO return @"false"
OBJC_EXTERN NSString *BoolStr(BOOL value);

/// 格式化为字符串，YES = 1,NO = 0
OBJC_EXTERN NSString *IntStrFromBoolValue(BOOL value);

/// 格式化为字符串，.6f format
OBJC_EXTERN NSString *FloatStr(double value);

/// 格式化为字符串，if @"true" return YES, if @"false" return NO , nil return NO
OBJC_EXTERN BOOL BoolValueFromStr(NSString *string);

@end
