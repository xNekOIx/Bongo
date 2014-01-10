//
//  BNGView.m
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/8/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import "BNGView.h"

@interface BNGView ()

@property (strong, nonatomic) AVCaptureVideoPreviewLayer* layer;

@end

@implementation BNGView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return self;
}

- (void)setSession:(AVCaptureSession *)session
{
    if (session == self.layer.session) return;
    
    self.layer.session = session;
}

- (AVCaptureSession *)session
{
    return self.layer.session;
}

@end
