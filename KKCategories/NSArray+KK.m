//
//  NSArray+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import "NSArray+KK.h"

@implementation NSArray (KK)

- (id)kk_objectAtIndex:(NSUInteger)index
{
    if (index < self.count)
    {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end

@implementation NSMutableArray (KK)

- (BOOL)kk_addObject:(id)anObject
{
    if (anObject == nil)
    {
        return NO;
    }
    [self addObject:anObject];
    return YES;
}

- (BOOL)kk_replaceObjectAtIndex:(NSInteger)index
                     withObject:(id)anObject
{
    if (index < 0 || index >= self.count || anObject == nil)
    {
        return NO;
    }
    
    [self replaceObjectAtIndex:index
                    withObject:anObject];
    return YES;
}

- (void)bubbleSort:(BOOL (^)(id element1,id element2))comparator
{
    if (comparator == nil)
    {
        return;
    }
    
    NSInteger count = self.count;
    
    for (NSInteger i = 0; i < count - 1; i++)
    {
        for (NSInteger j = 0; j < count - 1 - i; j ++)
        {
            id element1 = self[j];
            id element2 = self[j + 1];
            
            if (comparator(element1,element2))
            {
                [self replaceObjectAtIndex:j
                                withObject:element2];
                [self replaceObjectAtIndex:j + 1
                                withObject:element1];
            }
        }
    }
}

+ (void)quickSort:(NSMutableArray *)m
              low:(NSInteger)low
             high:(NSInteger)high
       comparator:(BOOL (^)(id element1,id element2))comparator
{
    if (low >= high) {
        return;
    }
    NSInteger i = low;
    NSInteger j = high;
    id key = m[i];
    while (i<j) {
        while (i<j && comparator(m[j], key)) {
            j--;
        }
        if (i == j) { // 当key是目前最小的数时，会出现i=j的情况，
            break;
        }
        m[i++] = m[j]; // i++ 会减少一次m[i]和key的比较
        
        while (i < j && !comparator(m[i], key)) {
            i++;
        }
        if (i == j) { // 当key是目前最大的数时(m[j]的前面)，会出现i=j的情况
            break;
        }
        m[j--] = m[i]; //j-- 会减少一次m[j]和key的比较
    }
    m[i] = key;
    [self quickSort:m low:low high:i-1 comparator:comparator];
    [self quickSort:m low:i+1 high:high comparator:comparator];
}

- (void)quickSort:(BOOL (^)(id element1,id element2))comparator
{
    if (comparator == nil)
    {
        return;
    }
    [NSMutableArray quickSort:self
                          low:0
                         high:self.count - 1
                   comparator:comparator];
}

@end
