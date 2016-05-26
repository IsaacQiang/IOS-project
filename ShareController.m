//
//  ShareController.m
//  test2
//
//  Created by 冯子强 on 16/3/10.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "ShareController.h"

//ip地址及端口
#define HOST @"192.168.1.100"
#define PORT 1234

//连接超时
#define TIME_OUT 20


//设置读取超时 -1 表示不会使用超时
#define READ_TIME_OUT -1

//设置写入超时 -1 表示不会使用超时
#define WRITE_TIME_OUT -1

//每次最多读取多少
#define MAX_BUFFER 1024

@implementation ShareController

static ShareController *socketServe = nil;

#pragma mark public static methods

+ (ShareController *)shareSocketServe {
    
    @synchronized(self) {
        if (socketServe == nil) {
            socketServe = [[[self class] alloc] init];
        }
    }
    return socketServe;
}


+ (id) allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (socketServe == nil) {
            
            socketServe = [super allocWithZone:zone];
            return socketServe;
        }
    }
    return nil;
}
- (void) startConnectSocket
{

    if (![self SocketOpen:HOST port:PORT]) {
    }
}

- (NSInteger) SocketOpen: (NSString *)addr port: (NSInteger)port
{
    
    if (![self.socket isConnected]) {
        NSError *error = nil;
        [self.socket connectToHost:addr onPort:port error:&error];
    }
    return 0;
}


- (void) cutOffSocket
{
    self.socket.userData = SocketOfflineByUser;
    [self.socket disconnect];
}

- (void)sendMessage:(id)message
{
    //像服务器发送数据
    NSData *cmdData = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:cmdData withTimeout:0 tag:1];
}



#pragma mark - Delegate


//发送消息成功之后回调

@end
