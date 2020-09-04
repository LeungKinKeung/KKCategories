//
//  NSFileManager+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import "NSFileManager+KK.h"


@implementation NSFileManager (KK)

#pragma mark 保存文件
BOOL SaveData(NSData *data , NSString * path)
{
    NSString *folder =
    [path stringByDeletingLastPathComponent];
    
    CreateDirectoryAtPath(folder);
    
    return [data writeToFile:path atomically:YES];
}

#pragma mark 是否存在
BOOL ExistsAtFilePath(NSString *path,BOOL isFile)
{
    NSFileManager *fileManager =
    [NSFileManager defaultManager];
    
    // 是否是文件夹
    BOOL isDirectory = NO;
    
    // 路径是否存在
    BOOL isExists = [fileManager fileExistsAtPath:path
                                      isDirectory:&isDirectory];
    
    // 存在并且...
    if (isExists && (isDirectory != isFile))
    {
        return YES;
    }else
    {
        return NO;
    }
}

/**
 *  文件是否存在
 */
BOOL FileExistsAtPath(NSString *path)
{
    return ExistsAtFilePath(path, YES);
}

/**
 *  文件夹是否存在
 */
BOOL DirectoryExistsAtPath(NSString *path)
{
    return ExistsAtFilePath(path, NO);
}


/**
 *  创建文件
 */
BOOL CreateFileAtPath(NSString *path)
{
    return CreateFileAtPathIfNeedClear(path,
                                       YES);
}

BOOL CreateFileAtPathIfNotExist(NSString * path)
{
    return CreateFileAtPathIfNeedClear(path,
                                       NO);
}

BOOL CreateFileAtPathIfNeedClear(NSString *path, BOOL isClear)
{
    NSFileManager *fileManager =
    [NSFileManager defaultManager];
    
    NSString *directoryPath = [path stringByDeletingLastPathComponent];
    
    if (CreateDirectoryAtPath(directoryPath) == NO)
    {
        return NO;
    }
    
    // 存在并且为文件
    if (FileExistsAtPath(path))
    {
        // 删除
        if (isClear)
        {
            NSError *error;
            
            [fileManager removeItemAtPath:path
                                    error:&error];
            
            if (error)
            {
                NSLog(@"移除文件%@出错！",path);
                return NO;
            }
        }else
        {
            return YES;
        }
    }
    BOOL result =
    [fileManager createFileAtPath:path
                         contents:nil
                       attributes:nil];
    
    if (result == YES)
    {
        NSLog(@"CREATED FILE:\n%@",path);
    }
    else
    {
        
        NSLog(@"CREATE FILE FAILED:\n:%@",path);
    }
    
    return result;
}

