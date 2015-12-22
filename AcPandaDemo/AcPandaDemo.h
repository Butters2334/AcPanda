//
//  AcPandaDemo.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/21.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface AcPandaDemo : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end




/**
 
    1,目前XCode插件主要实现原理:
        1)通知
            监控通知,做必要处理,需要注意rmeove通知
        2)Hook(函数交换)
            参考使用XCodeHeader函数,交换出来做处理
 
 
 
 
 
 
 
 
 
 */

