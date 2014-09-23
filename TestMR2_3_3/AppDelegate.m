//
//  AppDelegate.m
//  TestMR2_3_3
//
//  Created by Richard Wylie on 28/07/2014.
//  Copyright (c) 2014 sigmundfridge. All rights reserved.
//

#import "AppDelegate.h"
#import "Test1+Custom.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelVerbose];
    [MagicalRecord setupCoreDataStack];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"uuid != nil"];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        [Test1 MR_deleteAllMatchingPredicate:p inContext:localContext];
        
    }completion:^(BOOL success, NSError *error) {
    }];
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        [self createEntityWithUuid:@"1" inContext:localContext];
        [self createEntityWithUuid:@"2" inContext:localContext];
        [self createEntityWithUuid:@"3" inContext:localContext];
        [self createEntityWithUuid:@"4" inContext:localContext];
        [self createEntityWithUuid:@"5" inContext:localContext];
        [self createEntityWithUuid:@"6" inContext:localContext];
        [self createEntityWithUuid:@"7" inContext:localContext];
        [self createEntityWithUuid:@"8" inContext:localContext];
        [self createEntityWithUuid:@"1" inContext:localContext];
        [self createEntityWithUuid:@"1" inContext:localContext];
        
    }completion:^(BOOL success, NSError *error) {
    }];
    return YES;

}

- (void) createEntityWithUuid:(NSString *)uuidStr inContext:(NSManagedObjectContext*)context {

    Test1 *output = [Test1 MR_createEntityInContext:context];
    output.uuid = uuidStr;
    
    NSString *fNameStr = [AppDelegate randomStringOfLength:10];
    NSString *lNameStr = [AppDelegate randomStringOfLength:10];
    
    output.fName = fNameStr;
    output.lName = lNameStr;
}

+(NSString*)randomStringOfLength:(int)length {
    static NSString *letters = @"abcdefghijlmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *string = [NSMutableString stringWithCapacity:length];
    for(int i=0;i<length;i++) {
        [string appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return string;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
