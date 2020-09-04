//
//  NSFileManager+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (KK)

/// 保存文件
OBJC_EXTERN BOOL SaveData(NSData *data , NSString *path);

/// 文件是否存在
OBJC_EXTERN BOOL FileExistsAtPath(NSString *path);

/// 文件夹是否存在
OBJC_EXTERN BOOL DirectoryExistsAtPath(NSString *path);

/// 创建文件 假如存在就移除再创建
OBJC_EXTERN BOOL CreateFileAtPath(NSString *path);

/// 删除文件
OBJC_EXTERN BOOL RemoveFileAtPath(NSString *path);

/// 删除文件夹
OBJC_EXTERN BOOL RemoveFolderAtPath(NSString *path);

/// 文件拷贝(假如已存在就不拷贝)
OBJC_EXTERN BOOL FileCopy(NSString *src, NSString *des);

/// 移动文件(假如已存在相同大小的同名文件就不移动)
OBJC_EXTERN BOOL MoveFile(NSString *src, NSString *des);

/// 文件重命名(包含扩展名，假如已存在就不重命名)
OBJC_EXTERN BOOL FileRename(NSString *src, NSString *name);

/// 文件夹重命名
OBJC_EXTERN BOOL FolderRename(NSString *src, NSString *name);

/// 文件大小
OBJC_EXTERN size_t FileSize(NSString *path);

/// 副本名，假如有此名称的文件存在，就在后面加上(n)
OBJC_EXTERN NSString *FilePathWithCopyName(NSString *des);

/// 不存在就创建文件
OBJC_EXTERN BOOL CreateFileAtPathIfNotExist(NSString *path);

/// 创建文件 并且是否需要清除内容
OBJC_EXTERN BOOL CreateFileAtPathIfNeedClear(NSString *path,                                            BOOL isClear);

/// 假如目录不存在就创建目录
OBJC_EXTERN BOOL CreateDirectoryAtPath(NSString *path);

/// 获取文件大小
OBJC_EXTERN NSInteger GetFileLength(NSString *path);

/// 是文件
OBJC_EXTERN BOOL IsFile(NSString *path);

/// 是文件夹
OBJC_EXTERN BOOL IsFolder(NSString *path);

/// 遍历文件/文件夹路径
OBJC_EXTERN NSArray *FolderEnumerator(NSString *path,
                                      BOOL containsFile,
                                      BOOL containsFolder);

/// 遍历文件路径
OBJC_EXTERN NSArray *FileEnumeratorAtFolder(NSString *path);

///  文档目录路径
OBJC_EXTERN NSString *DocumentDirectoryPath(void);

///  缓存目录路径
OBJC_EXTERN NSString *CachesDirectoryPath(void);

///  桌面目录路径(macOS available)
OBJC_EXTERN NSString *DesktopDirectoryPath(void);

///  下载目录路径
OBJC_EXTERN NSString *DownloadDirectoryPath(void);

///  路径拼接
OBJC_EXTERN NSString *PathJoin(NSString *directory, ...) NS_REQUIRES_NIL_TERMINATION;

@end

//typedef NS_ENUM(NSUInteger, KKDirectoryChangeType) {
//    KKDirectoryChangeTypeAdd,
//    KKDirectoryChangeTypeClear,
//    KKDirectoryChangeType,
//};

@interface KKDirectoryWatcher : NSObject

+ (instancetype)watchFolderWithPath:(NSString *)watchPath handle:(void (^)(void))handle;

- (void)invalidate;

@end
