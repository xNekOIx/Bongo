//
//  BNGView.h
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/8/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BNGView : UIView

@property (strong, nonatomic) AVCaptureSession* session;

@end
