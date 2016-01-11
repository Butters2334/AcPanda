//
//  DVTPlugInManager.h
//  AcPandaDemo
//
//  Created by Anc on 16/1/7.
//  Copyright © 2016年 Ancc. All rights reserved.
//


#import <Foundation/Foundation.h>

@class DVTDispatchLock, DVTPlugInLocator, NSArray, NSDictionary, NSFileManager, NSMutableArray, NSMutableDictionary, NSMutableSet, NSSet, NSString, NSUUID;

@interface DVTPlugInManager : NSObject
{
    DVTDispatchLock *_plugInManagerLock;
    NSFileManager *_fileManager;
    NSString *_hostAppName;
    NSString *_hostAppContainingPath;
    NSMutableArray *_searchPaths;
    NSArray *_extraSearchPaths;
    NSMutableSet *_pathExtensions;
    NSMutableSet *_exposedCapabilities;
    NSMutableSet *_defaultPlugInCapabilities;
    NSMutableSet *_requiredPlugInIdentifiers;
    NSString *_plugInCachePath;
    NSDictionary *_plugInCache;
    BOOL _shouldClearPlugInCaches;
    DVTPlugInLocator *_plugInLocator;
    NSMutableDictionary *_plugInsByIdentifier;
    NSMutableDictionary *_extensionPointsByIdentifier;
    NSMutableDictionary *_extensionsByIdentifier;
    NSMutableDictionary *_invalidExtensionsByIdentifier;
    NSMutableSet *_warnedExtensionPointFailures;
    NSMutableSet *_nonApplePlugInSanitizedStatuses;
    struct {
        unsigned long _reserved:62;
        unsigned int _isSecondaryScan:1;
        unsigned int _hasScannedForPlugIns:1;
    } _flags;
}

+ (void)_setDefaultPlugInManager:(id)arg1;
+ (id)defaultPlugInManager;
+ (void)initialize;
@property(retain) DVTPlugInLocator *plugInLocator; // @synthesize plugInLocator=_plugInLocator;
@property BOOL shouldClearPlugInCaches; // @synthesize shouldClearPlugInCaches=_shouldClearPlugInCaches;
//- (void).cxx_destruct;
- (id)_invalidExtensionWithIdentifier:(id)arg1;
- (id)_plugInCachePath;
- (id)_applicationCachesPath;
- (id)_toolsVersionName;
- (void)_createPlugInObjectsFromCache;
- (BOOL)_savePlugInCacheWithScanRecords:(id)arg1 error:(id *)arg2;
- (BOOL)_removePlugInCacheAndReturnError:(id *)arg1;
- (BOOL)_removePlugInCacheAtPath:(id)arg1 error:(id *)arg2;
- (id)_plugInCacheSaveFailedErrorWithUnderlyingError:(id)arg1;
- (BOOL)_loadPlugInCache:(id *)arg1;
- (BOOL)_cacheCoversPlugInsWithScanRecords:(id)arg1;
- (id)_modificationDateOfFileAtPath:(id)arg1;
@property(readonly) BOOL usePlugInCache;
- (void)_preLoadPlugIns;
- (BOOL)_checkPresenceOfRequiredPlugIns:(id)arg1 error:(id *)arg2;
- (BOOL)_checkMarketingVersionOfApplePlugIns:(id)arg1 error:(id *)arg2;
- (BOOL)shouldPerformConsistencyCheck;
- (void)_registerPlugInsFromScanRecords:(id)arg1;
- (void)_pruneUnusablePlugInsAndScanRecords:(id)arg1;
- (void)_recordSanitizedPluginStatus:(id)arg1 errorMessage:(id)arg2;
- (void)_addSanitizedNonApplePlugInStatusForBundle:(id)arg1 reason:(id)arg2;
@property(readonly) NSSet *sanitizedNonApplePlugInStatuses;
- (void)_createPlugInObjectsFromScanRecords:(id)arg1;
- (void)_applyActivationRulesToScanRecords:(id)arg1;
- (id)_scanForPlugInsInDirectories:(id)arg1 skippingDuplicatesOfPlugIns:(id)arg2;
- (BOOL)_scanForPlugIns:(id *)arg1;
@property(readonly) NSUUID *plugInHostUUID;
@property BOOL hasScannedForPlugIns; // @dynamic hasScannedForPlugIns;
- (id)_scanRecordForBundle:(id)arg1 atPath:(id)arg2;
- (BOOL)_isInitialScan;
- (id)_defaultPathExtensions;
@property(readonly) NSArray *defaultSearchPaths;
- (id)_defaultApplicationSupportSubdirectory;
@property(readonly) NSArray *extraSearchPaths;
- (id)_extensionsForExtensionPoint:(id)arg1 matchingPredicate:(id)arg2;
- (id)sharedExtensionsForExtensionPoint:(id)arg1 matchingPredicate:(id)arg2;
- (id)sharedExtensionWithIdentifier:(id)arg1;
- (id)extensionWithIdentifier:(id)arg1;
- (id)extensionPointWithIdentifier:(id)arg1;
- (id)plugInWithIdentifier:(id)arg1;
- (BOOL)scanForPlugIns:(id *)arg1;
- (id)init;
- (id)_hostAppName;
- (id)_hostAppContainingPath;

// Remaining properties
@property(copy) NSSet *defaultPlugInCapabilities; // @dynamic defaultPlugInCapabilities;
@property(copy) NSSet *exposedCapabilities; // @dynamic exposedCapabilities;
@property(readonly) NSMutableSet *mutableDefaultPlugInCapabilities; // @dynamic mutableDefaultPlugInCapabilities;
@property(readonly) NSMutableSet *mutableExposedCapabilities; // @dynamic mutableExposedCapabilities;
@property(readonly) NSMutableSet *mutablePathExtensions; // @dynamic mutablePathExtensions;
@property(readonly) NSMutableSet *mutableRequiredPlugInIdentifiers; // @dynamic mutableRequiredPlugInIdentifiers;
@property(readonly) NSMutableArray *mutableSearchPaths; // @dynamic mutableSearchPaths;
@property(copy) NSSet *pathExtensions; // @dynamic pathExtensions;
@property(copy) NSSet *requiredPlugInIdentifiers; // @dynamic requiredPlugInIdentifiers;
@property(copy) NSArray *searchPaths; // @dynamic searchPaths;

@end
