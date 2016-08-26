#import <SpringBoard/SpringBoard.h>


%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
%orig;

UIAlertView *alert = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"Hello Sanil!"
message:@"This is my first tweak .... BooYah"
delegate:nil
cancelButtonTitle:@"Dismiss"
otherButtonTitles:nil];
[alert show];
[alert release];

}

%end

