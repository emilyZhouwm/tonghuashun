//
//  SettingViewController.m
//  tonghuashun
//
//  Created by 周文敏 on 2019/5/1.
//  Copyright © 2019 周文敏. All rights reserved.
//

#import "SettingViewController.h"
#import "LKDBHelper.h"
#import "DataCenter.h"

@interface SettingViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *zzc;
@property (weak, nonatomic) IBOutlet UITextField *zyk;
@property (weak, nonatomic) IBOutlet UITextField *zsz;
@property (weak, nonatomic) IBOutlet UITextField *dyk;

@property (weak, nonatomic) IBOutlet UITextField *yyk;
@property (weak, nonatomic) IBOutlet UITextField *ysy;
@property (weak, nonatomic) IBOutlet UITextField *ysysz;
@property (weak, nonatomic) IBOutlet UITextField *ysyssz;
@property (weak, nonatomic) IBOutlet UITextField *ysycy;

@property (weak, nonatomic) IBOutlet UITextField *yyk3;
@property (weak, nonatomic) IBOutlet UITextField *ysy3;
@property (weak, nonatomic) IBOutlet UITextField *ysysz3;
@property (weak, nonatomic) IBOutlet UITextField *ysyssz3;
@property (weak, nonatomic) IBOutlet UITextField *ysycy3;

@property (weak, nonatomic) IBOutlet UITextField *yyk6;
@property (weak, nonatomic) IBOutlet UITextField *ysy6;
@property (weak, nonatomic) IBOutlet UITextField *ysysz6;
@property (weak, nonatomic) IBOutlet UITextField *ysyssz6;
@property (weak, nonatomic) IBOutlet UITextField *ysycy6;

@property (weak, nonatomic) IBOutlet UITextField *yyk12;
@property (weak, nonatomic) IBOutlet UITextField *ysy12;
@property (weak, nonatomic) IBOutlet UITextField *ysysz12;
@property (weak, nonatomic) IBOutlet UITextField *ysyssz12;
@property (weak, nonatomic) IBOutlet UITextField *ysycy12;

@property (weak, nonatomic) IBOutlet UITextField *yyk24;
@property (weak, nonatomic) IBOutlet UITextField *ysy24;
@property (weak, nonatomic) IBOutlet UITextField *ysysz24;
@property (weak, nonatomic) IBOutlet UITextField *ysyssz24;
@property (weak, nonatomic) IBOutlet UITextField *ysycy24;

@property (weak, nonatomic) IBOutlet UITextField *yzzr;
@property (weak, nonatomic) IBOutlet UITextField *yzzc;
@property (weak, nonatomic) IBOutlet UITextField *cqzc;
@property (weak, nonatomic) IBOutlet UITextField *jlr;
@property (weak, nonatomic) IBOutlet UITextField *zhyk;
@property (weak, nonatomic) IBOutlet UITextField *qmzc;

@property (weak, nonatomic) IBOutlet UIButton *home;
@property (weak, nonatomic) IBOutlet UIButton *zixuan;
@property (weak, nonatomic) IBOutlet UIButton *trade;

@property (weak, nonatomic) IBOutlet UIButton *ysz;
@property (weak, nonatomic) IBOutlet UIButton *ysz3;
@property (weak, nonatomic) IBOutlet UIButton *ysz6;
@property (weak, nonatomic) IBOutlet UIButton *ysz12;
@property (weak, nonatomic) IBOutlet UIButton *ysz24;

@property (weak, nonatomic) IBOutlet UIButton *yssz;
@property (weak, nonatomic) IBOutlet UIButton *yssz3;
@property (weak, nonatomic) IBOutlet UIButton *yssz6;
@property (weak, nonatomic) IBOutlet UIButton *yssz12;
@property (weak, nonatomic) IBOutlet UIButton *yssz24;

@property (weak, nonatomic) IBOutlet UIButton *ycy;
@property (weak, nonatomic) IBOutlet UIButton *ycy3;
@property (weak, nonatomic) IBOutlet UIButton *ycy6;
@property (weak, nonatomic) IBOutlet UIButton *ycy12;
@property (weak, nonatomic) IBOutlet UIButton *ycy24;

