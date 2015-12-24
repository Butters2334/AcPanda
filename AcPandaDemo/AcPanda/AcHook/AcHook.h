//
//  AcHook.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/21.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AcHook : NSObject
+(void)loadHook;
@end


/**
 *      Hook,钩子,使用的runtime函数交互作为核心,最好能理解函数交互的利弊
 *
 *
 *      找到了一批xcodehead文件,应该是通过class-dump-x扫出来的
 *
 *      需要对应framework文件才能使用(framework文件中没有头文件)
 *
 *
 *
 *
 *
 *
 *
 *
 */
