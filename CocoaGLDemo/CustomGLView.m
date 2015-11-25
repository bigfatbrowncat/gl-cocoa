//
//  CustomGLView.m
//  CocoaGLDemo
//
//  Created by Ilya Mizus on 25/11/15.
//  Copyright (c) 2015 Ilya Mizus. All rights reserved.
//

#include <OpenGL/gl.h>

#import "CustomGLView.h"

static NSOpenGLContext* createGLContext() {
    CGLError error;
    
    CGLPixelFormatAttribute pixelAttrs[] = {
        kCGLPFADoubleBuffer,
        kCGLPFAOpenGLProfile, (int) kCGLOGLPVersion_3_2_Core,
        kCGLPFAColorSize, 24,
        kCGLPFAAlphaSize, 8,
        kCGLPFADepthSize, 24,
        kCGLPFAStencilSize, 8,
        kCGLPFASampleBuffers, 0,
        0,
    };
    
    int ignore;
    CGLPixelFormatObj pixelFormat;
    error = CGLChoosePixelFormat(pixelAttrs, &pixelFormat, &ignore);
    assert(!error);
    assert(pixelFormat);
    
    CGLContextObj context;
    error = CGLCreateContext(pixelFormat, NULL, &context);
    assert(!error);
    assert(context);
    
    return [[NSOpenGLContext alloc] initWithCGLContextObj:context];
}

@implementation CustomGLView

- (id)init {
    self = [super init];
    if (self != nil) {
        [self setOpenGLContext:createGLContext()];
        [self setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    }
    return self;
}

- (NSOpenGLContext*) openGLContext {
    if (_openGLContext == nil) {
        _openGLContext = createGLContext();
    }
    return _openGLContext;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self != nil) {
        [self setOpenGLContext:createGLContext()];
        _pixelFormat   = [[NSOpenGLPixelFormat alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_surfaceNeedsUpdate:)
                                                     name:NSViewGlobalFrameDidChangeNotification
                                                   object:self];
        [self setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frameRect pixelFormat:(NSOpenGLPixelFormat*)format
{
    self = [super initWithFrame:frameRect];
    if (self != nil) {
        [self setOpenGLContext:createGLContext()];
                _pixelFormat   = format;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_surfaceNeedsUpdate:)
                                                     name:NSViewGlobalFrameDidChangeNotification
                                                   object:self];
        [self setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    }
    return self;
}

- (void) _surfaceNeedsUpdate:(NSNotification*)notification
{
    [self update];
}

- (void)prepareOpenGL {
   
}

- (void)update {
    
}

- (void)lockFocus
{
    NSOpenGLContext* context = [self openGLContext];
    
    [super lockFocus];
    if ([context view] != self) {
        [context setView:self];
    }
    [context makeCurrentContext];
}

-(void) drawRect:(NSRect)bounds
{
    printf("b: %f, %f\n", bounds.size.width, bounds.size.height);
    [_openGLContext update];
    [_openGLContext makeCurrentContext];
    //Perform drawing here
    glOrtho(0, 1, 1, 0, -1, 1);
    glViewport(0, 0, 100, 200);
    glClearColor(0.f, 0.4f, 0.5f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    [_openGLContext flushBuffer];
}

-(void) viewDidMoveToWindow
{
    /*[super viewDidMoveToWindow];
    if ([self window] == nil)
        [_openGLContext clearDrawable];*/
}




@end
