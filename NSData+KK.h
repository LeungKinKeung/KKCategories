//
//  NSData+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KK)

/// 加密数据
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

/// 解密数据
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

/// 转为16进制字符串
- (NSString *)hexString;

@end

@interface NSString (KKEncrypt)

/// 加密并转为base64编码的字符串
+ (NSString *)AES128EncryptBase64String:(NSString *)string
                                    key:(NSString *)key
                                     iv:(NSString *)iv;

/// 解密base64编码的字符串
+ (NSString *)AES128DecryptBase64String:(NSString *)string
                                    key:(NSString *)key
                                     iv:(NSString *)iv;

/// 加密并转为base64编码的字符串
- (NSString *)AES128EncryptWithKey:(NSString *)key
                                iv:(NSString *)iv;

/// 解密base64编码的字符串
- (NSString *)AES128DecryptWithKey:(NSString *)key
                                iv:(NSString *)iv;

/// 16进制字符串转为二进制数据
- (NSData *)convertHexStringToData;

@end

/// 加密NSData/NSString(返回base64编码字符串)
OBJC_EXTERN id KKAES128Encrypt(id obj, NSString *key, NSString *iv);

/// 解密NSData/NSString(base64)
OBJC_EXTERN id KKAES128Decrypt(id obj, NSString *key, NSString *iv);


NS_ASSUME_NONNULL_END
