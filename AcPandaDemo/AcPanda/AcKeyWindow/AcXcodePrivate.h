//
//  AcXcodePrivate.h
//  AcPandaDemo
//
//  Created by Anc on 15/12/24.
//  Copyright © 2015年 Ancc. All rights reserved.
//

//  this file is from https://github.com/qfish/XAlign/blob/master/Xcode/xprivates.h

//比较简单的类都整合在这里,比较庞大的类单独建类

#import <Cocoa/Cocoa.h>
#import "IDESourceCodeDocument.h"
#import "DVTPlugInManager.h"

@class DVTDispatchLock, DVTExtensionPoint, DVTPlugIn, DVTPlugInManager, NSBundle, NSDictionary, NSMutableDictionary, NSString, NSXMLElement;
@class DVTExtensionElementDescription, DVTPlugIn, DVTPlugInManager, NSBundle, NSDictionary, NSMutableSet, NSSet, NSString;


@interface DVTTextDocumentLocation : NSObject
@property (readonly) NSRange characterRange;
@property (readonly) NSRange lineRange;
@end

@interface DVTTextPreferences : NSObject
+ (id)preferences;
@property BOOL trimWhitespaceOnlyLines;
@property BOOL trimTrailingWhitespace;
@property BOOL useSyntaxAwareIndenting;
@property long long tabWidth;
@end

@interface DVTSourceTextStorage : NSTextStorage
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)string withUndoManager:(id)undoManager;
- (NSRange)lineRangeForCharacterRange:(NSRange)range;
- (NSRange)characterRangeForLineRange:(NSRange)range;
- (void)indentCharacterRange:(NSRange)range undoManager:(id)undoManager;
@end

@interface DVTFileDataType : NSObject
@property (readonly) NSString *identifier;
@end

@interface DVTFilePath : NSObject
@property (readonly) NSURL *fileURL;
@property (readonly) DVTFileDataType *fileDataTypePresumed;
@end

@interface IDEContainerItem : NSObject
@property (readonly) DVTFilePath *resolvedFilePath;
@end

@interface IDEGroup : IDEContainerItem

@end

@interface IDEFileReference : IDEContainerItem

@end

@interface IDENavigableItem : NSObject
@property (readonly) IDENavigableItem *parentItem;
@property (readonly) id representedObject;
@end

@interface IDEFileNavigableItem : IDENavigableItem
@property (readonly) DVTFileDataType *documentType;
@property (readonly) NSURL *fileURL;
@end

@interface IDEStructureNavigator : NSObject
@property (retain) NSArray *selectedObjects;
@end

@interface IDENavigableItemCoordinator : NSObject
- (id)structureNavigableItemForDocumentURL:(id)arg1 inWorkspace:(id)arg2 error:(id *)arg3;
@end

@interface IDENavigatorArea : NSObject
- (id)currentNavigator;
-(NSArrayController *)extensionsController;
@end

@interface IDEWorkspaceTabController : NSObject
@property (readonly) IDENavigatorArea *navigatorArea;
@end

@interface IDEDocumentController : NSDocumentController
+ (id)editorDocumentForNavigableItem:(id)arg1;
+ (id)retainedEditorDocumentForNavigableItem:(id)arg1 error:(id *)arg2;
+ (void)releaseEditorDocument:(id)arg1;
@end

//迁移到IDESourceCodeDocument.h中
//@interface IDESourceCodeDocument : NSDocument
//- (DVTSourceTextStorage *)textStorage;
//- (NSUndoManager *)undoManager;
//@end

@interface IDESourceCodeComparisonEditor : NSObject
@property (readonly) NSTextView *keyTextView;
@property (retain) NSDocument *primaryDocument;
@end

@interface IDESourceCodeEditor : NSObject
@property (retain) NSTextView *textView;
- (IDESourceCodeDocument *)sourceCodeDocument;
@end

@interface IDEEditorContext : NSObject
- (id)editor; // returns the current editor. If the editor is the code editor, the class is `IDESourceCodeEditor`
@end

@interface IDEEditorArea : NSObject
- (IDEEditorContext *)lastActiveEditorContext;
@end

@interface IDEWorkspaceWindowController : NSObject
@property (readonly) IDEWorkspaceTabController *activeWorkspaceTabController;
- (IDEEditorArea *)editorArea;
@end

@interface IDEWorkspace : NSObject
@property (readonly) DVTFilePath *representingFilePath;
@end

@interface IDEWorkspaceDocument : NSDocument
@property (readonly) IDEWorkspace *workspace;
@end


//160107新增

/**navigator单项*/
@class DVTExtension;
@interface DVTChoice : NSObject
{
    NSString *_title;
    NSString *_toolTip;
    NSImage *_image;
    NSString *_identifier;
    id _representedObject;
    BOOL _enabled;
}
@property(getter=isEnabled) BOOL enabled; // @synthesize enabled=_enabled;
@property(readonly) DVTExtension *representedObject; // @synthesize representedObject=_representedObject;
@property(copy) NSString *identifier; // @synthesize identifier=_identifier;
@property(readonly) NSImage *image; // @synthesize image=_image;
@property(readonly) NSString *toolTip; // @synthesize toolTip=_toolTip;
@property(readonly) NSString *title; // @synthesize title=_title;
//- (void).cxx_destruct;
- (id)description;
- (id)initWithTitle:(id)arg1 toolTip:(id)arg2 image:(id)arg3 representedObject:(id)arg4;
@end

