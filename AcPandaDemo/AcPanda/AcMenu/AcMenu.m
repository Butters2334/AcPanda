//
//  AcMenu.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/22.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "AcMenu.h"
#import <Cocoa/Cocoa.h>

@implementation AcMenu
+(NSArray<NSMenuItem*>*)allRootMenuItems
{
    NSMenu *appMenu = [NSApp mainMenu];
    return [appMenu itemArray];
}

+(NSMenuItem *)rootMenuWithTitle:(NSString *)titile
{
    return [[NSApp mainMenu]itemWithTitle:titile?titile:@""];
}
/**
 *  重置rootMenu按钮文字(测试功能,看看能不能修改)
 */
+(void)resetRootMenuItemTitle
{
//    //1,为了避免插件之间冲突(部分插件使用title获取menu),修改title的操作稍微增加延时
//    //2,在实际运行过程中,并没有发现会冲突,可能有其他潜在原因,但还是保留延时
//    //3,为了避免全部menu改成中文之后太low,这里只修改一个edit
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//       [NSThread sleepForTimeInterval:1];
//       dispatch_async(dispatch_get_main_queue(), ^{
//           NSMenuItem *item = [self rootMenuWithTitle:@"Edit"];
////           item.title =
//           [item submenu].title=@"编辑";
//           NSLog(@"%@",item);
//       });
//    });
}
@end
