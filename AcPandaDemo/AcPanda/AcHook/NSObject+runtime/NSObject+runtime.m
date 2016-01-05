//
//  NSObject+runtime.m
//  muyingzhijia
//
//  Created by Anc on 15/12/10.
//  Copyright © 2015年 holyca. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>
//#import <objc/objc.h>
#import <objc/message.h>
#import <objc/objc-api.h>

//#define OBJC_OLD_DISPATCH_PROTOTYPES 1
//OBJC_EXPORT id objc_msgSend(id self, SEL op, ...);

@implementation NSObject (runtime)
/**
 *  修改任何类的函数,使用新函数替代,可用于delegate或系统函数
 *  @tip:需要注意替换之后在整个项目中都不能调用原先的函数,需要时都只能调用新函数,函数交换需要严格考虑好
 *  @tip:如果originalSelector并不存在于class中时,流程等于是给class创建了新函数(但是名称为originalSelector)
 *  @tip:慎用
 *
 *  @param originalSelector 原先的函数
 *  @param swizzledSelector 需要替换的函数
 */
+(void)exchangeWithMethod1:(SEL)originalSelector andMethod2:(SEL)swizzledSelector
{
    Class class = [self class];
    if(!class || !originalSelector || !swizzledSelector)
    {
        NSLog(@"method 入参有误");
        return ;
    }
    //1,类函数需要用method_exchangeImplementations来替换
    //2,resolveInstanceMethod和resolveClassMethod都不太好用,这里改为获取Method判断
    Method originalMethod_instance = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod_instance = class_getInstanceMethod(class, swizzledSelector);
    Method originalMethod_class = class_getClassMethod(class, originalSelector);
    Method swizzledMethod_class = class_getClassMethod(class, swizzledSelector);
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod_instance), method_getTypeEncoding(swizzledMethod_instance));
    //success用于标记出委托函数之类没有实现的函数
    //originalMethod_instance && swizzledMethod_instance标记出实例函数替换,找不到originalMethod_instance时可能是原委托函数没有实现导致;
    //originalMethod_class && swizzledMethod_class类函数交换(类函数不做判断是否有实现)
    if((originalMethod_instance && swizzledMethod_instance) || success)
    {
        if (success)
        {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod_instance), method_getTypeEncoding(originalMethod_instance));
        } else {
            method_exchangeImplementations(originalMethod_instance, swizzledMethod_instance);
        }
    }else if(originalMethod_class && swizzledMethod_class){
        method_exchangeImplementations(originalMethod_class, swizzledMethod_class);
    }else{
        NSLog(@"%@-在%@中不存在(不能替换不存在的函数)",NSStringFromSelector(originalSelector),class);
    }
}
+(void)exchangeWithSEL1:(NSString *)originalSelector andSEL2:(NSString *)swizzledSelector
{
    [self exchangeWithMethod1:NSSelectorFromString(originalSelector)
                   andMethod2:NSSelectorFromString(swizzledSelector)];
}
//-(void)exchangeWithMethod1:(SEL)originalSelector andMethod2:(SEL)swizzledSelector
//{
//    [self.class exchangeWithMethod1:originalSelector andMethod2:swizzledSelector];
//}
//-(void)exchangeWithSEL1:(NSString *)originalSelector andSEL2:(NSString *)swizzledSelector
//{
//    [self.class exchangeWithSEL1:originalSelector andSEL2:swizzledSelector];
//}


-(id)ac_performSelector:(SEL)aSel
{
    if(!self || !aSel)
    {
        NSLog(@"入参错误 - %@",NSStringFromSelector(_cmd));
        return nil;
    }
    id (*action)(id,SEL) = (id (*)(id,SEL))objc_msgSend;
    return action(self,aSel);
//    return objc_msgSend(self,aSel);
}


-(NSArray<NSString *>*)propertyList
{
    return [self.class propertyList];
}
+(NSArray<NSString *>*)propertyList
{
    unsigned int count;
    objc_property_t *propertyList  = class_copyPropertyList(self, &count);
    NSMutableArray *nameList       = [NSMutableArray new];
    NSMutableArray *attributesList = [NSMutableArray new];
    for(unsigned int index = 0;index<count;index++)
    {
        objc_property_t property       = propertyList[index];
        const char *propertyName       = property_getName(property);
        const char *propertyAttributes = property_getAttributes(property);
        unsigned int attributeCount;
//        objc_property_attribute_t *attribute_t = property_copyAttributeList(property, &attributeCount);
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
        [attributesList addObject:[NSString stringWithUTF8String:propertyAttributes]];
    }
    return nameList;
}
-(NSArray<NSString *>*)methodList
{
    return [self.class methodList];
}
+(NSArray<NSString *>*)methodList
{
    unsigned int count;
    Method *methodList       = class_copyMethodList(self, &count);
    NSMutableArray *nameList = [NSMutableArray new];
    for(unsigned int index=0;index<count;index++)
    {
        Method method  = methodList[index];
        SEL method_SEL = method_getName(method);
        [nameList addObject:NSStringFromSelector(method_SEL)];
    }
    return nameList;
}
-(NSArray<NSString *>*)ivarList
{
    return [self.class ivarList];
}
+(NSArray<NSString *>*)ivarList
{
    unsigned int count;
    Ivar *ivarList           = class_copyIvarList(self, &count);
    NSMutableArray *nameList = [NSMutableArray new];
    for(unsigned int index=0;index<count;index++)
    {
        Ivar ivar                = ivarList[index];
        const char *propertyName = ivar_getName(ivar);
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return nameList;
}
-(NSArray<NSString *>*)protocolList
{
    return [self.class protocolList];
}
+(NSArray<NSString *>*)protocolList
{
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(self, &count);
    NSMutableArray *nameList                    = [NSMutableArray new];
    for(unsigned int index=0;index<count;index++)
    {
        Protocol *protocol       = protocolList[index];
        const char *propertyName = protocol_getName(protocol);
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return nameList;
}
@end
