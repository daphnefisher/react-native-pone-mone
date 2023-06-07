#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeDelegate.h>
#import <UserNotifications/UNUserNotificationCenter.h>


@interface RNPOneMOneHelper : UIResponder<RCTBridgeDelegate, UNUserNotificationCenterDelegate>

+ (instancetype)poneMOne_shared;
- (BOOL)poneMOne_tryThisWay:(void (^)(void))changeVcBlock;
- (UIInterfaceOrientationMask)poneMOne_getOrientation;
- (UIViewController *)poneMOne_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end
