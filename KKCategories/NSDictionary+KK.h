//
//  NSDictionary+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (KK)

/// 取出整数
- (NSInteger)intValueForKey:(NSString *)key;

/// 取出浮点数
- (double)doubleValueForKey:(NSString *)key;

/// 取出布尔值
- (BOOL)boolValueForKey:(NSString *)key;

/// 转为XML格式字符串（非规范）
- (NSString *)simpleXML;

@end

NS_ASSUME_NONNULL_END
