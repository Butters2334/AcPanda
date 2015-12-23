//
//  AcNotification.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/21.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "AcNotification.h"
#import <Cocoa/Cocoa.h>
#import "AcShare.h"

@implementation AcNotification
+(instancetype)share
{
    return [AcShare share].notification;
}
+(void)loadNotification
{
    [[self share]loadNotification];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)loadNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(noti_textDidChange:)
                                                name:NSTextDidChangeNotification
                                              object:nil];
}
-(void)noti_textDidChange:(NSNotification *)notification
{
    if(!notification)
    {
        return;
    }
    //主代码编辑框
    if([notification.object isKindOfClass:NSClassFromString(@"DVTSourceTextView")])
    {
        //可以参考https://github.com/onevcat/VVDocumenter-Xcode对代码编辑框的处理部分,识别函数,类,关键字等功能都有
    
    }
    //调试窗口编辑框(在输入log时也能监控)
    if([notification.object isKindOfClass:NSClassFromString(@"IDEConsoleTextView")])
    {
        
    }
    //NSTextView基本所有输入框都有通知回调,但是没有找到明显标识符,不建议使用通知找其他TextView,推荐使用Hook实现.
}
@end

//      编辑框通知
//      NSTextDidChangeNotification
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
