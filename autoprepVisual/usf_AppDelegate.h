//
//  usf_AppDelegate.h
//  autoprepVisual
//
//  Created by Valenzuela, Eric A. on 5/23/14.
//  Copyright (c) 2014 University of San Francisco. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface usf_AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *chkbx_ldInstalled;
@property (weak) IBOutlet NSButton *chkbx_mpInstalled;
@property (weak) IBOutlet NSButton *chkbx_sysUpdatesDone;
@property (weak) IBOutlet NSButton *chkbx_fdeEnableDone;
@property (weak) IBOutlet NSTextField *txt_compName;
@property (weak) IBOutlet NSTextField *txt_adminName;

- (IBAction)applyname:(id)sender;
- (IBAction)addAdmin:(id)sender;
- (IBAction)ldinstall:(id)sender;
- (IBAction)mpinstall:(id)sender;
- (IBAction)sysupdates:(id)sender;
- (IBAction)fdeenable:(id)sender;
- (IBAction)machinerestart:(id)sender;

@end
