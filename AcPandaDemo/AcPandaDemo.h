//
//  AcPandaDemo.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/21.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface AcPandaDemo : NSObject

@end




/**
 
    1,目前XCode插件主要实现原理:
        1)通知
            监控通知,做必要处理,需要注意rmeove通知
        2)Hook(函数交换)
            参考使用XcodeHeader函数,交换出来做处理
            插件钩子常见使用JRSwizzle来进行函数交换
        3)获取[NSApp keyWindow],从view结构中找到适合的view
    2,插件设置功能
        1)增加一个menu按钮,打开预先编写好的页面
        2)cocoa框架相关,需要编写cocoa方面
        3)[NSUserDefaults standardUserDefaults]可以全局保存(与其他插件共享空间,实际plist位置还没有找到)(注意key值)
 
 

 
    //更新插件(Xcode.app需要替换成当前使用的Xcode,默认为Xcode.app,有多个时请cd /Applications查看)
    find ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins -name Info.plist -maxdepth 3 | xargs -I{} defaults write {} DVTPlugInCompatibilityUUIDs -array-add `defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID`
 
 

 
 */

