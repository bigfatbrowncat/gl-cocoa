//
//  CustomGLView.h
//  CocoaGLDemo
//
//  Created by Ilya Mizus on 25/11/15.
//  Copyright (c) 2015 Ilya Mizus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NSOpenGLContext, NSOpenGLPixelFormat;

@interface CustomGLView : NSView
{
@private
//    NSOpenGLContext*     _openGLContext;
//    NSOpenGLPixelFormat* _pixelFormat;
}

+ (NSOpenGLPixelFormat*)defaultPixelFormat;
- (id)initWithFrame:(NSRect)frameRect pixelFormat:(NSOpenGLPixelFormat*)format;
- (void)clearGLContext;
- (void)prepareOpenGL;
- (void)update;
@property NSOpenGLPixelFormat* pixelFormat;
@property NSOpenGLContext*     openGLContext;

@end