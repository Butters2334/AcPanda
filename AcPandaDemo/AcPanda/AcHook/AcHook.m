//
//  AcHook.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/21.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "AcHook.h"
#import "DVTTextCompletionSession+hook.h"
@implementation AcHook
+(void)loadHook
{
    [DVTTextCompletionSession hook_swizzleMethods];
}
@end