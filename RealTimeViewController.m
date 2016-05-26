//
//  RealTimeViewController.m
//  test2
//
//  Created by 冯子强 on 16/5/16.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "RealTimeViewController.h"
#import "SocketConnect.h"
static NSString *cellIdentifier = @"RealtimeCell";//as a key to update source
static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";//as a key to update source
@interface RealTimeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    SocketConnect *ss;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;
@property NSArray *listArry;
@property (copy, nonatomic) NSString *tmp;
@end

@implementation RealTimeViewController

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.keys count];
}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *key = self.keys[section];
    NSArray *nameSection = self.names[key];
    return [nameSection count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
    
    NSString *key = self.keys[indexPath.section];
    NSArray *nameSection = self.names[key];
    cell.textLabel.text = nameSection[indexPath.row];
    if(cell == nil) {
   
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        return cell;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path1= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path1 objectAtIndex:0];
    NSString *plistpath = [filepath stringByAppendingPathComponent:@"test.plist"];
    [fm createFileAtPath:plistpath contents:nil attributes:nil];
    self.listArry  = [ss.msg componentsSeparatedByString:@"|"];
    // NSLog(@"%@",self.listArry);
    //  NSMutableArray  *arr = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];

    NSMutableDictionary *dic = [[NSMutableDictionary  alloc] init];

    [dic setObject:_listArry forKey:@"病房1"];
//    [dic setObject:arr2 forKey:@"病房2"];
//    [dic setObject:arr3 forKey:@"病房3"];
//    [dic setObject:arr4 forKey:@"病房4"];
    [dic writeToFile:plistpath atomically:YES];
    
    self.names = [NSDictionary dictionaryWithContentsOfFile:plistpath];
    self.keys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
    [_tableview reloadData];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return self.mkeys[section];
    return self.keys[section];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    ss = [SocketConnect sharedInstance];
    self.tmp = @"PDARealTimeMsg|1|1|Syringe";
    [ss sendInfo:self.tmp];
       [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionsTableIdentifier];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"alarminfo" ofType:@"plist"];
//    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
//    self.keys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
    // Do any additional setup after loading the view.
    NSLog(@"%@",ss.msg);
   // self.tmp = @"PDAStationsMsg|";
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path1= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path1 objectAtIndex:0];
    NSString *plistpath = [filepath stringByAppendingPathComponent:@"test.plist"];
    [fm createFileAtPath:plistpath contents:nil attributes:nil];
    self.listArry  = [ss.msg componentsSeparatedByString:@"|"];
    // NSLog(@"%@",self.listArry);
    //  NSMutableArray  *arr = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    NSMutableArray *arr3 = [[NSMutableArray alloc] init];
    NSMutableArray *arr4 = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary  alloc] init];
    [arr1 insertObject:_listArry[4] atIndex:0];
    [arr2 insertObject:_listArry[8] atIndex:0];
    [arr3 insertObject:_listArry[12] atIndex:0];
    [arr4 insertObject:_listArry[16] atIndex:0];
    [dic setObject:arr1 forKey:@"病房1"];
    [dic setObject:arr2 forKey:@"病房2"];
    [dic setObject:arr3 forKey:@"病房3"];
    [dic setObject:arr4 forKey:@"病房4"];
    [dic writeToFile:plistpath atomically:YES];
    
    self.names = [NSDictionary dictionaryWithContentsOfFile:plistpath];
    self.keys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
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
