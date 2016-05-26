//
//  ShareController.h
//  test2
//
//  Created by 冯子强 on 16/3/10.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"


enum{
    SocketOfflineByServer,      //服务器掉线
    SocketOfflineByUser,        //用户断开
    SocketOfflineByWifiCut,     //wifi 断开
};

@interface ShareController : NSObject
@property (nonatomic, strong) AsyncSocket *socket;
@property (nonatomic, retain) NSTimer *heartTimer; //heartbeats
@property NSInteger l ;
@property NSInteger k ;
@property NSString *Msg;
@property NSString *GETMsg;
+ (ShareController *)shareSocketServe;

// socket连接
- (void) startConnectSocket;

// 断开socket连接
- (void) cutOffSocket;

// 发送消息
- (void) sendMessage:(id)message;


@end
