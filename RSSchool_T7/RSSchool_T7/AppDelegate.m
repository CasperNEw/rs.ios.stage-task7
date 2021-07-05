#import "AppDelegate.h"
#import "AuthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	AuthViewController *authVC = [[AuthViewController alloc] initWithNibName:@"AuthViewController" bundle:nil];
	[window setRootViewController:authVC];
	self.window = window;
	[self.window makeKeyAndVisible];

	return YES;
}

@end
