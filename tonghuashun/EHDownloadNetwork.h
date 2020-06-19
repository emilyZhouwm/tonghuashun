//
//  EHDownloadNetwork.h
//
//  Created by zwm on 15/12/22.
//  Copyright © 2015年 zwm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EHCompletionBlock)(NSError *error);
typedef void (^EHProgressdBlock)(float progresFloat);
typedef void (^EHSpeedBlock)(long long speed);

@interface EHDownloadTask : NSObject

@property (nonatomic, assign) double progress;

- (void)pause;
- (void)start;
- (void)cancel;

@end

@interface EHDownloadNetwork : NSObject

/**
 下载文件（最好是zip）
 
 @param url 请传入全路径，下载地址
 @param filePath 存放地点，请传入Documents下的相对路径，比如appData/tpo1_2.zip
 @param completionBlock 完成回调
 @param progressBlock 进度
 */
+ (EHDownloadTask *)downloadUrl:(NSString *)url
                         toPath:(NSString *)filePath
                completionBlock:(EHCompletionBlock)completionBlock
                  progressBlock:(EHProgressdBlock)progressBlock;

/**
 下载文件 同上，增加下载速度

 @param url 请传入全路径，下载地址
 @param filePath 存放地点，请传入Documents下的相对路径，比如appData/tpo1_2.zip
 @param completionBlock 完成回调
 @param progressBlock 进度
 @param speedBlock 速度回调 字节
 @return task
 */
+ (EHDownloadTask *)downloadUrl:(NSString *)url
                         toPath:(NSString *)filePath
                completionBlock:(EHCompletionBlock)completionBlock
                  progressBlock:(EHProgressdBlock)progressBlock
                     speedBlock:(EHSpeedBlock)speedBlock;

/**
 下载文件 同上，增加是否开启断点续传
 
 @param url 请传入全路径，下载地址
 @param filePath 存放地点，请传入Documents下的相对路径，比如appData/tpo1_2.zip
 @param resume 是否启用断点续传
 @param completionBlock 完成回调
 @param progressBlock 进度
 @return task
 */
+ (EHDownloadTask *)downloadUrl:(NSString *)url
                         toPath:(NSString *)filePath
                         resume:(BOOL)resume
                completionBlock:(EHCompletionBlock)completionBlock
                  progressBlock:(EHProgressdBlock)progressBlock;

+ (EHDownloadNetwork *)sharedInstance;

@end
