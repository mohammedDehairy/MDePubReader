//
//  MyWebView.m
//  MDePubReader
//
//  Created by Mohammed Eldehairy on 2/24/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "MyWebView.h"

@implementation MyWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _AnimatedLayer = [CALayer layer];
        _AnimatedLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [[self layer] addSublayer:_AnimatedLayer];
        
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        _AnimatedLayer = [CALayer layer];
        _AnimatedLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [[self layer] addSublayer:_AnimatedLayer];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
}*/


@end
