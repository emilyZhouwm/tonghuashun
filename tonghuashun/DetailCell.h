//
//  DetailCell.h
//  tonghuashun
//
//  Created by 周文敏 on 2019/5/2.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

NS_ASSUME_NONNULL_BEGIN

@protocol DetailCellDelegate <NSObject>
@required
- (void)dBtnAction:(NSInteger)index;
@end

@interface DetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *zhexianImage;
@property (weak, nonatomic) IBOutlet LineChartView *chartView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;

@property (weak, nonatomic) IBOutlet UILabel *bottomtitle;
@property (weak, nonatomic) IBOutlet UILabel *bottomnumber;

@property (weak, nonatomic) IBOutlet UIView *szbackview;
@property (weak, nonatomic) IBOutlet UIView *sszbackview;
@property (weak, nonatomic) IBOutlet UIView *cybackview;
@property (weak, nonatomic) IBOutlet UIView *szbackview1;
@property (weak, nonatomic) IBOutlet UIView *sszbackview1;
@property (weak, nonatomic) IBOutlet UIView *cybackview1;
@property (weak, nonatomic) IBOutlet UIView *mebackview;
@property (weak, nonatomic) IBOutlet UIView *mebackview1;

@property (weak, nonatomic) IBOutlet UILabel *szsy;
@property (weak, nonatomic) IBOutlet UILabel *sszsy;
@property (weak, nonatomic) IBOutlet UILabel *cysy;
@property (weak, nonatomic) IBOutlet UILabel *me;

@property (weak, nonatomic) IBOutlet UILabel *yzzr;
@property (weak, nonatomic) IBOutlet UILabel *yzzc;
@property (weak, nonatomic) IBOutlet UILabel *cqzc;
@property (weak, nonatomic) IBOutlet UILabel *jlr;
@property (weak, nonatomic) IBOutlet UILabel *zhyk;
@property (weak, nonatomic) IBOutlet UILabel *qmzc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;

@property (nonatomic, weak) id <DetailCellDelegate> vcdelegate;

@end

NS_ASSUME_NONNULL_END