#pragma mark - 删除文件(文件夹)
BOOL RemoveItemAtPath(NSString * path, BOOL isDirectory)
{
    if (ExistsAtFilePath(path, !isDirectory) == NO)
    {
        NSLog(@"ERROR:ITEM NOT FOUND:%@",path);
        return NO;
    }
    
    NSFileManager *fileManager =
    [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    NSURL *url =
    [NSURL fileURLWithPath:path
               isDirectory:isDirectory];
    
    [fileManager removeItemAtURL:url
                           error:&error];
    
    if (error)
    {
        NSLog(@"REMOVE FILE FAILED:%@\n:%@",error.localizedDescription,path);
        
        return NO;
    }
    NSLog(@"REMOVED FILE:\n%@",path);
    
    return YES;
}

#pragma mark 移除文件
BOOL RemoveFileAtPath(NSString * path)
{
    return RemoveItemAtPath(path, NO);
}

#pragma mark 移除文件夹
BOOL RemoveFolderAtPath(NSString * path)
{
    return RemoveItemAtPath(path, YES);
}


#pragma mark 文件拷贝
BOOL FileCopy(NSString *src, NSString *des)
{
    if (FileExistsAtPath(src) == NO)
    {
        NSLog(@"COPY FILE FAILED:SRC PATH NOT FOUND:\n\
              SRC:%@",src);
        return NO;
    }
    if (FileExistsAtPath(des))
    {
        NSLog(@"COPY FILE FAILED:DES PATH IS EXIST:\n\
              SRC:%@\n\
              DES:%@",src,des);
        return NO;
    }
    NSFileManager *manager =
    [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    BOOL success =
    [manager copyItemAtPath:src
                     toPath:des
                      error:&error];
    
    if (error || success == NO)
    {
        NSLog(@"COPY FILE FAILED:%@\n\
              SRC:%@\n\
              DES:%@",error.localizedDescription,src,des);
        
        return NO;
    }
    
    return YES;
}

#pragma mark 移动文件
BOOL MoveFile(NSString *src, NSString *des)
{
    if (FileExistsAtPath(src) == NO)
    {
        NSLog(@"MOVE FILE FAILED:\
        SRC PATH NOT FOUND:\n\
        SRC:%@",src);
        return NO;
    }
    if (FileExistsAtPath(des) &&
        FileSize(src) == FileSize(des))
    {
        NSLog(@"MOVE FILE EXISTS:%@",des);
        return YES;
    }
    
    NSFileManager *manager =
    [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    [manager moveItemAtPath:src
                     toPath:des
                      error:&error];
    
    if (error)
    {
        NSLog(@"MOVE FILE FAILED:%@\n\
              SRC:%@\n\
              DES:%@",error.localizedDescription,src,des);
        return NO;
    }
    
    return YES;
}

#pragma mark 重命名文件或文件夹
BOOL RenameFileOrFolder(NSString *src,
                        NSString *name,
                        BOOL isFile)
{
    if (ExistsAtFilePath(src, isFile) == NO)
    {
        NSLog(@"RENAME FAILED:\
              SRC PATH NOT FOUND:\n\
              SRC:%@",src);
        return NO;
    }
    NSString *des =
    [src stringByDeletingLastPathComponent];
    
    des =
    [des stringByAppendingPathComponent:name];
    
    if (ExistsAtFilePath(des, isFile))
    {
        NSLog(@"RENAME FAILED:\
              FILE IS EXIST:\n\
              SRC:%@\n\
              NAME:%@",src,name);
        return NO;
    }
    
    NSFileManager *manager =
    [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    [manager moveItemAtPath:src
                     toPath:des
                      error:&error];
    
    if (error)
    {
        NSLog(@"RENAME FAILED:%@\n\
              SRC:%@\n\
              NAME:%@",error.localizedDescription,src,name);
        
        return NO;
    }
    
    return YES;
}
#pragma mark 文件重命名(name包含扩展名)
BOOL FileRename(NSString *src, NSString *name)
{
    return RenameFileOrFolder(src, name, YES);
}

#pragma mark 文件夹重命名
BOOL FolderRename(NSString *src, NSString *name)
{
    return RenameFileOrFolder(src, name, NO);
}

#pragma mark  文件大小
size_t FileSize(NSString * path)
{
    return GetFileLength(path);
}

#pragma mark 副本名，假如有此名称的文件存在，就在后面加上(n)
NSString *FilePathWithCopyName(NSString *des)
{
    NSString *fileType      = [des pathExtension];
    NSString *fileName      =
    [[des lastPathComponent] stringByDeletingPathExtension];
    
    NSString *folderPath    =
    [des stringByDeletingLastPathComponent];
    
    for (size_t i = 1; i < 100000; i++)
    {
        NSString *copyName  =
        [NSString stringWithFormat:@"%@ (%lu)",fileName,i];
        
        if (fileType.length > 0)
        {
            copyName =
            [copyName stringByAppendingPathExtension:fileType];
        }
        
        NSString *filePath  =
        [folderPath stringByAppendingPathComponent:copyName];
        
        if (FileExistsAtPath(filePath) == NO)
        {
            return filePath;
        }
    }
    NSLog(@"同名文件超过10万，不建议继续在此目录写入文件:%@",des);
    return nil;
}

#pragma mark 创建目录
BOOL CreateDirectoryAtPath(NSString *path)
{
    if (path == nil ||
        [path isEqualToString:@""])
    {
        NSLog(@"CREATE FOLDER FAILED: PATH IS EMPTY");
        return NO;
    }
    
    // 存在并且为文件夹
    if (DirectoryExistsAtPath(path))
    {
        return YES;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 否则创建一个文件夹
    NSError *error;
    
    [fileManager createDirectoryAtPath:path
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
    
    if (error)
    {
        NSLog(@"CREATE FOLDER FAILED:%@\n%@",path,error.localizedDescription);
        
        return NO;
    }
    return YES;
}

#pragma mark 获取文件大小
NSInteger GetFileLength(NSString * path)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDictionary *attr = [fileManager attributesOfItemAtPath:path
                                                       error:nil];
    
    NSNumber *sizeNumber = [attr objectForKey:NSFileSize];
    
    if (sizeNumber != nil)
    {
        return sizeNumber.integerValue;
    }
    
    return 0;
}

#pragma mark 是文件
BOOL IsFile(NSString *path)
{
    NSFileManager *fileManager =
    [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    if ([fileManager fileExistsAtPath:path
                          isDirectory:&isDir] == NO)
    {
        return NO;
    }
    
    return (isDir == NO);
}

#pragma mark 是文件夹
BOOL IsFolder(NSString *path)
{
    NSFileManager *fileManager =
    [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    if ([fileManager fileExistsAtPath:path
                          isDirectory:&isDir] == NO)
    {
        return NO;
    }
    
    return isDir;
}

#pragma mark 遍历文件/文件夹路径
NSArray *FolderEnumerator(NSString *path,
                          BOOL containsFile,
                          BOOL containsFolder)
{
    NSMutableArray *filePaths =
    [NSMutableArray array];
    
    NSFileManager *fileManager =
    [NSFileManager defaultManager];
    
    NSArray *list =
    [fileManager enumeratorAtPath:path].allObjects;
    
    for (NSString *fileName in list)
    {
        NSString *filePath =
        [path stringByAppendingPathComponent:fileName];
        
        BOOL isDir = NO;
        [fileManager fileExistsAtPath:filePath
                          isDirectory:&isDir];
        
        if (containsFolder && isDir)
        {
            [filePaths addObject:filePath];
        }
        else if (containsFile && isDir == NO)
        {
            [filePaths addObject:filePath];
        }
    }
    
    return filePaths;
}

#pragma mark 遍历文件路径
NSArray *FileEnumeratorAtFolder(NSString *path)
{
    return FolderEnumerator(path,
                            YES,
                            NO);
}

NSString *DocumentDirectoryPath(void)
{
    NSArray *list =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES);
    
    return  [list firstObject];
}

NSString *CachesDirectoryPath(void)
{
    NSArray *list =
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSAllDomainsMask, YES);
    
    return  [list firstObject];
}

NSString *DesktopDirectoryPath(void)
{
    NSArray *list =
    NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSAllDomainsMask, YES);
    
    return  [list firstObject];
}

NSString *DownloadDirectoryPath(void)
{
    NSArray *list =
    NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSAllDomainsMask, YES);
    
    return  [list firstObject];
}

NSString *PathJoin(NSString *directory, ...)
{
    if (directory) {
        
        NSString *path = directory;
        
        // 定义一个指向个数可变的参数列表指针；
        va_list args;
        // 用于存放取出的参数
        NSString *arg;
        // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
        va_start(args, directory);
        // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
        while ((arg = va_arg(args, NSString *))) {
            
            path = [path stringByAppendingPathComponent:arg];
        }
        
        // 清空参数列表，并置参数指针args无效
        va_end(args);
        
        return path;
    }
    return nil;
}


@end


@implementation DirectoryWatcher
{
    int dirFD;
    int kq;

    CFFileDescriptorRef dirKQRef;
}

@end