@protocol DVTPropertyListEncoding <NSObject>
- (void)encodeIntoPropertyList:(id)arg1;
- (void)awakeWithPropertyList:(id)arg1;
- (id)initWithPropertyList:(id)arg1 owner:(id)arg2;
@end

@interface DVTExtension : NSObject <DVTPropertyListEncoding>
{
    NSMutableDictionary *_extensionData;
    DVTPlugInManager *_plugInManager;
    NSString *_identifier;
    NSString *_version;
    NSString *_name;
    DVTPlugIn *_plugIn;
    DVTExtensionPoint *_extensionPoint;
    DVTExtension *_basedOnExtension;
    NSXMLElement *_extensionElement;
    DVTDispatchLock *_faultFiringLock;
    struct {
        unsigned long reserved:60;
        unsigned int _adjustedExtensionData:1;
        unsigned int _checkedExtensionXML:1;
        unsigned int _faultingState:2;
    } _flags;
}

+ (void)initialize;
@property(readonly) DVTExtension *basedOnExtension; // @synthesize basedOnExtension=_basedOnExtension;
@property(readonly) DVTExtensionPoint *extensionPoint; // @synthesize extensionPoint=_extensionPoint;
@property(readonly) DVTPlugIn *plugIn; // @synthesize plugIn=_plugIn;
@property(readonly) NSDictionary *extensionData; // @synthesize extensionData=_extensionData;
@property(readonly) DVTPlugInManager *plugInManager; // @synthesize plugInManager=_plugInManager;
@property(readonly) NSString *name; // @synthesize name=_name;
@property(readonly) NSString *version; // @synthesize version=_version;
@property(readonly) NSString *identifier; // @synthesize identifier=_identifier;
//- (void).cxx_destruct;
- (id)_localizedStringForString:(id)arg1;
- (BOOL)_fireExtensionFault:(id *)arg1;
- (void)_adjustClassReferencesInParameterData:(id)arg1 usingSchema:(id)arg2;
- (void)_adjustElementClassAttributes:(id)arg1 forKey:(id)arg2 inParameterData:(id)arg3;
- (void)_adjustClassAttribute:(id)arg1 forKey:(id)arg2 inParameterData:(id)arg3;
- (BOOL)_adjustElement:(id)arg1 forKey:(id)arg2 inParameterData:(id)arg3;
- (BOOL)_adjustAttribute:(id)arg1 forKey:(id)arg2 inParameterData:(id)arg3;
- (BOOL)_adjustParameterData:(id)arg1 usingSchema:(id)arg2;
- (BOOL)hasValueForKey:(id)arg1;
- (BOOL)_hasValueForKey:(id)arg1 inParameterData:(id)arg2 usingSchema:(id)arg3;
- (id)valueForKey:(id)arg1 error:(id *)arg2;
- (id)valueForKey:(id)arg1;
- (id)_valueForKey:(id)arg1 inParameterData:(id)arg2 usingSchema:(id)arg3 error:(id *)arg4;
@property(readonly) NSXMLElement *extensionElement;
@property(readonly, getter=isValid) BOOL valid;
@property(readonly) NSBundle *bundle;
- (id)description;
- (void)encodeIntoPropertyList:(id)arg1;
- (void)awakeWithPropertyList:(id)arg1;
- (id)initWithPropertyList:(id)arg1 owner:(id)arg2;
- (id)initWithExtensionData:(id)arg1 plugIn:(id)arg2;

@end



@interface DVTExtensionPoint : NSObject <DVTPropertyListEncoding>
{
    NSDictionary *_extensionPointData;
    DVTPlugInManager *_plugInManager;
    NSString *_identifier;
    NSString *_version;
    NSString *_name;
    DVTPlugIn *_plugIn;
    DVTExtensionElementDescription *_extensionSchema;
    DVTExtensionPoint *_parentExtensionPoint;
    NSMutableSet *_extensions;
    NSMutableSet *_childExtensionPoints;
}

@property(readonly, copy) NSSet *childExtensionPoints; // @synthesize childExtensionPoints=_childExtensionPoints;
@property(readonly, copy) NSSet *extensions; // @synthesize extensions=_extensions;
@property(readonly) DVTPlugIn *plugIn; // @synthesize plugIn=_plugIn;
@property(readonly, copy) NSString *name; // @synthesize name=_name;
@property(readonly, copy) NSString *version; // @synthesize version=_version;
@property(readonly, copy) NSString *identifier; // @synthesize identifier=_identifier;
//- (void).cxx_destruct;
- (void)_registerChildExtensionPoint:(id)arg1;
- (void)_registerExtension:(id)arg1;
- (id)extensionsMatchingPredicate:(id)arg1;
@property(readonly) NSBundle *bundle;
@property(readonly) DVTExtensionPoint *parentExtensionPoint; // @dynamic parentExtensionPoint;
@property(readonly, copy) DVTExtensionElementDescription *extensionSchema; // @dynamic extensionSchema;
- (void)_setUpParentExtensionPoint;
@property(readonly, copy) NSString *description;
- (void)encodeIntoPropertyList:(id)arg1;
- (void)awakeWithPropertyList:(id)arg1;
- (id)initWithPropertyList:(id)arg1 owner:(id)arg2;
- (id)initWithExtensionPointData:(id)arg1 plugIn:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
//@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
