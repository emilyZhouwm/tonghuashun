//
//  DataCenter.m
//  tonghuashun
//
//  Created by 周粥 on 2019/5/15.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import "DataCenter.h"
#import "LKDBHelper.h"
#import "EHDownloadNetwork.h"

@implementation THSdata

- (instancetype)init
{
    if (self = [super init]) {
        _userID = @"0";
        
        _zzc = @"10000000";
        _zyk = @"100000";
        _zsz = @"20000000";
        _dyk = @"20000";
        
        _yyk = @"10000.00";
        _ysy = @"7.35";
        _ysysz = @"-4.94";
        _ysyssz = @"-6.05";
        _ysycy = @"-7.35";
        
        _yyk3 = @"30000.00";
        _ysy3 = @"0.64";
        _ysysz3 = @"-0.50";
        _ysyssz3 = @"0.64";
        _ysycy3 = @"-2.05";
        
        _yyk6 = @"60000.00";
        _ysy6 = @"18.33";
        _ysysz6 = @"13.07";
        _ysyssz6 = @"18.33";
        _ysycy6 = @"13.15";
        
        _yyk12 = @"120000.00";
        _ysy12 = @"25.00";
        _ysysz12 = @"16.54";
        _ysyssz12 = @"25.55";
        _ysycy12 = @"19.54";
        
        _yyk24 = @"240000.00";
        _ysy24 = @"18.33";
        _ysysz24 = @"12.30";
        _ysyssz24 = @"18.33";
        _ysycy24 = @"12.45";
        
        _yzzr = @"1000";
        _yzzc = @"0.00";
        _cqzc = @"100";
        _jlr = @"1000";
        _zhyk = @"1000";
        _qmzc = @"10000";
    }
    return self;
}

+ (NSString *)getPrimaryKey
{
    return @"userID";
}

@end

@implementation THSzhexian

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

@end

@interface THSobject ()

@property (strong, nonatomic) NSArray<NSMutableArray<THSzhexian *> *> *dataAry;
@property (strong, nonatomic) NSArray<NSArray *> *idAry;
@property (strong, nonatomic) NSMutableArray *indexAry;

@end

@implementation THSobject

- (instancetype)init
{
    if (self = [super init]) {
        _data = [THSdata searchSingleWithWhere:nil orderBy:nil];
        if (!_data) {
            _data = [[THSdata alloc] init];
            [_data saveToDB];
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDate *date = [NSDate date];
        dateFormatter.dateFormat = @"yyyy";
        _year = [dateFormatter stringFromDate:date];
        dateFormatter.dateFormat = @"M";
        _month = [dateFormatter stringFromDate:date];
        dateFormatter.dateFormat = @"d";
        _day = [dateFormatter stringFromDate:date];
        dateFormatter.dateFormat = @"MM";
        _mmonth = [dateFormatter stringFromDate:date];
        dateFormatter.dateFormat = @"dd";
        _dday = [dateFormatter stringFromDate:date];

        [EHDownloadNetwork downloadUrl:@"http://quotes.money.163.com/service/chddata.html?code=0000001&start=20181101&end=20190101&fields=PCHG" toPath:@"x.csv" completionBlock:nil progressBlock:nil];
        
        
        _dataAry = @[@[].mutableCopy, @[].mutableCopy, @[].mutableCopy];
        _idAry = @[@[@"0000001", @"000001.csv"], @[@"1399001", @"399001.csv"], @[@"1399006", @"399006.csv"]];
        [self readData:THSTypesz];
        [self readData:THSTypessz];
        [self readData:THSTypecy];
    }
    return self;
}

// 下载数据
- (void)downloadAll
{
    [self downloadData:THSTypesz];
    [self downloadData:THSTypessz];
    [self downloadData:THSTypecy];
}

- (void)downloadData:(THSType)type
{
    __weak __typeof(self) weakself = self;
    NSString *url = [NSString stringWithFormat:@"http://quotes.money.163.com/service/chddata.html?code=%@&start=20181101&end=%@%@%@&fields=PCHG", _idAry[type][0], _year, _mmonth, _dday];
    [EHDownloadNetwork downloadUrl:url toPath:_idAry[type][1] resume:NO completionBlock:^(NSError *error) {
        if (error) {
            NSLog(@"下载失败");
        } else {
            [weakself readData:type];
        }
    } progressBlock:^(float progresFloat) {
        
    }];
}

// 读取数据
- (void)readData:(THSType)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSString *filepath = [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], _idAry[type][1]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:_idAry[type][1] ofType:@""];
        [[NSFileManager defaultManager] copyItemAtPath:path toPath:filepath error:nil];
    }
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *contents = [[NSString alloc] initWithContentsOfFile:filepath encoding:enc error:nil];
    NSArray *contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSArray *temp, *timeDataArr;
    [_dataAry[type] removeAllObjects];
    for (NSInteger idx = 1; idx < contentsArray.count; idx++) {
        timeDataArr = [contentsArray[idx] componentsSeparatedByString:@","];
        if (timeDataArr.count > 1) {
            temp = [timeDataArr[0] componentsSeparatedByString:@"-"];
            THSzhexian *zhexian = [[THSzhexian alloc] init];
            zhexian.year = [temp[0] integerValue];
            zhexian.month = [temp[1] integerValue];
            zhexian.day = [temp[2] integerValue];
            zhexian.y =  [timeDataArr[3] doubleValue];
            zhexian.date = [[dateFormatter dateFromString:timeDataArr[0]] timeIntervalSince1970];
            [_dataAry[type] addObject:zhexian];
        }
    }
}

