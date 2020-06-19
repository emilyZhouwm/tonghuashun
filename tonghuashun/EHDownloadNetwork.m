//
//  EHDownloadNetwork.m
//
//  Created by zwm on 15/12/22.
//  Copyright © 2015年 zwm. All rights reserved.
//

#import "EHDownloadNetwork.h"
#import "AFNetworking.h"

@interface EHDownloadTask ()

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, assign) BOOL running;

@end

@implementation EHDownloadTask

- (void)dealloc
{
    [self cancel];
}

- (void)start
{
    if (!_running) {
        [_task resume];
        _running = TRUE;
    }
}

- (void)pause
{
    if (_running) {
        [_task suspend];
        _running = FALSE;
    }
}

- (void)cancel
{
    if (_task) {
        [_task cancel];
        _task = nil;
        _running = FALSE;
    }
}

@end

@interface EHDownloadNetwork ()

@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *taskList;

@property (nonatomic, assign) int64_t totalRead;    /**< 上一秒次写入的大小 */
@property (nonatomic, assign) long long speed;      //!< 下载速度
@property (nonatomic, strong) NSDate *date;         //!< 上一次写入的时间

@end

@implementation EHDownloadNetwork

+ (EHDownloadNetwork *)sharedInstance
{
    static EHDownloadNetwork *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EHDownloadNetwork alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.taskList = @[].mutableCopy;
    }
    return self;
}

+ (EHDownloadTask *)downloadUrl:(NSString *)url
                         toPath:(NSString *)filePath
                         resume:(BOOL)resume
                completionBlock:(EHCompletionBlock)completionBlock
                  progressBlock:(EHProgressdBlock)progressBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    unsigned long long downloadedBytes = 0;
    
    // 如果目标文件夹路径不存在的话，创建目标文件夹路径
    NSString *folderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[filePath stringByReplacingOccurrencesOfString:[filePath componentsSeparatedByString:@"/"].lastObject withString:@""]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    else {
        // 启用断点续传
        // 目标文件夹路径存在，再检查文件是否已经下载了一部分
        NSString *tempPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:filePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:tempPath]) {
            if (resume) {
                // 获取已下载的文件长度
                downloadedBytes = [self fileSizeForPath:tempPath];
                if (downloadedBytes > 0) {
                    NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
                    [request setValue:requestRange forHTTPHeaderField:@"Range"];
                }
            }
            else {
                // 不启用断点续传，删除已存在文件重新下载
                [[NSFileManager defaultManager] removeItemAtPath:tempPath error:nil];
            }
        }
    }
    // 不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    NSLog(@"\n===========download===========\n%@", url);
    
    EHDownloadTask *downloadTask = [[EHDownloadTask alloc] init];
    AFURLSessionManager *manager = [EHDownloadNetwork sharedInstance].manager;
    
    downloadTask.task = [manager downloadTaskWithRequest:request
                                                progress:^(NSProgress *_Nonnull downloadProgress) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        double progress = downloadProgress.fractionCompleted;
                                                        if (progress > 1.0) {
                                                            progress = 1.0;
                                                        }
                                                        downloadTask.progress = progress;
                                                        if (progressBlock) {
                                                            progressBlock(progress);
                                                        }
                                                    });
                                                } destination:^NSURL *_Nonnull (NSURL *_Nonnull targetPath, NSURLResponse *_Nonnull response) {
                                                    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                                    NSURL *destUrl = [documentsDirectoryURL URLByAppendingPathComponent:filePath];
                                                    return destUrl;
                                                } completionHandler:^(NSURLResponse *_Nonnull response, NSURL *_Nullable filePath, NSError *_Nullable error) {
                                                    [[EHDownloadNetwork sharedInstance].taskList removeObject:downloadTask];
                                                    if (error) {
                                                        NSLog(@"\n===========download failure===========\n%@:\n%@", url, error);
                                                        if (completionBlock) {
                                                            if (error.localizedDescription.length > 0) {
                                                                error = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:nil];
                                                            }
                                                            completionBlock(error);
                                                        }
                                                    } else {
                                                        NSLog(@"\n===========download success===========\n%@:\n%@", url, filePath);
                                                        if (completionBlock) {
                                                            completionBlock(nil);
                                                        }
                                                    }
                                                }];
    [downloadTask start];
    [[EHDownloadNetwork sharedInstance].taskList addObject:downloadTask];
    return downloadTask;
}

// 下载文件，最好是zip文件
+ (EHDownloadTask *)downloadUrl:(NSString *)url
                         toPath:(NSString *)destPath
                completionBlock:(EHCompletionBlock)completionBlock
                  progressBlock:(EHProgressdBlock)progressBlock
{
    
    return [self downloadUrl:url toPath:destPath resume:true completionBlock:completionBlock progressBlock:progressBlock];
}

+ (EHDownloadTask *)downloadUrl:(NSString *)url
                         toPath:(NSString *)filePath
                completionBlock:(EHCompletionBlock)completionBlock
                  progressBlock:(EHProgressdBlock)progressBlock
                     speedBlock:(EHSpeedBlock)speedBlock {

    AFURLSessionManager *manager = [EHDownloadNetwork sharedInstance].manager;
    //    session                   ：会话
    //    downloadTask              ：下载任务
    //    bytesWritten              ：本次下载字节数
    //    totalBytesWritten         ：已经下载的字节数
    //    totalBytesExpectedToWrite ：总下载字节数
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session,
                                                NSURLSessionDownloadTask * _Nonnull downloadTask,
                                                int64_t bytesWritten,
                                                int64_t totalBytesWritten,
                                                int64_t totalBytesExpectedToWrite) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 累加
            [EHDownloadNetwork sharedInstance].totalRead += bytesWritten;

            NSDate *currentDate = [NSDate date];

            if (![EHDownloadNetwork sharedInstance].date) {
                [EHDownloadNetwork sharedInstance].date = [NSDate date];
            }

            // 当前时间和上一秒时间做对比，大于等于一秒就去计算
            if ([currentDate timeIntervalSinceDate:[EHDownloadNetwork sharedInstance].date] >= 1) {
                // 时间差
                double time = [currentDate timeIntervalSinceDate:[EHDownloadNetwork sharedInstance].date];
                // 计算速度
                [EHDownloadNetwork sharedInstance].speed = [EHDownloadNetwork sharedInstance].totalRead / time;
                // 维护变量，将计算过的清零
                [EHDownloadNetwork sharedInstance].totalRead = 0.0;
                // 维护变量，记录这次计算的时间
                [EHDownloadNetwork sharedInstance].date = currentDate;
            }

            if (speedBlock) {
                speedBlock([EHDownloadNetwork sharedInstance].speed);
            }
        });
    }];
    return [EHDownloadNetwork downloadUrl:url toPath:filePath completionBlock:completionBlock progressBlock:progressBlock];
}

// 获取已下载的文件大小
+ (unsigned long long)fileSizeForPath:(NSString *)path
{
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {

        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

@end
