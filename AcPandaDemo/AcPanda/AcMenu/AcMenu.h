//
//  AcMenu.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/22.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSMenuItem;

@interface AcMenu : NSObject

/**
 *  获取XCode第一层menu按钮实体
 *
 *  @return (<NSMenuItem>)@[Xcode,File,Edit,View,Find,Navigate,Editor,Product,Debug,source Control,Window,Help]
 */
+(NSArray<NSMenuItem*>*)allRootMenuItems;

+(NSMenuItem *)rootMenuWithTitle:(NSString *)titile;

/**
 *  重置rootMenu按钮文字
 */
+(void)resetRootMenuItemTitle;
@end



/**
 *  XcodeMenu添加按钮流程:
 *      1,获取到想添加的位置,比如'Edit',
 *              1)获取第一级别数组,根据下标获取(不稳定,因为其他插件可以在中间添加menu,会导致顺序错误)
 *              2)使用title获取(理论上固定)
 *      2,找到想添加按钮的位置(下标可通过计算其他按钮的位置,或直接添加到最底下)
 *
 *
 *
 *
 *
 *
 *
 */

