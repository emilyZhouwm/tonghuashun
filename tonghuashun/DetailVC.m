//
//  DetailVC.m
//  tonghuashun
//
//  Created by 周文敏 on 2019/5/3.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import "DetailVC.h"
#import "SettingViewController.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)detailBtnAction:(UIButton *)sender {
    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long)(sender.tag - 1000)]]];
    if (_vcdelegate) {
        [_vcdelegate detailBtnAction:sender.tag - 1000];
    }
}

@end
