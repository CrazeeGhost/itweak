#import <SpringBoard/SpringBoard.h>
#import <Data.h>


%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
	%orig;

	NSDecimalNumber *Dataused = DataUsage();
	NSTimeInterval upTime = [[NSProcessInfo processInfo] systemUptime];
	NSLog(@"MY TWEAK BP2 - %@", Dataused);

	UIAlertView *alert = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"Hello Sanil!"
		message:[NSString stringWithFormat:@"%@MB Since %f", Dataused, upTime]
		delegate:nil
		cancelButtonTitle:@"Dismiss"
		otherButtonTitles:nil];

	[alert show];
	[alert release];
}

%end