@property (nonatomic, assign) THSStatus status;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"假数据";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    //填充数据
    _zzc.text = [THSobject sharedInstance].data.zzc;
    _zzc.tag = THSStatuszzc;
    _zyk.text = [THSobject sharedInstance].data.zyk;
    _zyk.tag = THSStatuszyk;
    _zsz.text = [THSobject sharedInstance].data.zsz;
    _zsz.tag = THSStatuszsz;
    _dyk.text = [THSobject sharedInstance].data.dyk;
    _dyk.tag = THSStatusdyk;
 
    _yyk.text = [THSobject sharedInstance].data.yyk;
    _ysy.text = [THSobject sharedInstance].data.ysy;
    _ysysz.text = [THSobject sharedInstance].data.ysysz;
    _ysyssz.text = [THSobject sharedInstance].data.ysyssz;
    _ysycy.text = [THSobject sharedInstance].data.ysycy;
    _yyk.tag = THSStatusyyk;
    _ysy.tag = THSStatusysy;
    _ysysz.tag = THSStatusysysz;
    _ysyssz.tag = THSStatusysyssz;
    _ysycy.tag = THSStatusysycy;

    _yyk3.text = [THSobject sharedInstance].data.yyk3;
    _ysy3.text = [THSobject sharedInstance].data.ysy3;
    _ysysz3.text = [THSobject sharedInstance].data.ysysz3;
    _ysyssz3.text = [THSobject sharedInstance].data.ysyssz3;
    _ysycy3.text = [THSobject sharedInstance].data.ysycy3;
    _yyk3.tag = THSStatusyyk3;
    _ysy3.tag = THSStatusysy3;
    _ysysz3.tag = THSStatusysysz3;
    _ysyssz3.tag = THSStatusysyssz3;
    _ysycy3.tag = THSStatusysycy3;

    _yyk6.text = [THSobject sharedInstance].data.yyk6;
    _ysy6.text = [THSobject sharedInstance].data.ysy6;
    _ysysz6.text = [THSobject sharedInstance].data.ysysz6;
    _ysyssz6.text = [THSobject sharedInstance].data.ysyssz6;
    _ysycy6.text = [THSobject sharedInstance].data.ysycy6;
    _yyk6.tag = THSStatusyyk6;
    _ysy6.tag = THSStatusysy6;
    _ysysz6.tag = THSStatusysysz6;
    _ysyssz6.tag = THSStatusysyssz6;
    _ysycy6.tag = THSStatusysycy6;

    _yyk12.text = [THSobject sharedInstance].data.yyk12;
    _ysy12.text = [THSobject sharedInstance].data.ysy12;
    _ysysz12.text = [THSobject sharedInstance].data.ysysz12;
    _ysyssz12.text = [THSobject sharedInstance].data.ysyssz12;
    _ysycy12.text = [THSobject sharedInstance].data.ysycy12;
    _yyk12.tag = THSStatusyyk12;
    _ysy12.tag = THSStatusysy12;
    _ysysz12.tag = THSStatusysysz12;
    _ysyssz12.tag = THSStatusysyssz12;
    _ysycy12.tag = THSStatusysycy12;

    _yyk24.text = [THSobject sharedInstance].data.yyk24;
    _ysy24.text = [THSobject sharedInstance].data.ysy24;
    _ysysz24.text = [THSobject sharedInstance].data.ysysz24;
    _ysyssz24.text = [THSobject sharedInstance].data.ysyssz24;
    _ysycy24.text = [THSobject sharedInstance].data.ysycy24;
    _yyk24.tag = THSStatusyyk24;
    _ysy24.tag = THSStatusysy24;
    _ysysz24.tag = THSStatusysysz24;
    _ysyssz24.tag = THSStatusysyssz24;
    _ysycy24.tag = THSStatusysycy24;

    _yzzr.text = [THSobject sharedInstance].data.yzzr;
    _yzzr.tag = THSStatus_yzzr;
    _yzzc.text = [THSobject sharedInstance].data.yzzc;
    _yzzc.tag = THSStatus_yzzc;
    _cqzc.text = [THSobject sharedInstance].data.cqzc;
    _cqzc.tag = THSStatus_cqzc;
   _jlr.text = [THSobject sharedInstance].data.jlr;
    _jlr.tag = THSStatus_jlr;
    _zhyk.text = [THSobject sharedInstance].data.zhyk;
    _zhyk.tag = THSStatus_zhyk;
    _qmzc.text = [THSobject sharedInstance].data.qmzc;
    _qmzc.tag = THSStatus_qmzc;

    _home.tag = THSStatushome;
    _zixuan.tag = THSStatuszixuan;
    _trade.tag = THSStatustrade;
    
    _ysz.tag = THSStatusysz;
    _ysz3.tag = THSStatusysz3;
    _ysz6.tag = THSStatusysz6;
    _ysz12.tag = THSStatusysz12;
    _ysz24.tag = THSStatusysz24;
    
    _yssz.tag = THSStatusyssz;
    _yssz3.tag = THSStatusyssz3;
    _yssz6.tag = THSStatusyssz6;
    _yssz12.tag = THSStatusyssz12;
    _yssz24.tag = THSStatusyssz24;
    
    _ycy.tag = THSStatusycy;
    _ycy3.tag = THSStatusycy3;
    _ycy6.tag = THSStatusycy6;
    _ycy12.tag = THSStatusycy12;
    _ycy24.tag = THSStatusycy24;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


