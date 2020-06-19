//
//  ViewController.m
//  tonghuashun
//
//  Created by 周文敏 on 2019/5/1.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"
#import "DataCenter.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *tradeView;

@property (weak, nonatomic) IBOutlet UILabel *zzc;
@property (weak, nonatomic) IBOutlet UILabel *zyk;
@property (weak, nonatomic) IBOutlet UILabel *zsz;
@property (weak, nonatomic) IBOutlet UILabel *dyk;

@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *yyk;
@property (weak, nonatomic) IBOutlet UILabel *ysy;

@property (weak, nonatomic) IBOutlet UIImageView *topbar;

@property (nonatomic, strong) UIColor *red;
@property (nonatomic, strong) UIColor *blue;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maskLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _red = [UIColor colorWithRed:213/255.0 green:67/255.0 blue:58/255.0 alpha:1.0];
    _blue = [UIColor colorWithRed:92/255.0 green:143/255.0 blue:231/255.0 alpha:1.0];

    _maskLayout.constant = STATUS_HEIGHT;
    _heightLayout.constant = iPX_BOTTOM_BAR_HEIGHT(50);
    _topLayout.constant = iPX_NAV_HEIGHT(64);
    
    [[THSobject sharedInstance] downloadAll];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _topbar.image = [UIImage imageNamed:@"topbar"];
    [_imageView setImage:[[THSobject sharedInstance] fileimage:THSStatustrade]];
    _tradeView.hidden = NO;
    
    _zzc.text = [THSobject positiveFormat:[THSobject sharedInstance].data.zzc];
    
    float temp = [[THSobject sharedInstance].data.zyk floatValue];
    _zyk.text = [NSString stringWithFormat:@"%@%@", temp > 0.00f ? @"+" : @"-", [THSobject positiveFormat:[THSobject sharedInstance].data.zyk]];
    _zyk.textColor = temp > 0.00f ? _red : _blue;
    
    _zsz.text = [THSobject positiveFormat:[THSobject sharedInstance].data.zsz];
    
    temp = [[THSobject sharedInstance].data.dyk floatValue];
    _dyk.text = [NSString stringWithFormat:@"%@%@", temp > 0.00f ? @"+" : @"-", [THSobject positiveFormat:[THSobject sharedInstance].data.dyk]];
    _dyk.textColor = temp > 0.00f ? _red : _blue;
    
    _month.text = [NSString stringWithFormat:@"%d月参考盈亏", [[THSobject sharedInstance].month intValue]];
    
    temp = [[THSobject sharedInstance].data.yyk floatValue];
    _yyk.text = [THSobject positiveFormat:[THSobject sharedInstance].data.yyk];
    _yyk.textColor = temp > 0.00f ? _red : _blue;
    
    temp = [[THSobject sharedInstance].data.ysy floatValue] - [[THSobject sharedInstance].data.ysysz floatValue];
    _ysy.text = [NSString stringWithFormat:@"收益率%.2f%%，跑%@上证指数%.2f%%", [[THSobject sharedInstance].data.ysy floatValue], temp > 0.00f? @"赢" : @"输", temp];
}

- (IBAction)homeBtnAction:(UIButton *)sender {
    _topbar.image = [UIImage imageNamed:iPX_LATER ? @"topbar1" : @"topbar2"];
    [_imageView setImage:[[THSobject sharedInstance] fileimage:THSStatushome]];
    _tradeView.hidden = YES;
}

- (IBAction)tradeBtnAction:(UIButton *)sender {
    _topbar.image = [UIImage imageNamed:@"topbar"];
    [_imageView setImage:[[THSobject sharedInstance] fileimage:THSStatustrade]];
    _tradeView.hidden = NO;
}

- (IBAction)zixuanBtnAction:(UIButton *)sender {
    _topbar.image = [UIImage imageNamed:@"topbar"];
    [_imageView setImage:[[THSobject sharedInstance] fileimage:THSStatuszixuan]];
    _tradeView.hidden = YES;
}

@end
