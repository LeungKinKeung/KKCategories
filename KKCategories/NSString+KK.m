//
//  NSString+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2018/8/21.
//  Copyright © 2018年 LeungKinKeung. All rights reserved.
//

#import "NSString+KK.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (KK)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *output =
    [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output.copy;
}

#pragma clang diagnostic pop

- (NSString *)SHA1
{
    const char *cstr    = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data        = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output =
    [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output.copy;
}

- (NSString *)URLEncodedString
{
    NSString *charactersToEscape =
    @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    
    NSCharacterSet *allowedCharacters =
    [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

- (NSString *)URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}

- (BOOL)isLikeToString:(NSString *)aString
{
    return ([self compare:aString options:NSCaseInsensitiveSearch] == NSOrderedSame);
}

#pragma mark - 提取字符串
- (NSString *)substringWithLoc:(NSInteger)location
                           len:(NSInteger)length
{
    if (location < 0)
    {
        return @"";
    }
    if (location >= self.length)
    {
        return @"";
    }
    if (length == 0)
    {
        return @"";
    }
    if (self.length < (location + length))
    {
        NSRange range =
        NSMakeRange(location, self.length - location);
        
        return [self substringWithRange:range];
    }
    
    return [self substringWithRange:NSMakeRange(location, length)];
}

- (BOOL)containsText:(NSString *)text
{
    if (text == nil)
    {
        return NO;
    }
    return ([self searchText:text].location != NSNotFound);
}

- (NSRange)searchText:(NSString *)text
{
    if (text == nil)
    {
        return NSMakeRange(NSNotFound, NSNotFound);
    }
    return [self rangeOfString:text
                       options:NSCaseInsensitiveSearch];
}

#pragma mark - 是中文
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isContainsChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00 && a <0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

- (NSString *)pinyin
{
    NSMutableString *text = self.mutableCopy;
    
    // 转为带音标的字母
    CFStringTransform((CFMutableStringRef)text,
                      NULL,
                      kCFStringTransformMandarinLatin,
                      NO);
    
    return text;
}

- (NSString *)mandarinLatin
{
    NSMutableString *text = self.mutableCopy;
    
    // 转为不带音标的字母
    CFStringTransform((CFMutableStringRef)text,
                      NULL,
                      kCFStringTransformStripDiacritics,
                      NO);
    
    // 去掉空格
    return [text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)isNumberText
{
    static NSCharacterSet *tmpSet = nil;
    
    if (tmpSet == nil)
    {
        tmpSet =
        [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    
    for (NSInteger i = self.length - 1; i >= 0; i--)
    {
        NSString * string =
        [self substringWithRange:NSMakeRange(i, 1)];
        
        NSRange range =
        [string rangeOfCharacterFromSet:tmpSet];
        
        if (range.length == 0)
        {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark 移除characters里的字符
- (NSString *)stringByRemoveCharacters:(NSString *)characters
{
    NSCharacterSet *set =
    [NSCharacterSet characterSetWithCharactersInString:characters];
    
    return [self stringByTrimmingCharactersInSet:set];
}

#pragma mark 过滤并保留characters里字符
- (NSString *)stringByRetainsCharacters:(NSString *)characters
{
    NSCharacterSet *set = nil;
    
    if (set == nil)
    {
        set =
        [[NSCharacterSet characterSetWithCharactersInString:characters] invertedSet];
    }
    
    return [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
}


BOOL NSStringIsEmpty(NSString * string)
{
    if (string == nil ||
        [string isKindOfClass:[NSString class]] == NO ||
        [string isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

NSString *KKSubstring(NSString *string, NSInteger loc, NSInteger len)
{
    return [string substringWithLoc:loc len:len];
}

NSString *KKSafeString(NSString *string)
{
    if (string == nil ||
        [string isKindOfClass:[NSString class]] == NO)
    {
        return @"";
    }
    return string;
}

BOOL CFStringIsEqual(CFStringRef cfstring1,CFStringRef cfstring2)
{
    NSString *str1 = (__bridge NSString *)(cfstring1);
    NSString *str2 = (__bridge NSString *)(cfstring2);
    
    return [str1 isEqualToString:str2];
}

#pragma mark - 格式化为字符串
NSString * IntStr(NSInteger value)
{
    return [NSString stringWithFormat:@"%lld",(long long)value];
}

NSString * UIntStr(NSUInteger value)
{
    return [NSString stringWithFormat:@"%llu",(unsigned long long)value];
}

NSString * BoolStr(BOOL value)
{
    if (value == YES)
    {
        return @"true";
    }
    else
    {
        return @"false";
    }
}
NSString * IntStrFromBoolValue(BOOL value)
{
    if (value == YES)
    {
        return @"1";
    }
    else
    {
        return @"0";
    }
}

NSString * FloatStr(double value)
{
    return [NSString stringWithFormat:@"%.6f",value];
}

BOOL BoolValueFromStr(NSString * string)
{
    if (string == nil)
    {
        return NO;
    }
    if ([string isLikeToString:@"true"])
    {
        return YES;
    }
    if ([string isLikeToString:@"false"])
    {
        return NO;
    }
    if (![string isKindOfClass:[NSNumber class]] ||
        ![string isKindOfClass:[NSString class]])
    {
        return NO;
    }
    return [string boolValue];
}


@end
