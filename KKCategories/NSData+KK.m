//
//  NSData+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import "NSData+KK.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (KK)

/**
 *  根据CCOperation，确定加密还是解密
 *
 *  @param operation kCCEncrypt -> 加密  kCCDecrypt－>解密
 *  @param key       公钥
 *  @param iv        偏移量
 *
 *  @return 加密或者解密的NSData
 */
- (NSData *)AES128Operation:(CCOperation)operation
                        key:(NSString *)key
                         iv:(NSString *)iv

{
    char keyPtr[kCCKeySizeAES128 + 1];
    
    memset(keyPtr,
           0,
           sizeof(keyPtr));
    
    [key getCString:keyPtr
          maxLength:sizeof(keyPtr)
           encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    
    memset(ivPtr,
           0,
           sizeof(ivPtr));
    
    [iv getCString:ivPtr
         maxLength:sizeof(ivPtr)
          encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer
                                    length:numBytesCrypted];
    }
    
    free(buffer);
    
    return nil;
}

#pragma mark 加密数据
- (NSData *)AES128EncryptWithKey:(NSString *)key
                              iv:(NSString *)iv
{
    return [self AES128Operation:kCCEncrypt
                             key:key
                              iv:iv];
}

#pragma mark 解密数据
- (NSData *)AES128DecryptWithKey:(NSString *)key
                              iv:(NSString *)iv
{
    return [self AES128Operation:kCCDecrypt
                             key:key
                              iv:iv];
}

#pragma mark 转为16进制字符串
- (NSString *)hexString
{
    if ([self length] ==0)
    {
        return @"";
    }
    NSMutableString *string =
    [[NSMutableString alloc] initWithCapacity:[self length] / 2];
    
    [self enumerateByteRangesUsingBlock:^(const void*bytes,NSRange byteRange,BOOL*stop) {
        unsigned char *dataBytes = (unsigned  char*)bytes;
        for (NSInteger i =0; i < byteRange.length; i++)
        {
            NSString *hexStr =
            [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] ==2)
            {
                [string appendString:hexStr];
            } else
            {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

@end


@implementation NSString (KKEncrypt)

#pragma mark 加密并转为base64编码的字符串
+ (NSString *)AES128EncryptBase64String:(NSString *)string
                                    key:(NSString *)key
                                     iv:(NSString *)iv
{
    if (string != nil &&
        [string isKindOfClass:[NSString class]] &&
        string.length > 0)
    {
        return [string AES128EncryptWithKey:key
                                         iv:iv];
    }
    return @"";
}

#pragma mark 解密base64编码的字符串
+ (NSString *)AES128DecryptBase64String:(NSString *)string
                                    key:(NSString *)key
                                     iv:(NSString *)iv
{
    if (string != nil &&
        [string isKindOfClass:[NSString class]] &&
        string.length > 0)
    {
        return [string AES128DecryptWithKey:key
                                         iv:iv];
    }
    return @"";
}

#pragma mark 加密并转为base64编码的字符串
- (NSString *)AES128EncryptWithKey:(NSString *)key
                                iv:(NSString *)iv
{
    NSData *data    =
    [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *aesData =
    [data AES128EncryptWithKey:key iv:iv];
    
    NSString *base64str =
    [aesData base64EncodedStringWithOptions:
     NSDataBase64Encoding64CharacterLineLength];
    
    return base64str;
}

#pragma mark 解密base64编码的字符串
- (NSString *)AES128DecryptWithKey:(NSString *)key
                                iv:(NSString *)iv
{
    NSData *data    =
    [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    if (data.length == 0)
    {
        return @"";
    }
    
    NSData *aesData =
    [data AES128DecryptWithKey:key iv:iv];
    
    NSString *str   =
    [[NSString alloc] initWithData:aesData
                          encoding:NSUTF8StringEncoding];
    
    return str;
}

#pragma mark 16进制字符串转为二进制数据
- (NSData *)convertHexStringToData
{
    NSMutableData *hexData =
    [[NSMutableData alloc] initWithCapacity:[self length] * 2];
    
    NSRange range;
    
    if ([self length] %2==0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [self length]; i +=2) {
        unsigned int anInt;
        NSString *hexCharStr    =
        [self substringWithRange:range];
        NSScanner *scanner      =
        [[NSScanner alloc]initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        NSData *entity          =
        [[NSData alloc]initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        range.location          += range.length;
        range.length            = 2;
    }
    
    return hexData;
}

@end

id KKAES128Encrypt(id obj, NSString *key, NSString *iv)
{
    if ([obj isKindOfClass:[NSData class]])
    {
        return [((NSData *)obj) AES128EncryptWithKey:key iv:iv];
    }
    else if ([obj isKindOfClass:[NSString class]])
    {
        return [NSString AES128EncryptBase64String:obj key:key iv:iv];
    }
    return nil;
}

id KKAES128Decrypt(id obj, NSString *key, NSString *iv)
{
    if ([obj isKindOfClass:[NSData class]])
    {
        return [((NSData *)obj) AES128DecryptWithKey:key iv:iv];
    }
    else if ([obj isKindOfClass:[NSString class]])
    {
        return [NSString AES128DecryptBase64String:obj key:key iv:iv];
    }
    return nil;
}