- (BOOL)isMonday:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    return week == 2;
}

// 当月 4号30日-下月1号 每周一
- (NSArray<THSzhexian *> *)getData:(THSType)type
{
    NSMutableArray *ret = @[].mutableCopy;
    _indexAry = @[].mutableCopy;

    NSInteger tempday = 1;
    NSInteger tempint = [_month intValue];
   NSInteger tempyear = [_year intValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;

    // 获取当月的天数
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    for (NSInteger i=0; i<range.length; i++) {
        NSDate *de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-%02zd", tempyear, tempint, tempday]];
        tempday++;
        comps = [calendar components:unitFlags fromDate:de];
        if ([comps weekday] == 2) {
            [_indexAry addObject:@([de timeIntervalSince1970])];
        }
    }

    for (NSInteger idx = 0; idx < _dataAry[type].count; idx++) {
        THSzhexian *zhexian = _dataAry[type][idx];
        
        if ([_month integerValue] == zhexian.month) {
            [ret insertObject:zhexian atIndex:0];
        } else {
            THSzhexian *next = [[THSzhexian alloc] init];
            next.year = zhexian.year;
            next.month = zhexian.month;
            next.day = zhexian.day;
            next.date = zhexian.date;
            next.y = 0.0000f;
            [ret insertObject:next atIndex:0];
            break;
        }
    }
    
    return ret;
}

// 三月 2月28号-6月1号 每月1
- (NSArray<THSzhexian *> *)getData3:(THSType)type
{
    NSMutableArray *ret = @[].mutableCopy;
    _indexAry = @[].mutableCopy;
    
    NSInteger tempint = 0;
    NSInteger tempyear = 0;
    tempint = [_month intValue];
    tempyear = [_year intValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", tempyear, tempint]];
    [_indexAry insertObject:@([de timeIntervalSince1970]) atIndex:0];

    tempint = [_month intValue] - 1;
    tempyear = tempint <= 0 ? [_year intValue] - 1 : [_year intValue];
    tempint = tempint <= 0 ? 12 + tempint : tempint;
    de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", tempyear, tempint]];
    [_indexAry insertObject:@([de timeIntervalSince1970]) atIndex:0];
    
    tempint = [_month intValue] - 2;
    tempyear = tempint <= 0 ? [_year intValue] - 1 : [_year intValue];
    tempint = tempint <= 0 ? 12 + tempint : tempint;
    de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", tempyear, tempint]];
    [_indexAry insertObject:@([de timeIntervalSince1970]) atIndex:0];
    
    for (NSInteger idx = 0; idx < _dataAry[type].count; idx++) {
        THSzhexian *zhexian = _dataAry[type][idx];
        
        if (zhexian.year > tempyear || zhexian.month >= tempint) {
            [ret insertObject:zhexian atIndex:0];
        } else {
            THSzhexian *next = [[THSzhexian alloc] init];
            next.year = zhexian.year;
            next.month = zhexian.month;
            next.day = zhexian.day;
            next.date = zhexian.date;
            next.y = 0.0000f;
            [ret insertObject:next atIndex:0];
            break;
        }
    }
    
    return ret;
}

// 近半年 11月30号-6月1号 隔月1
- (NSArray<THSzhexian *> *)getData6:(THSType)type
{
    NSMutableArray *ret = @[].mutableCopy;
    _indexAry = @[].mutableCopy;
    
    NSInteger tempint = 0;
    NSInteger tempyear = 0;
    tempint = [_month intValue];
    tempyear = [_year intValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", tempyear, tempint]];
    [_indexAry insertObject:@([de timeIntervalSince1970]) atIndex:0];
    
    tempint = [_month intValue] - 2;
    tempyear = tempint <= 0 ? [_year intValue] - 1 : [_year intValue];
    tempint = tempint <= 0 ? 12 + tempint : tempint;
    de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", tempyear, tempint]];
    [_indexAry insertObject:@([de timeIntervalSince1970]) atIndex:0];
    
    tempint = [_month intValue] - 4;
    tempyear = tempint <= 0 ? [_year intValue] - 1 : [_year intValue];
    tempint = tempint <= 0 ? 12 + tempint : tempint;
    de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", tempyear, tempint]];
    [_indexAry insertObject:@([de timeIntervalSince1970]) atIndex:0];
    
    tempint = [_month intValue] - 5;
    tempyear = tempint <= 0 ? [_year intValue] - 1 : [_year intValue];
    tempint = tempint <= 0 ? 12 + tempint : tempint;
    
    for (NSInteger idx = 0; idx < _dataAry[type].count; idx++) {
        THSzhexian *zhexian = _dataAry[type][idx];
        
        if (zhexian.year > tempyear || zhexian.month >= tempint) {
            [ret insertObject:zhexian atIndex:0];
        } else {
            THSzhexian *next = [[THSzhexian alloc] init];
            next.year = zhexian.year;
            next.month = zhexian.month;
            next.day = zhexian.day;
            next.date = zhexian.date;
            next.y = 0.0000f;
            [ret insertObject:next atIndex:0];
            break;
        }
    }
    
    return ret;
}

// 今年 12月28日，逐月1
- (NSArray<THSzhexian *> *)getData12:(THSType)type
{
    NSMutableArray *ret = @[].mutableCopy;
    _indexAry = @[].mutableCopy;
    
    NSInteger tempint = 0;
    NSInteger tempyear = 0;
    tempint = [_month intValue];
    tempyear = [_year intValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    while (tempint > 0) {
        NSDate *de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", tempyear, tempint]];
        [_indexAry insertObject:@([de timeIntervalSince1970]) atIndex:0];
        tempint--;
    }

    for (NSInteger idx = 0; idx < _dataAry[type].count; idx++) {
        THSzhexian *zhexian = _dataAry[type][idx];
        
        if (zhexian.month >= 1 && zhexian.year == tempyear) {
            [ret insertObject:zhexian atIndex:0];
        } else {
            THSzhexian *next = [[THSzhexian alloc] init];
            next.year = zhexian.year;
            next.month = zhexian.month;
            next.day = zhexian.day;
            next.date = zhexian.date;
            next.y = 0.0000f;
            [ret insertObject:next atIndex:0];
            break;
        }
    }
    
    return ret;
}

+ (THSobject *)sharedInstance
{
    static THSobject *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[THSobject alloc] init];
    });
    return sharedInstance;
}

+ (NSString *)positiveFormat:(NSString *)text
{
    if (!text || [text floatValue] == 0.00) {
        return @"0.00";
    } else {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"0.00";
}

- (UIImage *)fileimage:(THSStatus)status
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filepath = [NSString stringWithFormat:@"%@/%ld", path, (long)status];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        if (status == THSStatushome) {
            path = iPX_LATER ? @"首页1" : @"首页";
        } else if (status == THSStatuszixuan) {
            path = iPX_LATER ? @"zixuan1" : @"zixuan";
        } else if (status == THSStatustrade) {
            path = iPX_LATER ? @"交易1" : @"交易";
        } else if (status == THSStatusNone) {
            path = iPX_LATER ? @"IMG_5746_meitu_2" : @"IMG_1644_meitu_1";
        } else {
            path = iPX_LATER ? @"折线图示范1" : @"折线图示范";
        }
        NSData *data = UIImagePNGRepresentation([UIImage imageNamed:path]);
        [data writeToFile:filepath atomically:YES];
    }
    return [UIImage imageWithContentsOfFile:filepath];
}

- (NSString *)filepath:(THSStatus)status
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filepath = [NSString stringWithFormat:@"%@/%ld", path, (long)status];
    return filepath;
}

@end

