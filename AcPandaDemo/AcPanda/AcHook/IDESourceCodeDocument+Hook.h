//
//  IDESourceCodeDocument+Hook.h
//  AcPandaDemo
//
//  Created by Anc on 16/1/6.
//  Copyright © 2016年 Ancc. All rights reserved.
//

//#import "AcXcodePrivate.h"
#import "IDESourceCodeDocument.h"
//
@interface IDESourceCodeDocument (Hook)
+ (void)hook_swizzleMethods;
@end
