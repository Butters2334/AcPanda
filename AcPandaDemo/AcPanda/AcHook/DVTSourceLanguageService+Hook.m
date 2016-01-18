//
//  DVTSourceLanguageService+Hook.m
//  AcPandaDemo
//
//  Created by Anc on 16/1/18.
//  Copyright © 2016年 Ancc. All rights reserved.
//

#import "DVTSourceLanguageService+Hook.h"
#import "JRSwizzle.h"
#import "Aspects.h"
#import "DVTSourceLanguageService.h"
#import <objc/runtime.h>

@implementation DVTSourceLanguageService (Hook)

+ (void)hook
{
    //[self jr_swizzleMethod:@selector(stringByCommentingString:)
                //withMethod:@selector(hook_stringByCommentingString:)
                     //error:nil];
    //已修改完,整合到IndentComments中去了
    //[self jr_swizzleMethod:@selector(stringByTogglingCommentsInLineRange:)
                //withMethod:@selector(hook_stringByTogglingCommentsInLineRange:)
                     //error:nil];
}

/**
 *  多行代码开始注释
 *
 *  @param lineRange 被选中即将进行注释的代码行 格式类似 {34,3}=>第34行,选中3行
 *
 *  @return
 */
-(NSString *)hook_stringByTogglingCommentsInLineRange:(struct _NSRange)lineRange
{
    //直接套用自带函数的返回值进行修改(不去读取textStorage)
    NSString *commentLines      = [self hook_stringByTogglingCommentsInLineRange:lineRange];
    //获取注释代码,正常情况下为 //或 ## (/***/这种类型的注释会导致获取注释代码失败,这种情况下不进行处理)
    NSString *lineCommentPrefix = [self.lineCommentPrefixes firstObject];
    //单行注释直接弹出
    if(lineCommentPrefix.length==0)
    {
        return commentLines;
    }
    //找出需要注释的行(最后一行需要排除)
    NSMutableArray *codeLine  = [NSMutableArray new];
    for(NSString *tempCode in [commentLines componentsSeparatedByString:@"\n"])
    {
        //最后一行是空字符串,进不了if语句
        if([tempCode hasPrefix:lineCommentPrefix])
        {
            [codeLine addObject:[tempCode substringFromIndex:lineCommentPrefix.length]];
        }
    }
    //这里处理一下取消注释的处理,没有需要注释的代码行时,直接弹出
    if(codeLine.count==0)
    {
        return commentLines;
    }
    //标记一个变量,查询最前面的位置(其他代码与这一行对齐)
    NSInteger location = NSNotFound;
    //理论上进入到这个位置了,每一行代码最前面都会是//开始(不使用IndentComments插件)
    for(NSString *commentingString in codeLine)
    {
        NSRange range = [commentingString rangeOfString:@"[^\\s]" options:NSRegularExpressionSearch];
        if(commentingString.length>0)
        {
            location = MIN(location, range.location);
        }
    }
    //容错排除
    if(location == NSNotFound)
    {
        location = 0;
    }
    //重新整合
    NSMutableString *commentCode =[NSMutableString new];
    for(NSString *commentingString in codeLine)
    {
        NSMutableString *mutableString = [commentingString mutableCopy];
        [mutableString insertString:lineCommentPrefix atIndex:location];
        [commentCode appendString:mutableString];
        [commentCode appendString:@"\n"];
    }
    return commentCode;
}

/**
 *  IndentComments项目的核心代码
 *
 *  @Description:监控单行注释行为,在函数被激活时将注释的双斜杠移动到第一个代码字母前面
 *  @tip:   多行注释时调用多次
 *
 *  @git=> https://github.com/poboke/IndentComments
 *
 */
- (NSString *)hook_stringByCommentingString:(NSString *)commentingString
{
    NSString *lineCommentPrefix = [self.lineCommentPrefixes firstObject];
    
    if (lineCommentPrefix.length == 0) {
        
        // Use `/* */` block comment circum
        NSArray *blockCommentCircumfix = [self.blockCommentCircumfixes firstObject];
        lineCommentPrefix = [blockCommentCircumfix firstObject];
        
        NSString *lineCommentSuffix = [blockCommentCircumfix lastObject];
        if (lineCommentSuffix) {
            commentingString = [commentingString stringByAppendingString:lineCommentSuffix];
        }
    }
    
    // Check if the string contains nonwhitespace character
    NSRange range = [commentingString rangeOfString:@"[^\\s]" options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return commentingString;
    }
    
    NSMutableString *mutableString = [commentingString mutableCopy];
    [mutableString insertString:lineCommentPrefix atIndex:range.location];
    return [mutableString copy];
}

@end

