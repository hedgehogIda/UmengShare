//
//  ViewController.m
//  umengShare
//
//  Created by 腾实信 on 2017/2/9.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "ViewController.h"

#import <UMSocialCore/UMSocialCore.h>
#import "UShareUI/UMSocialUIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//显示分享面板
- (IBAction)share:(id)sender {
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
    
}
-(void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage *image = [UIImage imageNamed:@"first"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"TSX测试" descr:@"分享" thumImage:image];
    //设置网页地址
    shareObject.webpageUrl =@"http://www.techtheme.net";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error {
    
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
            }
    else{
        if (error) {
            if ([[error.userInfo valueForKey:@"message"]isEqualToString:@"Operation is canel"]) {
                result = @"关闭分享界面";
                return;
                
            }
            else{
               result = [NSString stringWithFormat:@"Share fail with error code: %d\n",(int)error.code];
            }
            
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
        // result = [NSString stringWithFormat:@"分享失败"];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哈哈"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    
    [alert show];

    
}


@end
