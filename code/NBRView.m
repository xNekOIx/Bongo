//
//  NBRView.m
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/8/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import "NBRView.h"
#import <AVFoundation/AVFoundation.h>

@interface NBRView ()

@property (strong) AVCaptureVideoPreviewLayer* layer;

@end

@implementation NBRView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        [self setupCaptureSession];
    }
    return self;
}

- (void)setupCaptureSession
{
    NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    NSParameterAssert(devices.count > 0);
    
    AVCaptureDevice* device;
    
    for (AVCaptureDevice* cameraDevice in devices)
    {
        if (cameraDevice.position == AVCaptureDevicePositionBack)
        {
            device = cameraDevice;
            break;
        }
    }
    NSParameterAssert(device != nil);
    
    NSError* inputError;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&inputError];
    NSParameterAssert(inputError == nil);
    
    AVCaptureSession* session = [AVCaptureSession new];
//    [session canAddInput:input];
    [session addInput:input];
    self.layer.session = session;
    
//    [session startRunning];
}

- (void)startRunning
{
    if (!self.layer.session.isRunning)
    {
        [self.layer.session startRunning];
    }
}

- (void)stopRunning
{
    if (self.layer.session.isRunning)
    {
        [self.layer.session stopRunning];
    }
}

@end
