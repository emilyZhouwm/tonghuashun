//
//  DetailViewController.m
//  tonghuashun
//
//  Created by 周文敏 on 2019/5/1.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "DataCenter.h"
#import "DetailVC.h"
#import "tonghuashun-Swift.h"
@import Charts;

@interface DetailViewController () <DetailCellDelegate, DetailVCDelegate>

@property (weak, nonatomic) IBOutlet UILabel *navtitle1;
@property (weak, nonatomic) IBOutlet UILabel *navtitle;
@property (weak, nonatomic) IBOutlet UILabel *navnumber;

@property (weak, nonatomic) IBOutlet UILabel *headtitle;
@property (weak, nonatomic) IBOutlet UILabel *headnumber;
@property (weak, nonatomic) IBOutlet UILabel *headpercent;

@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *tempView;
@property (weak, nonatomic) IBOutlet UIImageView *topbar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maskLayout;

@property (nonatomic, strong) DetailVC *vc;

@property (nonatomic, assign) NSInteger dindex;
@property (nonatomic, assign) NSInteger detailindex;

@property (nonatomic, strong) UIColor *red;
@property (nonatomic, strong) UIColor *blue;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _red = [UIColor colorWithRed:213/255.0 green:67/255.0 blue:58/255.0 alpha:1.0];
    _blue = [UIColor colorWithRed:92/255.0 green:143/255.0 blue:231/255.0 alpha:1.0];
    _dindex = 1;
    _detailindex = 1;
    
    _maskLayout.constant = STATUS_HEIGHT;
  
    _tempView.hidden = NO;
    [self.view bringSubviewToFront:_tempView];
    [self.view bringSubviewToFront:_topbar];
    _tempView.image = [UIImage imageNamed:iPX_LATER ? @"分析1" : @"分析"];
    _tableView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.alpha = 1;
    } completion:^(BOOL finished) {
        [self showdata];
        self.tempView.hidden = YES;
    }];

}

