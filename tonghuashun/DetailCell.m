//
//  DetailCell.m
//  tonghuashun
//
//  Created by 周文敏 on 2019/5/2.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import "DetailCell.h"
#import "SettingViewController.h"
#import "DateValueFormatter.h"
#import "IntAxisValueFormatter.h"
#import "tonghuashun-Swift.h"

@implementation DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _szbackview.layer.masksToBounds = TRUE;
    _mebackview.layer.cornerRadius = _mebackview.frame.size.height / 2;
    _mebackview1.layer.cornerRadius = _mebackview1.frame.size.height / 2;
    _szbackview.layer.cornerRadius = _szbackview.frame.size.height / 2;
    _sszbackview.layer.cornerRadius = _szbackview.frame.size.height / 2;
    _cybackview.layer.cornerRadius = _szbackview.frame.size.height / 2;
    _szbackview1.layer.cornerRadius = _szbackview.frame.size.height / 2;
    _sszbackview1.layer.cornerRadius = _szbackview.frame.size.height / 2;
    _cybackview1.layer.cornerRadius = _szbackview.frame.size.height / 2;
    
    
    //_chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = NO;
    [_chartView setScaleEnabled:NO];
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    
    //xxxxx
    _chartView.xAxis.enabled = YES;
    _chartView.xAxis.drawGridLinesEnabled = NO;
    _chartView.xAxis.drawAxisLineEnabled = NO;
    _chartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    _chartView.xAxisRenderer = [[ChartXAxisDateRenderer alloc] initWithViewPortHandler:_chartView.viewPortHandler xAxis:_chartView.xAxis transformer:[_chartView getTransformerForAxis:AxisDependencyLeft]];
    _chartView.xAxis.yOffset = -15;
    //_chartView.xAxis.xOffset = 15;
    
    _chartView.xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    _chartView.xAxis.labelTextColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
    _chartView.xAxis.valueFormatter = [[DateValueFormatter alloc] init];
    
    //yyyyy
    _chartView.leftAxis.enabled = NO;
    
    _chartView.rightAxis.enabled = YES;
    _chartView.rightAxis.labelPosition = YAxisLabelPositionInsideChart;
    _chartView.rightAxis.labelAlignment = NSTextAlignmentRight;
    _chartView.rightAxis.labelTextColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
    _chartView.rightAxis.yOffset = -5;
    _chartView.rightAxis.xOffset = 0;
    
    _chartView.rightAxis.drawAxisLineEnabled = NO;
    _chartView.rightAxis.gridLineDashLengths = @[@2.0, @1.0];
    _chartView.rightAxis.gridColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    _chartView.rightAxis.gridLineDashPhase = 0.f;
    _chartView.rightAxis.granularity = 5;//间隔
    _chartView.rightAxis.valueFormatter = [[IntAxisValueFormatter alloc] init];
 
    _chartView.legend.form = ChartLegendFormLine;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)d1BtnAction:(UIButton *)sender {
    [_bottomImage setImage:[UIImage imageNamed:@"d11"]];
    if (_vcdelegate) {
        [_vcdelegate dBtnAction:sender.tag - 1000];
    }
}

- (IBAction)d2BtnAction:(UIButton *)sender {
    [_bottomImage setImage:[UIImage imageNamed:@"d12"]];
    if (_vcdelegate) {
        [_vcdelegate dBtnAction:sender.tag - 1000];
    }
}

- (IBAction)d3BtnAction:(UIButton *)sender {
    [_bottomImage setImage:[UIImage imageNamed:@"d13"]];
    if (_vcdelegate) {
        [_vcdelegate dBtnAction:sender.tag - 1000];
    }
}

@end
