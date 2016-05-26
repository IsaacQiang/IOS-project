//
//  patientInfo.m
//  test2
//
//  Created by 冯子强 on 16/3/1.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "patientInfo.h"

static NSString *cellIdentifier = @"patientCell";//as a key to update source
static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";//as a key to update source

@interface patientInfo ()<UITableViewDataSource,UITableViewDelegate>
{
    SocketConnect *ss;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property NSArray *listArry;
@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;
@property (copy, nonatomic) NSString *tmp;
@end

@implementation patientInfo

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
            NSLog(@"nil");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            return cell;
        }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
  //  [self performSegueWithIdentifier:@"INFVIEW" sender:nil];
    switch (indexPath.row) {
        case 0:
            NSLog(@"0");
            self.tmp = @"PDAPatientMsg|1|";
            [ss sendInfo:self.tmp];
            [self performSegueWithIdentifier:@"INFVIEW" sender:nil];
            break;
        case 1:
            NSLog(@"1");
//            self.tmp = @"PDAPatientMsg|2|";
//            [ss sendInfo:self.tmp];}
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
          NSLog(@"3");
            break;
        default:
            break;
    }
    NSLog(@"%@",ss.msg);
    
}
//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"INFVIEW"]) {
//      self.tmp = @"PDAPatientMsg|1|";
//        //NSLog(@"%@",name);
//    }
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return self.mkeys[section];
    return self.keys[section];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionsTableIdentifier];
    
    
    ss = [SocketConnect sharedInstance];
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
   // self.tmp = @"PDAPatientMsg|1|";
    //[ss sendInfo:self.tmp];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Patientinfo" ofType:@"plist"];
//    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
//    self.keys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
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