- (void)showdata
{
    DetailCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    cell.yzzr.text = [THSobject positiveFormat:[THSobject sharedInstance].data.yzzr];
    cell.yzzc.text = [THSobject positiveFormat:[THSobject sharedInstance].data.yzzc];
    cell.cqzc.text = [THSobject positiveFormat:[THSobject sharedInstance].data.cqzc];
    cell.jlr.text = [THSobject positiveFormat:[THSobject sharedInstance].data.jlr];
    cell.zhyk.text = [THSobject positiveFormat:[THSobject sharedInstance].data.zhyk];
    cell.qmzc.text = [THSobject positiveFormat:[THSobject sharedInstance].data.qmzc];
    float temp = 0.00f;
    float me = 0.00f;
    NSInteger tempint = 0;
    NSInteger tempyear = 0;
    cell.szbackview1.backgroundColor = _red;
    cell.sszbackview1.backgroundColor = _red;
    cell.cybackview1.backgroundColor = _red;
    float limit;
    float max;
    float ysysz = 0;
    float ysyssz = 0;
    float ysycy = 0;
    NSArray<THSzhexian *> *ary = @[];
    NSArray<THSzhexian *> *arysz = @[];
    NSArray<THSzhexian *> *aryssz = @[];
    NSArray<THSzhexian *> *arycy = @[];
    
    switch (_detailindex) {
        case 1://本月
            arysz = [[THSobject sharedInstance] getData:THSTypesz];
            aryssz = [[THSobject sharedInstance] getData:THSTypessz];
            arycy = [[THSobject sharedInstance] getData:THSTypecy];
            for (int i =0; i<arysz.count; i++) {
                ysysz += arysz[i].y;
            }
            for (int i =0; i<aryssz.count; i++) {
                ysyssz += aryssz[i].y;
            }
            for (int i =0; i<arycy.count; i++) {
                ysycy += arycy[i].y;
            }
            
            _navnumber.text = [NSString stringWithFormat:@"%@-%@-01~%@-%@-%@", [THSobject sharedInstance].year, [THSobject sharedInstance].mmonth, [THSobject sharedInstance].year, [THSobject sharedInstance].mmonth, [THSobject sharedInstance].dday];
            _headtitle.text = [NSString stringWithFormat:@"本月盈亏( %@ 月 )", [THSobject sharedInstance].month];
            _headnumber.text = [NSString stringWithFormat:@"%.2f", [[THSobject sharedInstance].data.yyk floatValue]];
            _headpercent.text = [NSString stringWithFormat:@"收益率:%.2f%%", [[THSobject sharedInstance].data.ysy floatValue]];
    
            //ysysz = [[THSobject sharedInstance].data.ysysz floatValue];
            //ysyssz = [[THSobject sharedInstance].data.ysyssz floatValue];
            //ysycy = [[THSobject sharedInstance].data.ysycy floatValue];
            switch (_dindex) {
                case 1:// 上证
                    ary = [[THSobject sharedInstance] getData:THSTypesz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusysz];
                    
                    me = [[THSobject sharedInstance].data.ysy floatValue];
                    temp = me - ysysz;
                   break;
                case 2:// 深证
                    ary = [[THSobject sharedInstance] getData:THSTypessz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusyssz];
                    
                    me = [[THSobject sharedInstance].data.ysy floatValue];
                    temp = me - ysyssz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"本月跑%@深证成指", temp > 0.00f ? @"赢" : @"输"];
                    break;
                case 3:// 创业
                    ary = [[THSobject sharedInstance] getData:THSTypecy];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusycy];
                    
                    me = [[THSobject sharedInstance].data.ysy floatValue];
                    temp = me - ysycy;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"本月跑%@创业板指", temp > 0.00f ? @"赢" : @"输"];
                   break;
                default:
                    break;
            }
            cell.bottomnumber.text = [NSString stringWithFormat:@"%.2f%%", temp];
            cell.bottomnumber.textColor =  temp > 0.00f ? _red : _blue;
            break;
        case 2://三月
            arysz = [[THSobject sharedInstance] getData3:THSTypesz];
            aryssz = [[THSobject sharedInstance] getData3:THSTypessz];
            arycy = [[THSobject sharedInstance] getData3:THSTypecy];
            for (int i =0; i<arysz.count; i++) {
                ysysz += arysz[i].y;
            }
            for (int i =0; i<aryssz.count; i++) {
                ysyssz += aryssz[i].y;
            }
            for (int i =0; i<arycy.count; i++) {
                ysycy += arycy[i].y;
            }
            
            tempint = [[THSobject sharedInstance].month intValue] - 2;
            tempyear = tempint <= 0 ? [[THSobject sharedInstance].year intValue] - 1 : [[THSobject sharedInstance].year intValue];
            tempint = tempint <= 0 ? 12 + tempint : tempint;
            _navnumber.text = [NSString stringWithFormat:@"%@-%02zd-01~%@-%@-%@", [THSobject sharedInstance].year, tempint, [THSobject sharedInstance].year, [THSobject sharedInstance].mmonth, [THSobject sharedInstance].dday];
            _headtitle.text = @"近三月盈亏";
            _headnumber.text = [NSString stringWithFormat:@"%.2f", [[THSobject sharedInstance].data.yyk3 floatValue]];
            _headpercent.text = [NSString stringWithFormat:@"收益率:%.2f%%", [[THSobject sharedInstance].data.ysy3 floatValue]];
            
            //ysysz = [[THSobject sharedInstance].data.ysysz3 floatValue];
            //ysyssz = [[THSobject sharedInstance].data.ysyssz3 floatValue];
            //ysycy = [[THSobject sharedInstance].data.ysycy3 floatValue];
            switch (_dindex) {
                case 1:// 上证
                    ary = [[THSobject sharedInstance] getData3:THSTypesz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusysz3];
                    
                    me = [[THSobject sharedInstance].data.ysy3 floatValue];
                    temp = me - ysysz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近三月跑%@上证指数", temp > 0.00f ? @"赢" : @"输"];
                   break;
                case 2:// 深证
                    ary = [[THSobject sharedInstance] getData3:THSTypessz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusyssz3];
                    
                    me = [[THSobject sharedInstance].data.ysy3 floatValue];
                    temp = me - ysyssz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近三月跑%@深证成指", temp > 0.00f ? @"赢" : @"输"];
                   break;
                case 3:// 创业
                    ary = [[THSobject sharedInstance] getData3:THSTypecy];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusycy3];
                    
                    me = [[THSobject sharedInstance].data.ysy3 floatValue];
                    temp = me - ysycy;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近三月跑%@创业板指", temp > 0.00f ? @"赢" : @"输"];
                   break;
                default:
                    break;
            }
            cell.bottomnumber.text = [NSString stringWithFormat:@"%.2f%%", temp];
            cell.bottomnumber.textColor =  temp > 0.00f ? _red : _blue;
            break;
        case 3://半年
            arysz = [[THSobject sharedInstance] getData6:THSTypesz];
            aryssz = [[THSobject sharedInstance] getData6:THSTypessz];
            arycy = [[THSobject sharedInstance] getData6:THSTypecy];
            for (int i =0; i<arysz.count; i++) {
                ysysz += arysz[i].y;
            }
            for (int i =0; i<aryssz.count; i++) {
                ysyssz += aryssz[i].y;
            }
            for (int i =0; i<arycy.count; i++) {
                ysycy += arycy[i].y;
            }
            
            tempint = [[THSobject sharedInstance].month intValue] - 5;
            tempyear = tempint <= 0 ? [[THSobject sharedInstance].year intValue] - 1 : [[THSobject sharedInstance].year intValue];
            tempint = tempint <= 0 ? 12 + tempint : tempint;

            _navnumber.text = [NSString stringWithFormat:@"%zd-%02zd-01~%@-%@-%@", tempyear, tempint, [THSobject sharedInstance].year, [THSobject sharedInstance].mmonth, [THSobject sharedInstance].dday];
            _headtitle.text = @"近半年盈亏";
            _headnumber.text = [NSString stringWithFormat:@"%.2f", [[THSobject sharedInstance].data.yyk6 floatValue]];
            _headpercent.text = [NSString stringWithFormat:@"收益率:%.2f%%", [[THSobject sharedInstance].data.ysy6 floatValue]];
            
            //ysysz = [[THSobject sharedInstance].data.ysysz6 floatValue];
            //ysyssz = [[THSobject sharedInstance].data.ysyssz6 floatValue];
            //ysycy = [[THSobject sharedInstance].data.ysycy6 floatValue];
            switch (_dindex) {
                case 1:// 上证
                    ary = [[THSobject sharedInstance] getData6:THSTypesz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusysz6];
                    
                    me = [[THSobject sharedInstance].data.ysy6 floatValue];
                    temp = me - ysysz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近半年跑%@上证指数", temp > 0.00f ? @"赢" : @"输"];
                    break;
                case 2:// 深证
                    ary = [[THSobject sharedInstance] getData6:THSTypessz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusyssz6];
                    
                    me = [[THSobject sharedInstance].data.ysy6 floatValue];
                    temp = me - ysyssz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近半年跑%@深证成指", temp > 0.00f ? @"赢" : @"输"];
                   break;
                case 3:// 创业
                    ary = [[THSobject sharedInstance] getData6:THSTypecy];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusycy6];
                    
                    me = [[THSobject sharedInstance].data.ysy6 floatValue];
                    temp = me - ysycy;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近半年跑%@创业板指", temp > 0.00f ? @"赢" : @"输"];
                   break;
                default:
                    break;
            }
            cell.bottomnumber.text = [NSString stringWithFormat:@"%.2f%%", temp];
            cell.bottomnumber.textColor =  temp > 0.00f ? _red : _blue;
            break;
        case 4://今年
            arysz = [[THSobject sharedInstance] getData12:THSTypesz];
            aryssz = [[THSobject sharedInstance] getData12:THSTypessz];
            arycy = [[THSobject sharedInstance] getData12:THSTypecy];
            for (int i =0; i<arysz.count; i++) {
                ysysz += arysz[i].y;
            }
            for (int i =0; i<aryssz.count; i++) {
                ysyssz += aryssz[i].y;
            }
            for (int i =0; i<arycy.count; i++) {
                ysycy += arycy[i].y;
            }
            
            _navnumber.text = [NSString stringWithFormat:@"%@-01-01~%@-%@-%@", [THSobject sharedInstance].year, [THSobject sharedInstance].year, [THSobject sharedInstance].mmonth, [THSobject sharedInstance].dday];
            _headtitle.text = @"今年盈亏";
            _headnumber.text = [NSString stringWithFormat:@"%.2f", [[THSobject sharedInstance].data.yyk12 floatValue]];
            _headpercent.text = [NSString stringWithFormat:@"收益率:%.2f%%", [[THSobject sharedInstance].data.ysy12 floatValue]];
            
            //ysysz = [[THSobject sharedInstance].data.ysysz12 floatValue];
            //ysyssz = [[THSobject sharedInstance].data.ysyssz12 floatValue];
            //ysycy = [[THSobject sharedInstance].data.ysycy12 floatValue];
            switch (_dindex) {
                case 1:// 上证
                    ary = [[THSobject sharedInstance] getData12:THSTypesz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusysz12];
                    
                    me = [[THSobject sharedInstance].data.ysy12 floatValue];
                    temp = me - ysysz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"今年跑%@上证指数", temp > 0.00f ? @"赢" : @"输"];
                    break;
                case 2:// 深证
                    ary = [[THSobject sharedInstance] getData12:THSTypessz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusyssz12];
                    
                    me = [[THSobject sharedInstance].data.ysy12 floatValue];
                    temp = me - ysyssz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"今年跑%@深证成指", temp > 0.00f ? @"赢" : @"输"];
                    break;
                case 3:// 创业
                    ary = [[THSobject sharedInstance] getData12:THSTypecy];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusycy12];
                    
                    me = [[THSobject sharedInstance].data.ysy12 floatValue];
                    temp = me - ysycy;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"今年跑%@创业板指", temp > 0.00f ? @"赢" : @"输"];
                   break;
                default:
                    break;
            }
            cell.bottomnumber.text = [NSString stringWithFormat:@"%.2f%%", temp];
            cell.bottomnumber.textColor =  temp > 0.00f ? _red : _blue;
            break;
        case 5://两年
            arysz = [[THSobject sharedInstance] getData6:THSTypesz];
            aryssz = [[THSobject sharedInstance] getData6:THSTypessz];
            arycy = [[THSobject sharedInstance] getData6:THSTypecy];
            for (int i =0; i<arysz.count; i++) {
                ysysz += arysz[i].y;
            }
            for (int i =0; i<aryssz.count; i++) {
                ysyssz += aryssz[i].y;
            }
            for (int i =0; i<arycy.count; i++) {
                ysycy += arycy[i].y;
            }
            
            tempint = [[THSobject sharedInstance].month intValue] - 12;
            tempint = tempint <= 0 ? 12 + tempint : tempint;
            tempyear = [[THSobject sharedInstance].year intValue] - 2;
            _navnumber.text = [NSString stringWithFormat:@"%zd-%02zd-01~%@-%@-%@", tempyear, tempint, [THSobject sharedInstance].year, [THSobject sharedInstance].mmonth, [THSobject sharedInstance].dday];
            _headtitle.text = @"近两年盈亏";
            _headnumber.text = [NSString stringWithFormat:@"%.2f", [[THSobject sharedInstance].data.yyk24 floatValue]];
            _headpercent.text = [NSString stringWithFormat:@"收益率:%.2f%%", [[THSobject sharedInstance].data.ysy24 floatValue]];
            
            //ysysz = [[THSobject sharedInstance].data.ysysz24 floatValue];
            //ysyssz = [[THSobject sharedInstance].data.ysyssz24 floatValue];
            //ysycy = [[THSobject sharedInstance].data.ysycy24 floatValue];
            switch (_dindex) {
                case 1:// 上证
                    ary = [[THSobject sharedInstance] getData6:THSTypesz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusysz24];
                    
                    me = [[THSobject sharedInstance].data.ysy24 floatValue];
                    temp = me - ysysz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近两年跑%@上证指数", temp > 0.00f ? @"赢" : @"输"];
                    break;
                case 2:// 深证
                    ary = [[THSobject sharedInstance] getData6:THSTypessz];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusyssz24];
                    
                    me = [[THSobject sharedInstance].data.ysy24 floatValue];
                    temp = me - ysyssz;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近两年跑%@深证成指", temp > 0.00f ? @"赢" : @"输"];
                    break;
                case 3:// 创业
                    ary = [[THSobject sharedInstance] getData6:THSTypecy];
                    //cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusycy24];
                    
                    me = [[THSobject sharedInstance].data.ysy24 floatValue];
                    temp = me - ysycy;
                    cell.bottomtitle.text = [NSString stringWithFormat:@"近两年跑%@创业板指", temp > 0.00f ? @"赢" : @"输"];
                    
                    break;
                default:
                    break;
            }
            cell.bottomnumber.text = [NSString stringWithFormat:@"%.2f%%", temp];
            cell.bottomnumber.textColor =  temp > 0.00f ? _red : _blue;
            break;
        default:
            break;
    }
    
    // 折线数据
    double maxlimit = 2;
    double minlimit = -2, ylimint = -2;
    double granularity = 2;
    cell.zhexianImage.image = [[THSobject sharedInstance] fileimage:THSStatusNone];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    double y = 0;
    for (int i =0; i<ary.count; i++) {
        THSzhexian *t = ary[i];
        y += t.y;
        maxlimit = maxlimit < y ? y : maxlimit;
        minlimit = minlimit > y ? y : minlimit;

        [values addObject:[[ChartDataEntry alloc] initWithX:t.date y:y icon:[UIImage imageNamed:@"icon"]]];
    }
    if (maxlimit > 60) {
        granularity = 30;
        maxlimit = 100;
        ylimint = -20;
    }
    else if (maxlimit > 40) {
        granularity = 20;
        maxlimit = 60;
        ylimint = -20;
    }
    else if (maxlimit > 30) {
        granularity = 10;
        maxlimit = 40;
        ylimint = -10;
    }
    else if (maxlimit > 20) {
        granularity = 10;
        maxlimit = 30;
        ylimint = -10;
    }
    else if (maxlimit > 15) {
        granularity = 5;
        maxlimit = 20;
        ylimint = -5;
        ylimint = minlimit < -3 ? -10 : -5;
    }
    else if (maxlimit > 10) {
        granularity = 5;
        maxlimit = 15;
        ylimint = -5;
        ylimint = minlimit < -3.5 ? -10 : -5;
    } else if (maxlimit > 7) {
        granularity = 2.5;
        maxlimit = 10;
        ylimint = -2.5;
    } else {
        granularity = 2;
        maxlimit = 6;
        ylimint = -2;
    }
    if (minlimit < ylimint) {
        if (minlimit < -10) {
            ylimint = -20;
        } else if (minlimit < -7) {
            granularity = 2.5;
            maxlimit = 2.5;
            ylimint = -10;
        } else {
            granularity = 2;
            maxlimit = 2;
            ylimint = -6;
        }
    }
    cell.chartView.rightAxis.granularity = granularity;//间隔
    cell.chartView.rightAxis.labelCount = 7;
    
    NSTimeInterval hourSeconds = 3600.0 * 24;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSInteger mon = [[THSobject sharedInstance].month integerValue] + 1;
    NSInteger yr = [[THSobject sharedInstance].year integerValue];
    yr = mon > 12 ? yr + 1 : yr;
    mon = mon > 12 ? mon - 12 : mon;
    NSDate *de = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%02zd-01", yr, mon]];
    NSTimeInterval last = [de timeIntervalSince1970] - hourSeconds;

    // 下线
    NSMutableArray *values2 = [[NSMutableArray alloc] init];
    [values2 addObject:[[ChartDataEntry alloc] initWithX:ary[0].date y:ylimint icon:nil]];
    [values2 addObject:[[ChartDataEntry alloc] initWithX:last y:ylimint icon:nil]];
    
    // 上线
    NSMutableArray *values3 = [[NSMutableArray alloc] init];
    [values3 addObject:[[ChartDataEntry alloc] initWithX:ary[0].date y:maxlimit icon:nil]];
    [values3 addObject:[[ChartDataEntry alloc] initWithX:last y:maxlimit icon:nil]];
    
    LineChartDataSet *zhexianV = [[LineChartDataSet alloc] initWithEntries:values label:@""];
    
    [zhexianV setColor:[UIColor colorWithRed:83/255.0 green:137/255.0 blue:231/255.0 alpha:1.0]];
    zhexianV.lineWidth = 1.5;
    zhexianV.formSize = 0.0;
    zhexianV.drawFilledEnabled = NO;
    zhexianV.drawValuesEnabled = NO;
    zhexianV.drawCirclesEnabled = NO;
    zhexianV.drawIconsEnabled = NO;
    zhexianV.drawHorizontalHighlightIndicatorEnabled = NO;
    
    LineChartDataSet *minV = [[LineChartDataSet alloc] initWithEntries:values2 label:@""];
    [minV setColor:[UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1.0]];
    minV.lineWidth = 1.0;
    minV.formSize = 0.0;
    minV.drawFilledEnabled = NO;
    minV.drawValuesEnabled = NO;
    minV.drawCirclesEnabled = NO;
    minV.drawIconsEnabled = NO;
    [minV setDrawHighlightIndicators:NO];
    minV.highlightEnabled = NO;
    
    LineChartDataSet *maxV = [[LineChartDataSet alloc] initWithEntries:values3 label:@""];
    [maxV setColor:UIColor.clearColor];
    maxV.lineWidth = 0.0;
    maxV.formSize = 0.0;
    maxV.drawFilledEnabled = NO;
    maxV.drawValuesEnabled = NO;
    maxV.drawCirclesEnabled = NO;
    maxV.drawIconsEnabled = NO;
    [maxV setDrawHighlightIndicators:NO];
    maxV.highlightEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:zhexianV];
    [dataSets addObject:minV];
    [dataSets addObject:maxV];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    
    //cell.chartView.rightAxis.granularity = granularity;//间隔
    cell.chartView.xAxis.entries = [THSobject sharedInstance].indexAry;
    cell.chartView.data = data;
    
    [cell.chartView animateWithXAxisDuration:ary.count < 20 ? 1.0 : 1.5];
    
    // 柱状指示
    cell.me.text = [NSString stringWithFormat:@"%.2f%%", me];
    cell.me.textColor = me > 0 ? _red : _blue;
    cell.szsy.text = [NSString stringWithFormat:@"%.2f%%", ysysz];
    cell.szsy.textColor = ysysz > 0 ? _red : _blue;
    cell.sszsy.text = [NSString stringWithFormat:@"%.2f%%", ysyssz];
    cell.sszsy.textColor = ysyssz > 0 ? _red : _blue;
    cell.cysy.text = [NSString stringWithFormat:@"%.2f%%", ysycy];
    cell.cysy.textColor = ysycy > 0 ? _red : _blue;
    
    me = fabs(me);
    ysysz = fabs(ysysz);
    ysyssz = fabs(ysyssz);
    ysycy = fabs(ysycy);
    max = ysysz > ysyssz ? ysysz : ysyssz;
    max = max > ysycy ? max : ysycy;
    max = max > me ? max : me;
    int x = (int)max;
    if (x < 5) {
        limit = x + 0.5;
    } else if (x < 10) {
        limit = x + 2;
    } else if (x < 20) {
        limit = x + 4;
    } else if (x < 30) {
        limit = x + 6;
    } else if (x < 40) {
        limit = x + 8;
    } else if (x < 50) {
        limit = x + 10;
    } else {
        limit = x + 20;
    }
    
    cell.mebackview1.frame = CGRectMake(0, 0, cell.mebackview.frame.size.width * me/limit, cell.mebackview.frame.size.height) ;
    cell.szbackview1.backgroundColor = cell.me.textColor;
    cell.szbackview1.frame = CGRectMake(0, 0, cell.szbackview.frame.size.width * ysysz/limit, cell.szbackview.frame.size.height) ;
    cell.szbackview1.backgroundColor = cell.szsy.textColor;
    cell.sszbackview1.frame = CGRectMake(0, 0, cell.sszbackview.frame.size.width * ysyssz/limit, cell.sszbackview.frame.size.height) ;
    cell.sszbackview1.backgroundColor = cell.sszsy.textColor;
    cell.cybackview1.frame = CGRectMake(0, 0, cell.cybackview.frame.size.width * ysycy/limit, cell.cybackview.frame.size.height) ;
    cell.cybackview1.backgroundColor = cell.cysy.textColor;
}

- (IBAction)popBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// 上证 深证 创业
- (void)dBtnAction:(NSInteger)index
{
    _dindex = index;
    [self showdata];
}

// 本月 三月 半年 今年 两年
- (void)detailBtnAction:(NSInteger)index
{
    _detailindex = index;
    [self showdata];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    _vc = (DetailVC *)segue.destinationViewController;
    _vc.vcdelegate = self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 42) {
        _navtitle1.hidden = TRUE;
        _navtitle.hidden = FALSE;
        _navnumber.hidden = FALSE;
    } else {
        _navtitle1.hidden = FALSE;
        _navtitle.hidden = TRUE;
        _navnumber.hidden = TRUE;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DetailCell";
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.vcdelegate = self;
    cell.heightLayout.constant = self.view.frame.size.height;
    cell.topLayout.constant = -(40 + 162 + iPX_NAV_HEIGHT(64));
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    return _containerView;
}

@end
