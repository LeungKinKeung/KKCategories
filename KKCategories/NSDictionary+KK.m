//
//  NSDictionary+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import "NSDictionary+KK.h"

@implementation NSDictionary (KK)

- (NSInteger)intValueForKey:(NSString *)key
{
    NSNumber *value = [self valueForKey:key];
    
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]])
    {
        return value.integerValue;
    }
    return 0;
}

- (double)doubleValueForKey:(NSString *)key
{
    NSNumber *value = [self valueForKey:key];
    
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]])
    {
        return value.doubleValue;
    }
    return 0.0;
}

- (BOOL)boolValueForKey:(NSString *)key
{
    NSNumber *value = [self valueForKey:key];
    
    if ([value isKindOfClass:[NSNumber class]] ||
        [value isKindOfClass:[NSString class]])
    {
        return value.boolValue;
    }
    return 0;
}

- (NSString *)simpleXML
{
    NSMutableString *string = [NSMutableString string];
    NSArray *allKeys        = self.allKeys;
    
    for (NSString *key in allKeys)
    {
        NSString *value = [self valueForKey:key];
        
        if (value == nil ||
            [value isKindOfClass:[NSNull class]])
        {
            value = @"";
        }
        
        if ([value isKindOfClass:[NSNumber class]])
        {
            value =
            [NSString stringWithFormat:@"%@",value];
        }
        
        value =
        [value stringByReplacingOccurrencesOfString:@"<"
                                         withString:@"&lt"];
        value =
        [value stringByReplacingOccurrencesOfString:@">"
                                         withString:@"&gt"];
        NSString *tempKey =
        [key stringByReplacingOccurrencesOfString:@">"
                                       withString:@"&gt"];
        tempKey =
        [tempKey stringByReplacingOccurrencesOfString:@">"
                                           withString:@"&gt"];
        
        [string appendString:[NSString stringWithFormat:@"<%@>%@</%@>",tempKey,value,tempKey]];
    }
    return [string copy];
}


@end
