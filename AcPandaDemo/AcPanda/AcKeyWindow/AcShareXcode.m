//
//  AcKeyWindow.m
//  AcPandaDemo
//
//  Created by Anc on 15/12/24.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import "AcShareXcode.h"
#import "AcXcodePrivate.h"
#import <Cocoa/Cocoa.h>
#import "NSObject+runtime.h"

@implementation AcShareXcode


+ (id)currentEditor
{
    NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
    if ([currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
        IDEWorkspaceWindowController *workspaceController = (IDEWorkspaceWindowController *)currentWindowController;
        IDEEditorArea *editorArea = [workspaceController editorArea];
        IDEEditorContext *editorContext = [editorArea lastActiveEditorContext];
        return [editorContext editor];
    }
    return nil;
}

+ (IDEWorkspaceDocument *)workspaceDocument
{
    NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
    id document = [currentWindowController document];
    if (currentWindowController && [document isKindOfClass:NSClassFromString(@"IDEWorkspaceDocument")]) {
        return (IDEWorkspaceDocument *)document;
    }
    return nil;
}

+ (IDESourceCodeDocument *)sourceCodeDocument
{
    if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
        IDESourceCodeEditor *editor = [self currentEditor];
        return editor.sourceCodeDocument;
    }
    
    if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeComparisonEditor")]) {
        IDESourceCodeComparisonEditor *editor = [self currentEditor];
        if ([[editor primaryDocument] isKindOfClass:NSClassFromString(@"IDESourceCodeDocument")]) {
            IDESourceCodeDocument *document = (IDESourceCodeDocument *)editor.primaryDocument;
            return document;
        }
    }
    
    return nil;
}
+(IDENavigatorArea *)ideNavigatorArea
{
    NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
    if ([currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")])
    {
        IDEWorkspaceWindowController *workspaceController = (IDEWorkspaceWindowController *)currentWindowController;
        IDEWorkspaceTabController *tabController = [workspaceController activeWorkspaceTabController];
        return [tabController navigatorArea];
    }
    return nil;
}
+(NSArrayController *)ideNavArrayController
{
    return [[self ideNavigatorArea]extensionsController];
}

+ (NSTextView *)textView
{
    if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
        IDESourceCodeEditor *editor = [self currentEditor];
        return editor.textView;
    }
    
    //不清楚IDESourceCodeComparisonEditor的完整用途,目前只知道是在开启代码管理对比时复现
    if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeComparisonEditor")]) {
        IDESourceCodeComparisonEditor *editor = [self currentEditor];
        return editor.keyTextView;
    }
    
    return nil;
}

@end




//NSResponder *firstResponder = [[NSApp keyWindow] firstResponder];
//if ([firstResponder isKindOfClass:NSClassFromString(@"DVTSourceTextView")] && [firstResponder isKindOfClass:[NSTextView class]]) {
//    self.textView = (NSTextView *)firstResponder;
//}
