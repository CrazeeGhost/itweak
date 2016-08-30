#import <SpringBoard/SpringBoard.h>
#import <Data.h>


%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
	%orig;

	NSDecimalNumber *Dataused = DataUsage();
	NSLog(@"MY TWEAK BP2 - %@", Dataused);

	UIAlertView *alert = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"Hello Sanil!"
		message:[NSString stringWithFormat:@"%@MB", Dataused]
		delegate:nil
		cancelButtonTitle:@"Dismiss"
		otherButtonTitles:nil];

	[alert show];
	[alert release];
}

%end

