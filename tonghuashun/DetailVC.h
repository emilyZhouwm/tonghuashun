//
//  DetailVC.h
//  tonghuashun
//
//  Created by 周文敏 on 2019/5/3.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DetailVCDelegate <NSObject>
@required
- (void)detailBtnAction:(NSInteger)index;
@end

@interface DetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) id <DetailVCDelegate> vcdelegate;

@end

NS_ASSUME_NONNULL_END
