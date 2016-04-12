//
//  LWSRegisterPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSRegisterPager.h"
#import "LWSSQLUser.h"
#import "LWSSuccessAlertView.h"
#import "LWSFailedAlert.h"

@interface LWSRegisterPager ()<UITextFieldDelegate>

@property (nonatomic , retain)UILabel *labelRegister;
@property (nonatomic , retain)UITextField *textName;
@property (nonatomic , retain)UITextField *textPassword;
@property (nonatomic , retain)UITextField *textPassAgain;
@property (nonatomic , retain)UITextField *textEmail;
@property (nonatomic , retain)UIView *alertView;

@property (nonatomic , retain)NSTimer *timer;

@end

@implementation LWSRegisterPager

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(removeAlertView) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRegisterPager];
    // Do any additional setup after loading the view.
}

- (void)createRegisterPager{
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"comment_cancel@3x"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(touchOnCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(40, 100);
    frame.size = CGSizeMake(self.view.frame.size.width - 80, 45);
    
    /**设置注册界面 */
    self.textName = [[UITextField alloc]initWithFrame:frame];
    [self.view addSubview:self.textName];
    self.textName.placeholder = @"用户名";
    self.textName.backgroundColor = [UIColor grayColor];
    self.textName.layer.cornerRadius = 5.0;
    
    frame.origin.y += 20 + frame.size.height;
    self.textPassword = [[UITextField alloc]initWithFrame:frame];
    [self.view addSubview:self.textPassword];
    self.textPassword.placeholder = @"密码";
    self.textPassword.backgroundColor = [UIColor grayColor];
    self.textPassword.layer.cornerRadius = 5.0;
    self.textPassword.delegate = self;
    
    frame.origin.y += 20 + frame.size.height;
    self.textPassAgain = [[UITextField alloc]initWithFrame:frame];
    [self.view addSubview:self.textPassAgain];
    self.textPassAgain.placeholder = @"确认密码";
    self.textPassAgain.backgroundColor = [UIColor grayColor];
    self.textPassAgain.layer.cornerRadius = 5.0;
    self.textPassAgain.delegate = self;
    
    frame.origin.y += 20 + frame.size.height;
    self.textEmail = [[UITextField alloc]initWithFrame:frame];
    [self.view addSubview:self.textEmail];
    self.textEmail.placeholder = @"邮箱";
    self.textEmail.backgroundColor = [UIColor grayColor];
    self.textEmail.layer.cornerRadius = 5.0;
    self.textEmail.delegate = self;
    
    frame.origin.y += 30 + frame.size.height;
    frame.size.height = 30;
    self.labelRegister = [[UILabel alloc]initWithFrame:frame];
    self.labelRegister.backgroundColor = [UIColor blueColor];
    self.labelRegister.textColor = [UIColor whiteColor];
    self.labelRegister.text = @"注册";
    self.labelRegister.textAlignment = NSTextAlignmentCenter;
    self.labelRegister.font = [UIFont boldSystemFontOfSize:17.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnRegister)];
    self.labelRegister.userInteractionEnabled = YES;
    self.labelRegister.layer.cornerRadius = 5.0;
    self.labelRegister.layer.masksToBounds = YES;
    [self.labelRegister addGestureRecognizer:tap];
    [self.view addSubview:self.labelRegister];

}

- (void)tapOnRegister{
    if ([self.textName.textColor isEqual:[UIColor redColor]] || [self.textPassAgain.textColor isEqual:[UIColor redColor]] || [self.textPassword.textColor isEqual:[UIColor redColor]]) {
        
    }
    else{
        /**将邮箱等信息记录好回传:(回传到哪里比较好呢？) */
        self.model = [LWSUserModel modelWithName:self.textName.text Password:self.textPassword.text Email:self.textEmail.text];
        if ([LWSSQLUser insertUserWithModel:self.model]) {
            /**添加一个注册成功的视图 ， 并添加计时器 ， 并最后跳转到登陆界面 */
            self.alertView = [[LWSSuccessAlertView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2.0, 100)];
        }
        else{
            self.alertView = [[LWSFailedAlert alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2.0, 100)];
        }
        self.alertView.center = self.view.center;
        [self.view addSubview:self.alertView];
        [self createAnimation:self.alertView];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
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
    
    if ([self.alertView isKindOfClass:[LWSSuccessAlertView class]]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textEmail resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textEmail resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textPassword.text == nil || [self.textPassword.text isEqualToString:@""]) {
        self.textPassword.text = @"密码不能为空！！！";
        self.textPassword.textColor = [UIColor redColor];
    }
    else if (self.textPassword.text.length < 6){
        self.textPassword.text = @"设置的密码不能少于六位！！！";
        self.textPassword.textColor = [UIColor redColor];
    }
    else if (![self.textPassword.text isEqualToString:self.textPassAgain.text] && ![self.textPassAgain.text isEqualToString:@""]){
        self.textPassword.text = @"两次输入的密码不相同请重新输入";
        self.textPassAgain.text = @"";
        self.textPassword.textColor = [UIColor redColor];
    }
    else if (self.textName.text == nil || [self.textName.text isEqualToString:@""]){
        self.textName.text = @"用户名不能为空";
        self.textName.textColor = [UIColor redColor];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
    textField.textColor = [UIColor blackColor];
}

- (void)touchOnCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
