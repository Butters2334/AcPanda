//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "DVTLayoutView_ML.h"
#import "IDESourceCodeEditor.h"

//#import "DVTInvalidation.h"

@class DVTStackBacktrace, IDESourceCodeEditor, IDEViewController, NSString;

//@interface IDESourceCodeEditorContainerView : DVTLayoutView_ML <DVTInvalidation>
@interface IDESourceCodeEditorContainerView : DVTLayoutView_ML
{
    IDESourceCodeEditor *_editor;
    IDEViewController *_toolbarViewController;
}

+ (void)initialize;
////- (void).cxx_destruct;
- (void)didCompleteLayout;
@property(retain) IDESourceCodeEditor *editor; // @synthesize editor=_editor;
- (void)primitiveInvalidate;
- (void)showToolbarWithViewController:(id)arg1;

// Remaining properties
@property(retain) DVTStackBacktrace *creationBacktrace;
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) DVTStackBacktrace *invalidationBacktrace;
@property(readonly) Class superclass;
@property(readonly, nonatomic, getter=isValid) BOOL valid;

@end

