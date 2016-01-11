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
    //所有输入框有输入行为
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(noti_textDidChange:)
                                                name:NSTextDidChangeNotification
                                              object:nil];
    //输入框选中行为
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(noti_textDidChange:)
                                                name:NSTextViewDidChangeSelectionNotification
                                              object:nil];
//    //监控所有通知
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(allNotification:)
                                                name:nil
                                              object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(noti_willProcessEditing:)
//                                                name:NSTextStorageDidProcessEditingNotification
//                                              object:nil];
    
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
        NSTextView *textView = (NSTextView *)notification.object;
        NSString *text = textView.textStorage.string;
        //可以参考https://github.com/onevcat/VVDocumenter-Xcode对代码编辑框的处理部分,识别函数,类,关键字等功能都有
        {
        
        }
        //参考https://github.com/omz/ColorSense-for-Xcode,获取当前TextView的选中项
        {
            //所有选中的文本--例:[{3801, 155}],选中位置的range,不是选中行
            NSArray *selectedRanges = [textView selectedRanges];
            //这里可能有歧义,selectedRanges数组装载的是当前选中的代码块,同时选中三行代码时,返回range(代码开始时,三行代码长度),'并不是'返回数组长度为三的range
            //可能会有多选的情况,依所需要的功能来处理,一般取第一个选中代码块就够了(按住command+鼠标 选择多选代码块)
            for(NSValue *selectedValue in selectedRanges)
            {
                //选中的单个range
                NSRange selectRange = [selectedValue rangeValue];
                NSString *selectRangeText = [text substringWithRange:selectRange];
                //选中range转成按行数选择--例:光标放在第一行第二个位置(前后有空格),selectRange={1,0},selectLineRange={0,3},selectRange的length为0是因为当前并没有选中代码,selectLineRange的length为3是第一行的长度
                //还需要注意的是selectLineRange.location并不是行数,只是这一行开始的地方
                NSRange selectLineRange = [text lineRangeForRange:selectRange];
                NSString *selectLineText = [text substringWithRange:selectLineRange];
                
                //NSLog(@"%@-%@",NSStringFromRange(selectRange),NSStringFromRange(selectLineRange));
                //NSLog(@"%@\n|\n|\n%@",selectRangeText,selectLineText);
            }
        }
    }
    //调试窗口编辑框(在输入log时也能监控)
    if([notification.object isKindOfClass:NSClassFromString(@"IDEConsoleTextView")])
    {
        
    }
    //NSTextView基本所有输入框都有通知回调,但是没有找到明显标识符,不建议使用通知找其他TextView,推荐使用Hook实现.
}
-(void)allNotification:(NSNotification *)notification
{
    NSLog(@"%@",notification);
}
-(void)noti_willProcessEditing:(NSNotification *)notification
{
    NSLog(@"%@",notification);
}
@end

//      所有编辑有编辑行为
//      NSTextDidChangeNotification
//      编辑框选中行为(在编辑框中点击或选中,按住command+鼠标可以多选)
//      NSTextViewDidChangeSelectionNotification
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
