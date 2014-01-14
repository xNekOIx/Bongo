//
//  BNGViewController.h
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/8/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BNGViewController : UIViewController

/// An array of recognized AVMetadataMachineReadableCodeObject
@property (readonly) NSArray* lastReadedObjects;

/// An array of readable code types that should be recognized by barcode scanner
/// types are NSString keys available for AVMetadataMachineReadableCodeObject
/// e.g. AVMetadataObjectTypeUPCECode
@property (copy, nonatomic) NSArray* availableObjectTypes;
@property (assign) BOOL isInitializing;

+ (BOOL)canRecognizeBarcodes;
- (void)startScanning;
- (void)stopScanning;

@end
