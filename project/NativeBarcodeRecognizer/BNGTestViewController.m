//
//  BNGTestViewController.m
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/9/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import "BNGTestViewController.h"
#import "BNGViewController.h"

@interface BNGTestViewController ()

@property (strong) BNGViewController* scanViewController;

@end

@implementation BNGTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if ([BNGViewController canRecognizeBarcodes])
    {
        BNGViewController* scanViewController = [BNGViewController new];
        [self addChildViewController:scanViewController];
        
        scanViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:scanViewController.view];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scanView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:@{@"scanView": scanViewController.view}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scanView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:@{@"scanView": scanViewController.view}]];
        scanViewController.availableObjectTypes = @[AVMetadataObjectTypeUPCECode,
                                                    AVMetadataObjectTypeEAN13Code,
                                                    AVMetadataObjectTypeEAN8Code
                                                    ];
        
        [scanViewController didMoveToParentViewController:self];
        
        self.scanViewController = scanViewController;
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Can't scan barcode"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scanViewController startScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.scanViewController stopScanning];
    
    [super viewWillDisappear:animated];
}

@end
