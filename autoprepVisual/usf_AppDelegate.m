//
//  usf_AppDelegate.m
//  autoprepVisual
//
//  Created by Valenzuela, Eric A. on 5/23/14.
//  Copyright (c) 2014 University of San Francisco. All rights reserved.
//

#import "usf_AppDelegate.h"

@implementation usf_AppDelegate

- (IBAction)addAdmin:(id)sender {
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
}

- (IBAction)slctbar_chooseBox:(id)sender {
}

- (IBAction)applyname:(id)sender {
    
    NSString *compName = [_txt_compName stringValue];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/sbin"];
    [task setArguments: @[ @"--set ComputerName", compName ]];
    [task launch];
    
    NSTask *task2 = [[NSTask alloc] init];
    [task2 setLaunchPath: @"/usr/sbin"];
    [task2 setArguments: @[ @"--set LocalHostName", compName ]];
    [task2 launch];
    
}

- (IBAction)ldinstall:(id)sender {
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/bash"];
    [task setArguments: @[ @""] ];
}

- (IBAction)mpinstall:(id)sender{
}

- (IBAction)sysupdates:(id)sender{
}

- (IBAction)fdeenable:(id)sender{
}

- (IBAction)machinerestart:(id)sender{
}

@end
