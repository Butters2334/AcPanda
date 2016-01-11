//
//  AcPandaDemo.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/21.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "AcPandaDemo.h"

#import "AcMenu.h"
#import "AcNotification.h"
#import "AcHook.h"
#import "AcShareXcode.h"
#import "AcXcodePrivate.h"

static AcPandaDemo *sharedPlugin;
 
@interface AcPandaDemo()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation AcPandaDemo
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark --初始化--
+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        self.bundle = plugin;
    }
    return self;
}


- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSApplicationDidFinishLaunchingNotification
                                                  object:nil];
    //在通知回调之后才能获取到mainMenu对象
    NSMenuItem *menuItem = [AcMenu rootMenuWithTitle:@"Edit"];
    if (menuItem)
    {
        //分割线
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        //新建一个功能按钮,可以不添加事件
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] init];
        [actionMenuItem setTitle:@"🐼"];
        //设置按钮的事件
        [actionMenuItem setTarget:self];
        [actionMenuItem setAction:@selector(menuItemEvent:)];
        //设置按钮关联实体键盘
        unichar f6                 = NSF6FunctionKey;
        NSString *keyEquivalent    = [NSString stringWithCharacters:&f6 length:1];
        keyEquivalent              = @"d";//需要把xcode原先对应的按键关键删掉才能使用
        [actionMenuItem setKeyEquivalent:keyEquivalent];
        [actionMenuItem setKeyEquivalentModifierMask:NSCommandKeyMask|NSShiftKeyMask];//参考NSEventModifierFlags
        [[menuItem submenu] addItem:actionMenuItem];
    }
    
//    NSArray *menuItems = [AcMenu allRootMenuItems];
//    NSLog(@"%@",menuItems);
//    [AcMenu resetRootMenuItemTitle];
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[ud dictionaryRepresentation]);
    
    [AcHook loadHook];
    
    [AcNotification loadNotification];
    
//    [AcShareXcode currentEditor];
//    [AcShareXcode workspaceDocument];
}

#pragma mark allNotification

#pragma mark allHook

#pragma makr allKeyWindows
-(void)menuItemEvent:(NSMenuItem *)item
{
    NSArrayController *arrController = [AcShareXcode ideNavArrayController];
    //每次点击将arrController往后移动
    NSInteger selectionIndex = [arrController selectionIndex];
    selectionIndex++;
    if(selectionIndex>=[[arrController arrangedObjects]count])
    {
        selectionIndex=0;
    }
    [arrController setSelectionIndex:selectionIndex];
    
//    //理论上项目结构页在边栏的第一项,为了避免出错,还是遍历一下吧
//    //DVTChoice *choice = arrController.arrangedObjects[0];
//    //DVTExtension *extension=[choice representedObject];
//    for(DVTChoice *choice in arrController.arrangedObjects)
//    {
//        DVTExtension *extension = [choice representedObject];
//        if([extension.identifier isEqualToString:@"Xcode.IDEKit.Navigator.Structure"])
//        {
//            NSLog(@"test");
//        }
//    }
}
@end



