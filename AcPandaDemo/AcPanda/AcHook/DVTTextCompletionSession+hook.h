//
//  DVTTextCompletionSession+hook.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/22.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "DVTTextCompletionSession.h"

/**
 *  联想输入即将结束,可以获取到联想输入的状态,选中项等信息,可以用于联想结果替换等
 */
@interface DVTTextCompletionSession (Hook)
+ (void)hook_swizzleMethods;
@end
