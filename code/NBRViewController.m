//
//  NBRViewController.m
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/8/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import "NBRViewController.h"
#import "NBRView.h"

@interface NBRViewController ()

@property (strong) NBRView* view;

@end

@implementation NBRViewController

- (void)loadView
{
    self.view = [NBRView new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view stopRunning];
    
    [super viewWillDisappear:animated];
}

@end
