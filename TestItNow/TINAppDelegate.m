//
//  TINAppDelegate.m
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "TINAppDelegate.h"
#import "TINProductsViewController.h"
#import "TINURLCache.h"

@interface TINAppDelegate ()

@end

@implementation TINAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // image cache
    [NSURLCache setSharedURLCache:[TINURLCache standardURLCache]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TINProductsViewController *rootVC = [[TINProductsViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
