//
//  AcHook.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/21.
//  Copyright © 2015年 Ancc. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import "AcHook.h"
#import "DVTTextCompletionSession+Hook.h"
#import "JRSwizzle.h"
//
//@implementation NSView(Hook)
//+ (void)hook_swizzleMethods
//{
//    NSError *error;
//    [self jr_swizzleMethod: @selector(addSubview:)
//                withMethod: @selector(hook_addSubview:)
//                     error: &error];
//    if(error)
//    {
//        NSLog(@"%@",error);
//    }
//}
//- (void)hook_addSubview:(NSView *)aView
//{
//    [self hook_addSubview:aView];
//}
//
//@end

@implementation AcHook
+(void)loadHook
{
    [DVTTextCompletionSession hook_swizzleMethods];
//    [NSView hook_swizzleMethods];
}

@end



