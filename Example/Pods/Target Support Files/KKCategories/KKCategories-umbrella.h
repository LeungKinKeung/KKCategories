#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KKCategories.h"
#import "NSArray+KK.h"
#import "NSDate+KK.h"
#import "NSDictionary+KK.h"
#import "NSFileManager+KK.h"
#import "NSJSONSerialization+KK.h"
#import "NSString+KK.h"
#import "NSTimer+KK.h"

FOUNDATION_EXPORT double KKCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char KKCategoriesVersionString[];

