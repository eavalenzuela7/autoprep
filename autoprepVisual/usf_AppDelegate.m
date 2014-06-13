//
//  usf_AppDelegate.m
//  autoprepVisual
//
//  Created by Valenzuela, Eric A. on 5/23/14.
//  Copyright (c) 2014 University of San Francisco. All rights reserved.
//

#import "usf_AppDelegate.h"

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
@synthesize logField;
@synthesize btn_restart;

bool adminDone = false;
bool compNameSet = false;
bool fdeDone = false;
bool ldDone = false;
bool mpDone = false;
bool sysUpdatesDone = false;

int waitTime = 4;
NSString *protechPW;
NSString *connectUN;
NSString *connectPW;
NSFileManager *fileMngr;
OSStatus osStat;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    
    [self.progbar_completion setMinValue:0];
    [self.progbar_completion setMaxValue:6];
    fileMngr = [NSFileManager defaultManager];
    [self.logField setStringValue:@"Please enter the Protech password and your USF Connect credentials."];
    
    // NSTask to create the nibbler mountpoint - SUCCESS
    if ( [fileMngr fileExistsAtPath:@"/Volumes/nibbler"] == NO )
    {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/bin/mkdir"];
        [task setArguments: @[@"/Volumes/nibbler"]];
        [task launch];
    }
    
}

// The addAdmin task is on-hold until the rest of the program is feature-complete.
- (IBAction)addAdmin:(id)sender {
    if ( protechPW != NULL )
    {
        //osStat = AuthorizationCreate(<#const AuthorizationRights *rights#>, <#const AuthorizationEnvironment *environment#>, <#AuthorizationFlags flags#>, <#AuthorizationRef *authorization#>)
        
        // dscl append task
        NSString *admin = self.txt_adminName.stringValue;
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath: @"/usr/bin/dscl"];
        [task setArguments: @[ @".", @"append", @"/Groups/admin", @"users", admin]];
        [task launch];
        
    }
}

// Subroutine to apply entered computer name to system - SUCCESS
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
    
    // Check if LANDesk is already on the system:
    if ( [fileMngr fileExistsAtPath: @"/Library/Application Support/LANDesk/bin/ldiscan"] == NO && connectUN != NULL && connectPW != NULL )
    {
        // If LANDesk is not on the system, connect to Nibbler
        NSArray *afpPathComponents = @[@"afp://", connectUN, @":", connectPW, @"@nibbler.usfca.edu/Software/Client/Mac/LANDesk Agent"];
        NSString *afpString = [afpPathComponents componentsJoinedByString:@""];
        //NSLog (afpString);
        
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath: @"/sbin/mount_afp"];
        [task setArguments: @[@"-i", afpString, @"/Volumes/nibbler/"]];
        [task launch];
        
        wait( &waitTime ); // sleep so the mount operation can complete
        
        // enumerate wanted files in target directory, and copy to local disk:
        NSArray *fileList = [ fileMngr contentsOfDirectoryAtPath: @"/Volumes/nibbler/" error: NULL];
        NSString *dirFile;
        for ( dirFile in fileList )
        {
            if ( [dirFile.stringByStandardizingPath rangeOfString:@"USF Standard Mac Config" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                NSArray *pathComponents = @[@"/Volumes/nibbler/", dirFile.stringByStandardizingPath];
                NSString *path = [pathComponents componentsJoinedByString:@""];
                NSLog( path );
                NSTask *fileCopy = [[NSTask alloc] init];
                [fileCopy setLaunchPath: @"/bin/cp"];
                [fileCopy setArguments: @[ path, @"/Users/Shared/" ]];
                [fileCopy launch];
                NSLog(@"Copied USF Standard Mac Config package.");
            }
            else{
                NSLog(dirFile.stringByStandardizingPath);
                NSLog( @"not the file requested");
            }
            
            if ( [dirFile.stringByStandardizingPath rangeOfString:@"ld9" options:NSCaseInsensitiveSearch].location != NSNotFound )
            {
                NSArray *pathComponents = @[@"/Volumes/nibbler/", dirFile.stringByStandardizingPath];
                NSString *path = [pathComponents componentsJoinedByString:@""];
                NSLog( path );
                NSTask *fileCopy = [[NSTask alloc] init];
                [fileCopy setLaunchPath: @"/bin/cp"];
                [fileCopy setArguments: @[ path, @"/Users/Shared/" ]];
                [fileCopy launch];
            }
            else{
                NSLog(dirFile.stringByStandardizingPath);
                NSLog(@"file was not the file requested");
            }
            
        }
        
        ldDone = true;
        // END
        
    }
    else if ( connectUN == NULL || connectPW == NULL ){
        [self.logField setStringValue:@"Please enter your USF Connect username and password"];
        
    }
    else{
        if (ldDone == false)
        {
            NSLog(@"LANDesk is already installed");
            self.chkbx_ldInstalled.state = NSOnState;
            double newBarValue = self.progbar_completion.doubleValue + 1;
            [self.progbar_completion setDoubleValue:newBarValue];
            ldDone = true;
        }
    }
    
}

- (IBAction)mpinstall:(id)sender{
    if ( connectUN != NULL && connectPW != NULL )
    {
        
    }
}

- (IBAction)sysupdates:(id)sender{
}

- (IBAction)fdeenable:(id)sender{
}

- (IBAction)machinerestart:(id)sender{
}

- (IBAction)submitProtechPW:(id)sender {
    protechPW = self.txt_protechPW.stringValue;
}

- (IBAction)submitConnectInfo:(id)sender {
    connectUN = self.txt_connectUN.stringValue;
    connectPW = self.txt_connectPW.stringValue;
}

- (IBAction)chkbx_setLDinstalled:(id)sender {
}
          
- (void)essentialsComplete {
    if ( compNameSet == true && ldDone == true && mpDone == true )
    {
        [self.btn_restart setEnabled:true];
    }
}

@end
