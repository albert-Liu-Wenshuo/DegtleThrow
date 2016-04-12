//
//  LWSLoginPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSLoginPager.h"
#import "LWSRegisterPager.h"
#import "LWSSQLUser.h"
#import "LWSSuccessAlertView.h"
#import "LWSFailedAlert.h"

@interface LWSLoginPager ()<UITextFieldDelegate>

@property (nonatomic , retain)UILabel *labelLogin;
@property (nonatomic , retain)UITextField *textName;
@property (nonatomic , retain)UITextField *textPassword;
@property (nonatomic , retain)UITextField *textSecurityAnswer;
@property (nonatomic , retain)UIView *alertView;

@property (nonatomic , retain)NSTimer *timer;


@end

@implementation LWSLoginPager

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(removeAlertView) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLoginView];
    // Do any additional setup after loading the view.
}

- (void)createLoginView{
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
//    [cancelBtn setTitle:@"X" forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"comment_cancel@3x"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(touchOnCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
//    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
    
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(frame.size.width - 60, 30);
    frame.size = CGSizeMake(50, 20);
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:frame];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(clickOnRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    /**设置登陆界面 */
    frame.origin = CGPointMake(40, 100);
    frame.size = CGSizeMake(self.view.frame.size.width - 80, 45);
    self.textName = [[UITextField alloc]initWithFrame:frame];
    [self.view addSubview:self.textName];
    self.textName.placeholder = @"用户名";
    self.textName.backgroundColor = [UIColor grayColor];
    self.textName.layer.cornerRadius = 5.0;
    self.textName.delegate = self;
    
    frame.origin.y += 20 + frame.size.height;
    self.textPassword = [[UITextField alloc]initWithFrame:frame];
    [self.view addSubview:self.textPassword];
    self.textPassword.placeholder = @"密码";
    self.textPassword.backgroundColor = [UIColor grayColor];
    self.textPassword.layer.cornerRadius = 5.0;
    
    frame.origin.y += 20 + frame.size.height;
    self.textSecurityAnswer = [[UITextField alloc]initWithFrame:frame];
    [self.view addSubview:self.textSecurityAnswer];
    self.textSecurityAnswer.placeholder = @"安全提问（未设置可忽略）";
    self.textSecurityAnswer.backgroundColor = [UIColor grayColor];
    self.textSecurityAnswer.layer.cornerRadius = 5.0;
    
    frame.origin.y += 30 + frame.size.height;
    frame.size.height = 30;
    self.labelLogin = [[UILabel alloc]initWithFrame:frame];
    self.labelLogin.backgroundColor = [UIColor blueColor];
    self.labelLogin.textColor = [UIColor whiteColor];
    self.labelLogin.text = @"登陆";
    self.labelLogin.textAlignment = NSTextAlignmentCenter;
    self.labelLogin.font = [UIFont boldSystemFontOfSize:17.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnLogin)];
    self.labelLogin.userInteractionEnabled = YES;
    [self.labelLogin addGestureRecognizer:tap];
    [self.view addSubview:self.labelLogin];
    self.labelLogin.layer.cornerRadius = 5.0;
    self.labelLogin.layer.masksToBounds = YES;

    UIImage *image = [UIImage imageNamed:@"MineBackGround"];
    CGFloat height = (self.view.frame.size.width / 2.0 / image.size.width) * image.size.height;
    frame.size = CGSizeMake(self.view.frame.size.width / 2.0, height);
    frame.origin = CGPointMake(self.view.frame.size.width / 4.0, self.view.frame.size.height - 150 - height);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [self.view addSubview:imageView];
    imageView.image = image;

}

- (void)touchOnCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)clickOnRegisterBtn:(UIButton *)sender{
    LWSRegisterPager *pager = [[LWSRegisterPager alloc]init];
    [self presentViewController:pager animated:YES completion:^{
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
    textField.textColor = [UIColor blackColor];
}

- (void)tapOnLogin{
    /**在这里写关于登陆的操作 */
    if ([self.textName.text isEqualToString:@""]) {
        self.textName.text = @"请输入用户名";
        self.textName.textColor = [UIColor redColor];
    }
    else{
        NSMutableArray *result = [LWSSQLUser selectUserByName:self.textName.text];
        if (result.count > 0) {
            NSString *password;
            for (LWSUserModel *model in result) {
                 password = model.password;
                if ([password isEqualToString: self.textPassword.text]) {
                    break;
                }
                password = @"";
            }
            if (![password isEqualToString:@""]) {
                /**填写登陆成功的相关操作 */
                /**在系统单例中写入登录状态(包括登录用户的名字) */
                [[NSUserDefaults standardUserDefaults] setValue:self.textName.text forKey:@"userName"];
                LWSSuccessAlertView *view = [[LWSSuccessAlertView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2.0, 100)];
                view.label.text = @"登陆成功";
                self.alertView = view;
                self.alertView.center = self.view.center;
                [self.view addSubview:self.alertView];
                [self createAnimation:self.alertView];
                [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }else{
                /**调用登录失败的方法 */
                [self loginFailed];
            }
        }
        else{
            /**调用登录失败的方法 */
            [self loginFailed];
        }
    }
    
}

/**生成动画的代码 */
- (void)createAnimation:(UIView *)view{
    //!设值layer层的透明度 opacity
    CABasicAnimation *opacity = [CABasicAnimation animation];
    opacity.keyPath = @"opacity";
    opacity.fromValue = @0.1;
    opacity.toValue = @0.7;
    opacity.duration = 2.0;
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fromValue = @0.1;
    scale.toValue = @1;
    scale.duration = 2.0;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    group.animations = @[opacity , scale];
    //为view添加动画
    [view.layer addAnimation:group forKey:@"group"];
    
    //以下两行同时设置才能保持移动后的位置状态不变
    group.fillMode=kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    //移除动画
    [view.layer removeAllAnimations];
}

- (void)removeAlertView{
    [self dismissAnumation:self.alertView];
}

- (void)dismissAnumation:(UIView *)view{
    //!设值layer层的透明度 opacity
    CABasicAnimation *opacity = [CABasicAnimation animation];
    opacity.keyPath = @"opacity";
    opacity.fromValue = @0.7;
    opacity.toValue = @0.1;
    opacity.duration = 2.0;
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fromValue = @1;
    scale.toValue = @0.1;
    scale.duration = 2.0;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    group.animations = @[opacity , scale];
    //为view添加动画
    [view.layer addAnimation:group forKey:@"group"];
    
    //以下两行同时设置才能保持移动后的位置状态不变
    group.fillMode=kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    //移除动画
    [view.layer removeAllAnimations];
    
    //移除视图
    [view removeFromSuperview];
}


- (void)loginFailed{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登陆结果" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"开始注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LWSRegisterPager *pager = [[LWSRegisterPager alloc]init];
        [self presentViewController:pager animated:YES completion:^{
            
        }];
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
