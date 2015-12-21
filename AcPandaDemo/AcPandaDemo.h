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