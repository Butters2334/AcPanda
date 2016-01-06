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
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"🐼"
                                                                action:nil
                                                         keyEquivalent:@""];
        [actionMenuItem setTarget:self];
        [actionMenuItem setAction:@selector(menuItemEvent:)];
        [[menuItem submenu] addItem:actionMenuItem];
    }
    
//    NSArray *menuItems = [AcMenu allRootMenuItems];
//    NSLog(@"%@",menuItems);
//    [AcMenu resetRootMenuItemTitle];
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[ud dictionaryRepresentation]);
    
    [AcHook loadHook];
    
//    [AcNotification loadNotification];
    
//    [AcShareXcode currentEditor];
//    [AcShareXcode workspaceDocument];
}

#pragma mark allNotification

#pragma mark allHook

#pragma makr allKeyWindows
-(void)menuItemEvent:(NSMenuItem *)item
{
    NSArrayController *arrController = [AcShareXcode ideNavArrayController];
    NSInteger selectionIndex = [arrController selectionIndex];
    selectionIndex++;
    if(selectionIndex>=[[arrController arrangedObjects]count])
    {
        selectionIndex=0;
    }
    [arrController setSelectionIndex:selectionIndex];
    
}
@end



