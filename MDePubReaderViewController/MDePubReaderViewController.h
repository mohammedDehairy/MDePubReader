//
//  MDePubReaderViewController.h
//  MDePubReader
//
//  Created by Mohammed Eldehairy on 2/24/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLHandler.h"
#import "EpubContent.h"
#import "ZipArchive.h"
#import <QuartzCore/QuartzCore.h>
#import "MyWebView.h"


@interface MDePubReaderViewController : UIViewController<XMLHandlerDelegate,UIWebViewDelegate>
{
    IBOutlet UIImageView *LeftImageView;
    IBOutlet UIImageView *RightImageView;
    IBOutlet MyWebView *_webview;
    XMLHandler *_xmlHandler;
	EpubContent *_ePubContent;
	NSString *_pagesPath;
	NSString *_rootPath;
	NSString *_strFileName;
	int _pageNumber;
    BOOL didGetNextPage;
    BOOL PanDirectionRight;
}
@property (nonatomic)BOOL FileInDocumentsDirectory;
@property (nonatomic, retain)EpubContent *_ePubContent;
@property (nonatomic, retain)NSString *_rootPath;
@property (nonatomic, retain)NSString *_strFileName;
-(IBAction)NextPageAction:(id)sender;
-(IBAction)PrePageAction:(id)sender;
@end
