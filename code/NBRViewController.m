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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLayerSession];
}

- (void)setupLayerSession
{
    NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    NSParameterAssert(devices.count > 0); // TODO: check for devices, handle error
    
    AVCaptureDevice* device;
    
    for (AVCaptureDevice* cameraDevice in devices)
    {
        if (cameraDevice.position == AVCaptureDevicePositionBack)
        {
            device = cameraDevice;
            break;
        }
    }
    NSParameterAssert(device != nil); // TODO: handle error
    
    NSError* inputError;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&inputError];
    NSParameterAssert(inputError == nil); // TODO: handle error
    
    AVCaptureSession* session = [AVCaptureSession new];
    
    // TODO: check for ability to add input, handle error
    
    [session addInput:input];
//    [session addOutput:<#(AVCaptureOutput *)#>]
    
    // TODO: add machinereadable code recognition output
    
    self.view.layer.session = session;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view.layer.session startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view.layer.session stopRunning];
    
    [super viewWillDisappear:animated];
}

@end
