//
//  AcKeyWindow.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/24.
//  Copyright © 2015年 Ancc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IDEWorkspaceDocument;
@class IDESourceCodeDocument;
@class NSTextView;

@interface AcShareXcode : NSObject
+ (id)currentEditor;
+ (IDEWorkspaceDocument *)workspaceDocument;
+ (IDESourceCodeDocument *)sourceCodeDocument;
+ (NSTextView *)textView;
@end






/**
 *   从NSApp keywindow的结构中拆除编辑框,视图层等,需要对视图结构有一定的理解
 *
 *   参考https://github.com/qfish/XAlign
 *      https://github.com/benoitsan/BBUncrustifyPlugin-Xcode
 *
 *   keyWindow需要等xcode加载完才能调用,需要至少等待NSApplicationDidFinishLaunchingNotification回调之后
 *
 *   获取当前编辑框:[[[[[NSApp keyWindow]windowController]editorArea]lastActiveEditorContext]editor]
 *
 *   [NSApp keyWindow]:
 *      IDEWorkspaceWindow
 *          windowController:                   IDEWorkspaceWindowController
 *              editorArea:                     IDEEditorArea
 *                  lastActiveEditorContext:    IDEEditorContext
 *                      (当前编辑框)调试框编辑时:
 *                      editor:                 IDEEditorEmpty
 *                          textView:           DVTSourceTextView(调试窗口编辑框)
 *                      (当前编辑框)主代码编辑时:
 *                      editor:                 IDESourceCodeEditor
 *                          textView:           DVTSourceTextView(代码编辑框)
 *                      (当前编辑框)开启代码版本对比工具时,左右都一样:
 *                      editor:                 IDESourceCodeComparisonEditor
 *                          keyTextView:        DVTSourceTextView(代码编辑框)
 *          document:                           IDEWorkspaceDocument
 *              workspace:                      IDEWorkspace
 *                  representingFilePath:       DVTFilePath
 *                      fileDataTypePresumed:   DVTDeclaredPrimitiveFileDataType
 *                          identifier:(string) com.apple.dt.document.workspace
 *
 *
 *
 */