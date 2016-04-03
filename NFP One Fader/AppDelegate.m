//
//  AppDelegate.m
//  MultiPurpose Lighting Control
//
//  Created by Rick Russell on 3/6/16.
//  Copyright © 2016 Seacoast Church. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSBundle *appBundle = [NSBundle mainBundle];
    nfpAddress = [appBundle objectForInfoDictionaryKey:@"NFPAddress"];
    nfpChannels = [appBundle objectForInfoDictionaryKey:@"NFPChannels"];
    
    udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    
    NSError *error = nil;
    
    if (![udpSocket bindToPort:0 error:&error])
    {
        NSLog(@"Error binding: %@", error);
        return;
    }
    
    [udpSocket receiveWithTimeout:-1 tag:0];
    
    NSLog(@"Ready");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)send:(int)sliderValue
{
    
    NSString *host = nfpAddress;
    if ([host length] == 0)
    {
        NSLog(@"Address required");
        return;
    }
    
    int port = 3793;
    if (port <= 0 || port > 65535)
    {
        NSLog(@"Valid port required");
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"C%@L%iT0", nfpChannels, sliderValue];
    if ([msg length] == 0)
    {
        NSLog(@"Message required");
        return;
    }
    msg = [msg stringByAppendingString:@"\r"];
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    NSLog(FORMAT(@"SENT (%i): %@", (int)tag, msg));
    
    tag++;
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    // You could add checks here
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    // You could add checks here
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock
     didReceiveData:(NSData *)data
            withTag:(long)tag
           fromHost:(NSString *)host
               port:(UInt16)port
{
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (msg)
    {
        NSLog(FORMAT(@"RECV: %@", msg));
    }
    else
    {
        NSLog(FORMAT(@"RECV: Unknown message from: %@:%hu", host, port));
    }
    
    [udpSocket receiveWithTimeout:-1 tag:0];
    return YES;
}

// Close the application if the window is closed
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}


@end
