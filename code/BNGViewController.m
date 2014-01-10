//
//  BNGViewController.m
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/8/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import "BNGViewController.h"
#import "BNGView.h"

@interface BNGViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong) BNGView* view;
@property (strong) AVCaptureMetadataOutput* output;
@property (strong) AVCaptureSession* session;
@property (readwrite) NSArray* lastReadedObjects;

@end

@implementation BNGViewController
@synthesize lastReadedObjects = _lastReadedObjects;

+ (BOOL)canRecognizeBarcodes
{
    if (UIDevice.currentDevice.systemVersion.floatValue < 7.0) return NO;
    
    NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if (devices.count == 0) return NO;
    
    AVCaptureDevice* device;
    
    for (AVCaptureDevice* cameraDevice in devices)
    {
        if (cameraDevice.position == AVCaptureDevicePositionBack)
        {
            device = cameraDevice;
            break;
        }
    }
    
    if (device == nil) return NO;
    
    NSError* inputError;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&inputError];
    NSAssert(inputError == nil, @"An error occurred while try get AVCaptureDeviceInput: %@", inputError);
    if (inputError != nil) return NO;
    
    AVCaptureSession* session = [AVCaptureSession new];
    if (![session canAddInput:input]) return NO;
    
    return YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupLayerSession];
    }
    return self;
}

- (void)setupLayerSession
{
    NSAssert(UIDevice.currentDevice.systemVersion.floatValue >= 7.0, @"Works only for iOS 7 or later");
    
    NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    NSAssert(devices.count > 0, @"There are no device that can capture video input installed on this device");
    
    AVCaptureDevice* device;
    
    for (AVCaptureDevice* cameraDevice in devices)
    {
        if (cameraDevice.position == AVCaptureDevicePositionBack)
        {
            device = cameraDevice;
            if ([device hasTorch] && [device isTorchModeSupported:AVCaptureTorchModeAuto])
            {
                NSError *error = nil;
                if ([device lockForConfiguration:&error])
                {
                    device.torchMode = AVCaptureTorchModeAuto;
                    [device unlockForConfiguration];
                }
                NSAssert(error == nil, @"lock for configuration failed with error: %@", error);
            }
            break;
        }
    }
    NSAssert(device != nil, @"There is no back camera available on this device");
    
    NSError* inputError;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&inputError];
    NSAssert(inputError == nil, @"An error occurred while try get AVCaptureDeviceInput: %@", inputError);
    
    AVCaptureSession* session = [AVCaptureSession new];
    NSAssert([session canAddInput:input], @"Can't add camera device input to session");
    _session = session;
    [session addInput:input];
    
    AVCaptureMetadataOutput* output = [AVCaptureMetadataOutput new];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.metadataObjectTypes = nil;
    NSAssert([session canAddOutput:output], @"Can't add barcode recognition media output");
    _output = output;
    [session addOutput:output];
}

- (void)loadView
{
    self.view = [BNGView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSParameterAssert(self.session != nil);
    self.view.session = self.session;
}

- (void)startScanning
{
    [self.view.session startRunning];
}

- (void)stopScanning
{
    [self.view.session stopRunning];
}

- (void)setAvailableObjectTypes:(NSArray *)availableObjectTypes
{
    NSSet* availableOutputObjectTypes = [NSSet setWithArray:self.output.availableMetadataObjectTypes];
    NSSet* filterObjectTypes = [NSSet setWithArray:availableObjectTypes];
    NSAssert([filterObjectTypes isSubsetOfSet:availableOutputObjectTypes], @"There are object types that can't be handled");
    
    if ([availableObjectTypes isEqualToArray:self.output.metadataObjectTypes]) return;
    
    [self.session beginConfiguration];
    self.output.metadataObjectTypes = availableObjectTypes;
    [self.session commitConfiguration];
}

- (NSArray *)availableObjectTypes
{
    return self.output.availableMetadataObjectTypes;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    self.lastReadedObjects = [metadataObjects copy];
}

@end