- (IBAction)popBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)imageBtnAction:(UIButton *)sender {
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    vc.mediaTypes = @[@"public.image"];
    vc.allowsEditing = NO;
    vc.delegate = self;
    _status = sender.tag;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    __weak typeof(self) weakself = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data = UIImagePNGRepresentation(originalImage);
        NSString *filepath = [[THSobject sharedInstance] filepath:weakself.status];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
        }
        [data writeToFile:filepath atomically:YES];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
 
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    THSStatus status = textField.tag;
    switch (status) {
        case THSStatuszzc:
            [THSobject sharedInstance].data.zzc = textField.text;
            break;
        case THSStatuszyk:
            [THSobject sharedInstance].data.zyk = textField.text;
            break;
        case THSStatuszsz:
            [THSobject sharedInstance].data.zsz = textField.text;
            break;
        case THSStatusdyk:
            [THSobject sharedInstance].data.dyk = textField.text;
            break;
            
        case THSStatusyyk:
            [THSobject sharedInstance].data.yyk = textField.text;
            break;
        case THSStatusysy:
            [THSobject sharedInstance].data.ysy = textField.text;
            break;
        case THSStatusysysz:
            [THSobject sharedInstance].data.ysysz = textField.text;
            break;
        case THSStatusysyssz:
            [THSobject sharedInstance].data.ysyssz = textField.text;
            break;
        case THSStatusysycy:
            [THSobject sharedInstance].data.ysycy = textField.text;
            break;
            
            
        case THSStatusyyk3:
            [THSobject sharedInstance].data.yyk3 = textField.text;
            break;
        case THSStatusysy3:
            [THSobject sharedInstance].data.ysy3 = textField.text;
            break;
        case THSStatusysysz3:
            [THSobject sharedInstance].data.ysysz3 = textField.text;
            break;
        case THSStatusysyssz3:
            [THSobject sharedInstance].data.ysyssz3 = textField.text;
            break;
        case THSStatusysycy3:
            [THSobject sharedInstance].data.ysycy3 = textField.text;
            break;
            
        case THSStatusyyk6:
            [THSobject sharedInstance].data.yyk6 = textField.text;
            break;
        case THSStatusysy6:
            [THSobject sharedInstance].data.ysy6 = textField.text;
            break;
        case THSStatusysysz6:
            [THSobject sharedInstance].data.ysysz6 = textField.text;
            break;
        case THSStatusysyssz6:
            [THSobject sharedInstance].data.ysyssz6 = textField.text;
            break;
        case THSStatusysycy6:
            [THSobject sharedInstance].data.ysycy6 = textField.text;
            break;
            
        case THSStatusyyk12:
            [THSobject sharedInstance].data.yyk12 = textField.text;
            break;
        case THSStatusysy12:
            [THSobject sharedInstance].data.ysy12 = textField.text;
            break;
        case THSStatusysysz12:
            [THSobject sharedInstance].data.ysysz12 = textField.text;
            break;
        case THSStatusysyssz12:
            [THSobject sharedInstance].data.ysyssz12 = textField.text;
            break;
        case THSStatusysycy12:
            [THSobject sharedInstance].data.ysycy12 = textField.text;
            break;
            
        case THSStatusyyk24:
            [THSobject sharedInstance].data.yyk24 = textField.text;
            break;
        case THSStatusysy24:
            [THSobject sharedInstance].data.ysy24 = textField.text;
            break;
        case THSStatusysysz24:
            [THSobject sharedInstance].data.ysysz24 = textField.text;
            break;
        case THSStatusysyssz24:
            [THSobject sharedInstance].data.ysyssz24 = textField.text;
            break;
        case THSStatusysycy24:
            [THSobject sharedInstance].data.ysycy24 = textField.text;
            break;
            
        case THSStatus_yzzr:
            [THSobject sharedInstance].data.yzzr = textField.text;
            break;
        case THSStatus_yzzc:
            [THSobject sharedInstance].data.yzzc = textField.text;
            break;
        case THSStatus_cqzc:
            [THSobject sharedInstance].data.cqzc = textField.text;
            break;
        case THSStatus_jlr:
            [THSobject sharedInstance].data.jlr = textField.text;
            break;
        case THSStatus_zhyk:
            [THSobject sharedInstance].data.zhyk = textField.text;
            break;
        case THSStatus_qmzc:
            [THSobject sharedInstance].data.qmzc = textField.text;
            break;
        default:
            break;
    }
    [[THSobject sharedInstance].data updateToDB];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

@end
