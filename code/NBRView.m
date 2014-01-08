//
//  NBRView.m
//  NativeBarcodeRecognizer
//
//  Created by Kostya Bychkov on 1/8/14.
//  Copyright (c) 2014 NekOI. All rights reserved.
//

#import "NBRView.h"

@implementation NBRView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

@end
