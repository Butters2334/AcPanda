//
//  AcShare.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/23.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "AcShare.h"
#import "AcNotification.h"

@implementation AcShare
+(instancetype)share
{
    static AcShare *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [AcShare new];
    });
    return share;
}
-(AcNotification *)notification
{
    if(!_notification)
    {
        _notification = [AcNotification new];
    }
    return _notification;
}
@end
