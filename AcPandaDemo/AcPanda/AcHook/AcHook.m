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
#import "Aspects.h"
#import "DVTSourceLanguageService.h"
#import <objc/runtime.h>
#import "DVTSourceLanguageService+Hook.h"

@implementation AcHook
+(void)loadHook
{
    //[DVTTextCompletionSession hook_swizzleMethods];
    
    [DVTSourceLanguageService hook];
}

@end



