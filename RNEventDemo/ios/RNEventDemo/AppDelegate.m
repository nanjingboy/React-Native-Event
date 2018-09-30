/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "ZMReactEventEmitterManager.h"
#import "ZMReactEventEmitter.h"
#import "UIView+Toast.h"

@interface AppDelegate()

@property(nonatomic, strong) RCTRootView *rootView;
@property(nonatomic, strong) ZMReactEventEmitter *eventEmitter;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;

  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  self.rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                              moduleName:@"RNEventDemo"
                                       initialProperties:nil
                                           launchOptions:launchOptions];
  self.rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = self.rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(subscribeRNEventDemoManager)
                                               name:@"RNEventDemoManager"
                                             object:nil];
  self.eventEmitter = [ZMReactEventEmitter new];
  return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  [[NSNotificationCenter defaultCenter] removeObserver:@"RNEventDemoManager"];
}

- (void)subscribeRNEventDemoManager {
  __weak typeof(self) weakSelf = self;
  [self.eventEmitter sendEvent:self.rootView.bridge name:@"demo" params:@"Request from Native" callback:^(id data) {
    if (weakSelf != nil) {
      [weakSelf.rootView makeToast:data[@"data"]];
    }
  }];
}

@end
