//
//  DVTTextCompletionSession+hook.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/22.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "DVTTextCompletionSession+hook.h"
#import "XcodeHeaders/DVTTextCompletionItem_protocol.h"
#import "JRSwizzle/JRSwizzle.h"

@implementation DVTTextCompletionSession (hook)
+ (void)hook_swizzleMethods
{
    NSError *error;
    [self jr_swizzleMethod: @selector(insertCurrentCompletion)
                withMethod: @selector(hook_insertCurrentCompletion)
                     error: &error];
    if(error)
    {
        NSLog(@"%@",error);
    }
}
/**
 *  通过联想输入,输入完成之后的回调
 */
- (BOOL)hook_insertCurrentCompletion
{
    //获取选中项的下标
    long long index                          = [self selectedCompletionIndex];
    //获取联想列表
    NSArray *filteredList                    = [self filteredCompletionsAlpha];
    //获取选中项
    id<DVTTextCompletionItem> completionItem = [filteredList objectAtIndex:index];
    //关键替换项
    NSString *completionText = [completionItem completionText];
    //
    NSLog(@"%@",completionText);
    //
    return [self hook_insertCurrentCompletion];
}
@end
