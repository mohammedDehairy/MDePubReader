//
//  MyWebView.h
//  MDePubReader
//
//  Created by Mohammed Eldehairy on 2/24/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface MyWebView : UIWebView
@property(nonatomic,retain)CALayer *AnimatedLayer;
@property(nonatomic,retain)CALayer *RightLayer;
@end
