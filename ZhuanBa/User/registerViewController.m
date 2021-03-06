//
//  ViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/22.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "registerViewController.h"
#import "taskbaseVC.h"

@interface registerViewController ()
@property (nonatomic,strong) UITextField * phoneField;
@property (nonatomic,strong) UITextField * pwdField;
@property (nonatomic,strong) UITextField * aginField;
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

-(void)initUI{
    
    self.title = @"注册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 80, 30)];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = @"手机号码";
    
    UILabel * label_pwd = [[UILabel alloc] initWithFrame:CGRectMake(20,200 , 80, 30)];
    label_pwd.font = [UIFont systemFontOfSize:14.0];
    label_pwd.text = @"密码";
    
    UILabel * label_again = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 80, 30)];
    label_again.font = [UIFont systemFontOfSize:14.0];
    label_again.text = @"确认密码";
    
    UITextField * phoneField = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 30)];
    phoneField.font = [UIFont systemFontOfSize:12.0];
    UITextField * pwdField   = [[UITextField alloc] initWithFrame:CGRectMake(100,200 , 200, 30)];
    pwdField.font   = [UIFont systemFontOfSize:12.0];
    pwdField.secureTextEntry = YES;
    UITextField * againField = [[UITextField alloc] initWithFrame:CGRectMake(100, 250, 200, 30)];
    againField.font = [UIFont systemFontOfSize:12.0];
    againField.secureTextEntry = YES;
    
    self.phoneField = phoneField;
    self.pwdField  = pwdField;
    self.aginField = againField;
    
    self.phoneField.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdField.borderStyle = UITextBorderStyleRoundedRect;
    self.aginField.borderStyle = UITextBorderStyleRoundedRect;
    
    UILabel * desLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 220, 20)];
    desLabel.font = [UIFont systemFontOfSize:10.0];
    desLabel.text = @"注册即表示同意用户协议";
    
    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 390, self.view.frame.size.width - 40, 40)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setBackgroundColor:[UIColor orangeColor]];
    [registerButton addTarget:self action:@selector(registerMethod) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius = 4.0;
    
    
    
    [self.view addSubview:label];
    [self.view addSubview:label_pwd];
    [self.view addSubview:label_again];
    [self.view addSubview:phoneField];
    [self.view addSubview:pwdField];
    [self.view addSubview:againField];
    [self.view addSubview:desLabel];
    [self.view addSubview:registerButton];
}
-(void)registerMethod{
    
    
    
    if (self.pwdField.text.length < 6 || self.aginField.text.length < 6) {
        
        [self showtitle:@"密码长度小于6位 !"];
        
        
    }else{
        
        if (![self.pwdField.text isEqualToString:self.aginField.text]) {
            
            [self showtitle:@"两次密码长度不一样 !"];
            
        }else{
            
            [self registerUser];
            
        }
        
    }
    
}
-(void)registerUser{
    
        Network * nt = [[Network alloc] init];
    
        [nt registeraccount:self.phoneField.text password:self.pwdField.text success:^(NSDictionary * dict){
        
            NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
            NSString * reason = [NSString stringWithFormat:@"%@",dict[@"data"][@"reason"]];
            
            if ([code isEqualToString:@"200"]) {
                
                [self showtitle:@"注册成功"];
                
            }else{
                
                [self showtitle:reason];
            }
            
              } fail:^(NSError * error){
        
        
        
            }];
    
}
-(void)showtitle:(NSString *)title{
    
    UIAlertController * control = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
    }];
    
    [control addAction:action];
    
    
    [self presentViewController:control animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
