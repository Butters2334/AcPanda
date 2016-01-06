//
//  IDESourceCodeDocument+Hook.m
//  AcPandaDemo
//
//  Created by Anc on 16/1/6.
//  Copyright © 2016年 Ancc. All rights reserved.
//

#import "IDESourceCodeDocument+Hook.h"
#import "JRSwizzle/JRSwizzle.h"
#import "XcodeHeaders/IDESourceCodeDocument.h"
//@implementation IDESourceCodeDocument
//@end

@implementation IDESourceCodeDocument (Hook)
+ (void)hook_swizzleMethods
{
    NSError *error;
    [self jr_swizzleMethod: @selector(sourceCodeGenerator:commitInsertionOfSourceCodeForCompositeResult:error:)
                withMethod: @selector(hook_sourceCodeGenerator:commitInsertionOfSourceCodeForCompositeResult:error:)
                     error: &error];
    if(error)
    {
        NSLog(@"%@",error);
    }
}
- (id)hook_sourceCodeGenerator:(id)arg1 commitInsertionOfSourceCodeForCompositeResult:(id)arg2 error:(id *)arg3
{
    
    
    return [self hook_sourceCodeGenerator:arg1 commitInsertionOfSourceCodeForCompositeResult:arg2 error:arg3];
}

@end
