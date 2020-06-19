//
//  DataCenter.h
//  tonghuashun
//
//  Created by 周粥 on 2019/5/15.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define iPX_LATER (STATUS_HEIGHT > 20.0f)
#define iPX_NAV_HEIGHT(x) (iPX_LATER ? ((x) + STATUS_HEIGHT - 20) : (x))
#define iPX_BOTTOM_BAR_HEIGHT(x) (iPX_LATER ? ((x) + 34) : (x))

typedef NS_ENUM (NSInteger, THSType) {
    THSTypesz = 0,
    THSTypessz = 1,
    THSTypecy = 2,
    THSTypecount = 3,
};

typedef NS_ENUM (NSInteger, THSStatus) {
    THSStatusNone = 0,
    THSStatuszzc = 1,
    THSStatuszyk = 2,
    THSStatuszsz = 3,
    THSStatusdyk = 4,
    
    THSStatusyyk = 11,
    THSStatusysy = 12,
    THSStatusysysz = 13,
    THSStatusysyssz = 14,
    THSStatusysycy = 15,
    
    THSStatusyyk3 = 21,
    THSStatusysy3 = 22,
    THSStatusysysz3 = 23,
    THSStatusysyssz3 = 24,
    THSStatusysycy3 = 25,
    
    THSStatusyyk6 = 31,
    THSStatusysy6 = 32,
    THSStatusysysz6 = 33,
    THSStatusysyssz6 = 34,
    THSStatusysycy6 = 35,
    
    THSStatusyyk12 = 41,
    THSStatusysy12 = 42,
    THSStatusysysz12 = 43,
    THSStatusysyssz12 = 44,
    THSStatusysycy12 = 45,
    
    THSStatusyyk24 = 51,
    THSStatusysy24 = 52,
    THSStatusysysz24 = 53,
    THSStatusysyssz24 = 54,
    THSStatusysycy24 = 55,
    
    THSStatushome = 61,
    THSStatuszixuan = 62,
    THSStatustrade = 63,
    
    THSStatusysz = 71,
    THSStatusysz3 = 72,
    THSStatusysz6 = 73,
    THSStatusysz12 = 74,
    THSStatusysz24 = 75,
    
    THSStatusyssz = 81,
    THSStatusyssz3 = 82,
    THSStatusyssz6 = 83,
    THSStatusyssz12 = 84,
    THSStatusyssz24 = 85,
    
    THSStatusycy = 91,
    THSStatusycy3 = 92,
    THSStatusycy6 = 93,
    THSStatusycy12 = 94,
    THSStatusycy24 = 95,
    
    THSStatus_yzzr = 101,
    THSStatus_yzzc = 102,
    THSStatus_cqzc = 103,
    THSStatus_jlr = 104,
    THSStatus_zhyk = 105,
    THSStatus_qmzc = 106,
};

@interface THSdata : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *zzc;
@property (nonatomic, copy) NSString *zyk;
@property (nonatomic, copy) NSString *zsz;
@property (nonatomic, copy) NSString *dyk;

@property (nonatomic, copy) NSString *yyk;
@property (nonatomic, copy) NSString *ysy;
@property (nonatomic, copy) NSString *ysysz;
@property (nonatomic, copy) NSString *ysyssz;
@property (nonatomic, copy) NSString *ysycy;

@property (nonatomic, copy) NSString *yyk3;
@property (nonatomic, copy) NSString *ysy3;
@property (nonatomic, copy) NSString *ysysz3;
@property (nonatomic, copy) NSString *ysyssz3;
@property (nonatomic, copy) NSString *ysycy3;

@property (nonatomic, copy) NSString *yyk6;
@property (nonatomic, copy) NSString *ysy6;
@property (nonatomic, copy) NSString *ysysz6;
@property (nonatomic, copy) NSString *ysyssz6;
@property (nonatomic, copy) NSString *ysycy6;

@property (nonatomic, copy) NSString *yyk12;
@property (nonatomic, copy) NSString *ysy12;
@property (nonatomic, copy) NSString *ysysz12;
@property (nonatomic, copy) NSString *ysyssz12;
@property (nonatomic, copy) NSString *ysycy12;

@property (nonatomic, copy) NSString *yyk24;
@property (nonatomic, copy) NSString *ysy24;
@property (nonatomic, copy) NSString *ysysz24;
@property (nonatomic, copy) NSString *ysyssz24;
@property (nonatomic, copy) NSString *ysycy24;

@property (nonatomic, copy) NSString *yzzr;
@property (nonatomic, copy) NSString *yzzc;
@property (nonatomic, copy) NSString *cqzc;
@property (nonatomic, copy) NSString *jlr;
@property (nonatomic, copy) NSString *zhyk;
@property (nonatomic, copy) NSString *qmzc;

@end

@interface THSzhexian : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSTimeInterval date;
@property (nonatomic, assign) double y;

@end

@interface THSobject : NSObject

// 单实例
+ (THSobject *)sharedInstance;

@property (nonatomic, strong) THSdata *data;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *mmonth;
@property (nonatomic, copy) NSString *dday;

@property (nonatomic, strong, readonly) NSMutableArray *indexAry;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, assign) NSInteger granularity;

- (void)downloadAll;

- (UIImage *)fileimage:(THSStatus)status;
- (NSString *)filepath:(THSStatus)status;
- (NSArray<THSzhexian *> *)getData:(THSType)type;
- (NSArray<THSzhexian *> *)getData3:(THSType)type;
- (NSArray<THSzhexian *> *)getData6:(THSType)type;
- (NSArray<THSzhexian *> *)getData12:(THSType)type;

+ (NSString *)positiveFormat:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
