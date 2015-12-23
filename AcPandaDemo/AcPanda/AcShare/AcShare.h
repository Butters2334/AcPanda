//
//  AcShare.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/23.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AcMenu;
@class AcNotification;
@class AcHook;

@interface AcShare : NSObject
+(instancetype)share;
//@property (nonatomic,strong)AcMenu *menu;
//@property (nonatomic,strong)AcHook *hook;
@property (nonatomic,strong)AcNotification *notification;
@end
