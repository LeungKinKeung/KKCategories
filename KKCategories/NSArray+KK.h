//
//  NSArray+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (KK)

/// 取出对象
/// @param index 假如索引越界，就返回nil
- (ObjectType)kk_objectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray<ObjectType> (KK)

/// 添加对象
/// @param anObject 假如为空，就不添加
- (BOOL)kk_addObject:(ObjectType)anObject;

/// 替换对象
/// @param index 假如索引越界，就不添加
/// @param anObject 假如为空，就不添加
- (BOOL)kk_replaceObjectAtIndex:(NSInteger)index
                     withObject:(ObjectType)anObject;

/// 冒泡排序
- (void)bubbleSort:(BOOL (^)(ObjectType element1,ObjectType element2))comparator;
/**
    [array bubbleSort:^BOOL(NSNumber *element1, NSNumber *element2) {
        return (element1.intValue > element2.intValue);// 升序
        return (element1.intValue < element2.intValue);// 降序
    }];
 */

/// 快速排序
- (void)quickSort:(BOOL (^)(ObjectType element1,ObjectType element2))comparator;
/**
    [array quickSort:^BOOL(NSNumber *element1, NSNumber *element2) {
        return (element1.intValue > element2.intValue);// 升序
        return (element1.intValue < element2.intValue);// 降序
    }];
 */


@end
