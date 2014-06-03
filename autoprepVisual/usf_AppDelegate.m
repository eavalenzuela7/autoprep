//
//  usf_AppDelegate.m
//  autoprepVisual
//
//  Created by Valenzuela, Eric A. on 5/23/14.
//  Copyright (c) 2014 University of San Francisco. All rights reserved.
//

#import "usf_AppDelegate.h"
#import "usf_autoprepAuthServices.h"

@implementation usf_AppDelegate

@synthesize txt_compName;
@synthesize txt_adminName;
@synthesize progbar_completion;
@synthesize window;
@synthesize chkbx_fdeEnableDone;
@synthesize chkbx_ldInstalled;
@synthesize chkbx_mpInstalled;
@synthesize chkbx_sysUpdatesDone;
@synthesize txt_connectPW;
@synthesize txt_connectUN;
@synthesize txt_protechPW;

int waitTime = 4;

- (IBAction)addAdmin:(id)sender {
    
    
    // dscl append task
    NSString *admin = self.txt_adminName.stringValue;
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/bin/dscl"];
    [task setArguments: @[ @".", @"append", @"/Groups/admin", @"users", admin]];
    [task launch];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    
}

- (IBAction)applyname:(id)sender {
    
    NSString *compName = self.txt_compName.stringValue;
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/sbin/scutil"];
    [task setArguments: @[ @"--set", @"ComputerName", compName ]];
    [task launch];
    
    wait( &waitTime );
    
    NSTask *task2 = [[NSTask alloc] init];
    [task2 setLaunchPath: @"/usr/sbin/scutil"];
    [task2 setArguments: @[ @"--set", @"LocalHostName", compName ]];
    [task2 launch];
    
}

- (IBAction)ldinstall:(id)sender {
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/Library/Support/"];
    [task setArguments: @[]];
}

- (IBAction)mpinstall:(id)sender{
}

- (IBAction)sysupdates:(id)sender{
}

- (IBAction)fdeenable:(id)sender{
}

- (IBAction)machinerestart:(id)sender{
}

- (IBAction)submitProtechPW:(id)sender {
}

- (IBAction)submitConnectInfo:(id)sender {
}

@end
