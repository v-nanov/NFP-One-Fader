//
//  AppDelegate.h
//  MultiPurpose Lighting Control
//
//  Created by Rick Russell on 3/6/16.
//  Copyright © 2016 Seacoast Church. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import CocoaAsyncSocket;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    long tag;
    AsyncUdpSocket *udpSocket;
    NSString *nfpAddress;
    NSString *nfpChannels;
    
}
-(void)send:(int)sliderValue;

@end

