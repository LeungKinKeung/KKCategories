//
//  NSJSONSerialization+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import "NSJSONSerialization+KK.h"

@implementation NSJSONSerialization (KK)

+ (id)parse:(id)json
{
    id data = json;
    
    if ([json isKindOfClass:NSString.class])
    {
        data =
        [json dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if ([data isKindOfClass:NSData.class])
    {
        NSError *error  = nil;
        id object       =
        [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (error || object == nil)
        {
            NSLog(@"%s %d %@",__func__,__LINE__,error.localizedDescription);
            return nil;
        }
        return object;
    }
    else
    {
        return nil;
    }
}

+ (NSData *)dataify:(id)object
{
    if ([NSJSONSerialization isValidJSONObject:object])
    {
        NSError *error  = nil;
        NSData *data    =
        [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
        
        if (error)
        {
            NSLog(@"%s %d %@",__func__,__LINE__,error.localizedDescription);
            return nil;
        }
        return data;
    }
    return nil;
}

+ (NSString *)stringify:(id)object
{
    if ([NSJSONSerialization isValidJSONObject:object])
    {
        NSError *error  = nil;
        NSData *data    =
        [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
        
        if (error)
        {
            NSLog(@"%s %d %@",__func__,__LINE__,error.localizedDescription);
            return nil;
        }
        return [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}

id KKJSONParse(id json)
{
    return [NSJSONSerialization parse:json];
}

id KKJSONDataify(id object)
{
    return [NSJSONSerialization dataify:object];
}

id KKJSONStringify(id object)
{
    return [NSJSONSerialization stringify:object];
}

@end
