//
//  ViewController.m
//  MultiPurpose Lighting Control
//
//  Created by Rick Russell on 3/6/16.
//  Copyright © 2016 Seacoast Church. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)sliderChanged:(id)sender {
    [(AppDelegate *)[[NSApplication sharedApplication] delegate] send:_slider.intValue];
}

@end
