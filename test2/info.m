//
//  info.m
//  test2
//
//  Created by 冯子强 on 16/2/23.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "info.h"
#import "PatientTableViewCell.h"
#import "SocketConnect.h"

static NSString *cellIdentifier = @"patientCell";//as a key to update source
static NSString *cellIdentifier2 = @"medicinesCell";
static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";//as a key to update source


@interface info ()<UITableViewDataSource,UITableViewDelegate>


{
    SocketConnect *ss;
}
@property (weak, nonatomic) IBOutlet UITableView *patienttable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentvalue;

@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;

@property (copy, nonatomic) NSDictionary *mnames;
@property (copy, nonatomic) NSArray *mkeys;
@property (copy, nonatomic) NSString *tmp;


- (IBAction)segment:(id)sender;

@property NSArray *listArry;
@property NSArray *listArry2;

@end

@implementation info

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmentvalue.selectedSegmentIndex == 0) {
        return [self.keys count];
    }
    else {
        return [self.mkeys count];
    }
}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (self.segmentvalue.selectedSegmentIndex == 0) {
        NSString *key = self.keys[section];
        NSArray *nameSection = self.names[key];
        return [nameSection count];
       // return self.listArry2.count;
    }
    else{
        
        NSString *mkey = self.mkeys[section];
        NSArray *mnameSection = self.mnames[mkey];
        return [mnameSection count];
        
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"%@",ss.msg);
    if(self.segmentvalue.selectedSegmentIndex == 0){

    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path1= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path1 objectAtIndex:0];
    NSString *plistpath = [filepath stringByAppendingPathComponent:@"test2.plist"];
    [fm createFileAtPath:plistpath contents:nil attributes:nil];
    self.listArry  = [ss.msg componentsSeparatedByString:@"|"];
    // NSLog(@"%@",self.listArry);
    //  NSMutableArray  *arr = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
//    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
//    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
//    NSMutableArray *arr3 = [[NSMutableArray alloc] init];
//    NSMutableArray *arr4 = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary  alloc] init];
//    [arr1 insertObject:_listArry[4] atIndex:0];
//    [arr2 insertObject:_listArry[8] atIndex:0];
//    [arr3 insertObject:_listArry[12] atIndex:0];
//    [arr4 insertObject:_listArry[16] atIndex:0];
    [dic setObject:_listArry forKey:@"病房1"];
//    [dic setObject:arr2 forKey:@"病房2"];
//    [dic setObject:arr3 forKey:@"病房3"];
//    [dic setObject:arr4 forKey:@"病房4"];
    [dic writeToFile:plistpath atomically:YES];
    
    
    
    self.mnames = [NSDictionary dictionaryWithContentsOfFile:plistpath];
    self.mkeys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
    }
    else{
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
    
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.segmentvalue.selectedSegmentIndex==0) {
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
        
        NSString *key = self.keys[indexPath.section];
        NSArray *nameSection = self.names[key];
        cell.textLabel.text = nameSection[indexPath.row];
        if(cell == nil) {
            //NSLog(@"nil");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        return cell;
    }
    else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        NSString *mkey = self.mkeys[indexPath.section];
        NSArray *mnameSection = self.mnames[mkey];
        cell.textLabel.text = mnameSection[indexPath.row];
        if(cell == nil) {
            //NSLog(@"nil");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            NSString *mkey = self.mkeys[indexPath.section];
            NSArray *mnameSection = self.mnames[mkey];
            cell.textLabel.text = mnameSection[indexPath.row];
        }
       // cell.textLabel.text = self.listArry2[indexPath.row];
        cell.detailTextLabel.text = nil;
       
        return cell;

    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return self.mkeys[section];
    if (self.segmentvalue.selectedSegmentIndex == 0) {
        return self.keys[section];
    }
    else{
        return self.mkeys[section];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

     ss = [SocketConnect sharedInstance];//创建单例
   
    [self.patienttable registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionsTableIdentifier];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Patientinfo" ofType:@"plist"];
//    
//    
//    
//    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
//    self.keys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
    
//    NSString *mpath = [[NSBundle mainBundle] pathForResource:@"Medicinesinfo" ofType:@"plist"];
//    
//    self.mnames = [NSDictionary dictionaryWithContentsOfFile:mpath];
//    self.mkeys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
  
 
    
    //NSString *mpath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"];
    

   // NSLog(@"%@",dic);
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



- (IBAction)segment:(id)sender {
   // NSLog(@"%@",ss.msg);
     [self.patienttable reloadData];
    switch (self.segmentvalue.selectedSegmentIndex) {
        case 0:
            self.patienttable.hidden = NO;
            [self.patienttable reloadData];
             //NSLog(@"%@",ss.msg);

            self.tmp = @"PDAInfusionMsg|1|";
            [ss sendInfo:self.tmp];
            break;
        case 1:
            self.patienttable.hidden = NO;
            [self.patienttable reloadData];
                        //[ss sendInfo:self.tmp];
            //NSLog(@"%@",ss.msg);
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
            self.tmp = @"PDAStationsMsg|";
            [ss sendInfo:self.tmp];
            
            break;

    }
}

@end
