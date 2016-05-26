//
//  LoginViewController.m
//  test2
//
//  Created by 冯子强 on 16/2/28.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "LoginViewController.h"


#define HOST_PORT 1234
#define HOST_IP @"192.168.11.7"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (copy, nonatomic) NSString *tmp;
- (IBAction)connect:(id)sender;


@property AsyncSocket *asyncSocket;
@property (copy, nonatomic) NSString  *string;
@property NSString *FromMessage;
@property (nonatomic, retain) NSTimer *connectTimer;

@property  NSString *get_back;
@property (copy,nonatomic) NSString *messege;
- (IBAction)login:(id)sender;
- (IBAction)saveinfo:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //remenber userinfo
//    [socketServe.socket readDataWithTimeout:-1 tag:0];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"password"] != nil && [user objectForKey:@"username"] != nil) {
        self.username.text = [user objectForKey:@"username"];
        self.password.text = [user objectForKey:@"password"];
    }
    
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
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}//press background to cancel keyboard
- (IBAction)textFieldCancle:(id)sender {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}//press keyboard "return" to cancel keyboard

- (IBAction)login:(id)sender {
  
    if ([ss.msg isEqualToString:@"PDAUserMsg|OK|医生:冯子强|"] ){
            self.tmp = @"PDAStationsMsg|";
            [ss sendInfo:self.tmp];
            [self performSegueWithIdentifier:@"TOMAIN" sender:nil];
    }
        else{
            UIAlertController *Waring = [UIAlertController alertControllerWithTitle:@"ERROR" message:_messege preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *waring_b = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [Waring addAction:waring_b];
            [self presentViewController:Waring animated:YES completion:nil];
        }

    
  }

- (IBAction)saveinfo:(id)sender {
    NSUserDefaults *account = [NSUserDefaults standardUserDefaults];
    
    [account setObject:self.password.text forKey:@"password"];
    [account setObject:self.username.text forKey:@"username"];
}


- (IBAction)connect:(id)sender {

    ss = [SocketConnect sharedInstance];
    ss.hostPort = 1234;
    ss.hostIpAddress = @"192.168.1.100";
    if([ss loginServer])
        NSLog(@"Success");
}
- (IBAction)send:(id)sender {
    NSArray *tmp = @[@"PDAUserMsg",self.username.text,self.password.text];
    self.string = [tmp componentsJoinedByString:@"|"];
    self.string = [self.string stringByAppendingString:@"|"];
    [ss sendInfo:self.string];
}


//- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

//    
//    NSLog(@"%@",str);
//    [socketServe.socket readDataWithTimeout:-1 tag:0];
//}

@end
