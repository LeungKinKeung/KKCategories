//
//  NSJSONSerialization+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSJSONSerialization (KK)

/// 解析为NSArray/NSDictionary对象
/// @param json NSString/NSData
OBJC_EXTERN id KKJSONParse(id json);

/// 序列化为数据(无换行符)
/// @param object NSArray/NSDictionary
OBJC_EXTERN id KKJSONDataify(id object);

/// 序列化为字符串(无换行符)
/// @param object NSArray/NSDictionary
OBJC_EXTERN id KKJSONStringify(id object);

/// 解析为NSArray/NSDictionary对象
/// @param json NSString/NSData
+ (id)parse:(id)json;

/// 序列化为数据(无换行符)
/// @param object NSArray/NSDictionary
+ (NSData *)dataify:(id)object;

/// 序列化为字符串(无换行符)
/// @param object NSArray/NSDictionary
+ (NSString *)stringify:(id)object;

@end


NS_ASSUME_NONNULL_END
