//
//  AEAppDelegate.h
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
