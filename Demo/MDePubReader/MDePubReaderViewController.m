//
//  MDePubReaderViewController.m
//  MDePubReader
//
//  Created by Mohammed Eldehairy on 2/24/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "MDePubReaderViewController.h"

@interface MDePubReaderViewController ()

@end

@implementation MDePubReaderViewController
@synthesize _ePubContent;
@synthesize _rootPath;
@synthesize _strFileName;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self unzipAndSaveFile];
	_xmlHandler=[[XMLHandler alloc] init];
	_xmlHandler.delegate=self;
	[_xmlHandler parseXMLFileAt:[self getRootFilePath]];
    
    _webview.delegate = self;
   
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanHandler:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGesture];
    
    
}



//*************************************** Handle Pan Gesture Folding Animation ********************************
//************************************************************************************************************


-(void)PanHandler:(UIPanGestureRecognizer*)recognizer
{
    if(recognizer.state==UIGestureRecognizerStateBegan  )
    {
        didGetNextPage = NO;
       
        
        PanDirectionRight = [self getPanDirection:recognizer];
       

    }
    
    
    if(PanDirectionRight)
    {
        
        [self PanDirectionRight:recognizer];
    }else
    {
        
        [self PanDirectionLeft:recognizer];
    }
    if(recognizer.state==UIGestureRecognizerStateEnded)
    {
        
        
        _webview.layer.anchorPoint= CGPointMake(0, 0);
        _webview.layer.position = CGPointMake(0, 0);
        _webview.layer.transform = CATransform3DIdentity;
        
        
    }
}
-(BOOL)getPanDirection:(UIPanGestureRecognizer*)recognizer
{
    BOOL IsPanRight = NO;
     if([recognizer velocityInView:self.view].x<0)
    {
        IsPanRight = NO;
    }else if ([recognizer velocityInView:self.view].x>=0)
    {
        IsPanRight = YES;
    }
    return IsPanRight;
}
-(void)PanDirectionLeft:(UIPanGestureRecognizer*)recognizer
{
    _webview.AnimatedLayer.transform = CATransform3DIdentity;
    if(recognizer.state==UIGestureRecognizerStateChanged)
    {
        CGFloat i = ([recognizer translationInView:self.view].x);
        [self AnimateLayerToTheLeft:i];
        
    }
}
-(void)PanDirectionRight:(UIPanGestureRecognizer*)recognizer
{
    _webview.RightLayer.transform = CATransform3DIdentity;
    if(recognizer.state==UIGestureRecognizerStateChanged)
    {
        CGFloat i = ([recognizer translationInView:self.view].x);
       
        [self AnimateLayerToTheRight:i];
        
        
    }
}
-(void)AnimateLayerToTheLeft:(CGFloat)translate
{
    translate = translate<0?translate:-translate;
    
    
    CGFloat angle =  M_PI*1.2*(translate/self.view.frame.size.width);
    if(angle>=-(M_PI*0.5) )
    {
        
    
        [self AnimateLayerToTheLeftWithAngle:angle];
        
    }else
    {
       
        if(didGetNextPage==NO)
        {
            didGetNextPage = YES;
            [self GetNextPage];
        }
        
    }
}
-(void)AnimateLayerToTheLeftWithAngle:(CGFloat)angle
{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angle, 0.0f, 1.0f, 0.0f);
    _webview.layer.anchorPoint = CGPointMake(0.0, 0.0);
    _webview.layer.position = CGPointMake(0,0);
    _webview.layer.transform = rotationAndPerspectiveTransform;
}
-(void)AnimateLayerToTheRight:(CGFloat)translate
{
    
    
    CGFloat angle =  M_PI*2*(translate/self.view.frame.size.width);
    if(angle<=M_PI*0.5)
    {
        
   
        [self AnimateLayerTotheRightWithAngle:angle];
        
        
    }else
    {
        if(didGetNextPage==NO)
        {
            didGetNextPage = YES;
            [self GetPrePage];
        }
        
    }
}
-(void)AnimateLayerTotheRightWithAngle:(CGFloat)angle
{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angle, 0.0f, 1.0f, 0.0f);
    _webview.layer.anchorPoint = CGPointMake(1,0);
    _webview.layer.position = CGPointMake(self.view.frame.size.width,0);
    _webview.layer.transform = rotationAndPerspectiveTransform;
}
-(void)PrePageAction:(id)sender
{
    _webview.layer.anchorPoint = CGPointMake(1,0);
    _webview.layer.position = CGPointMake(self.view.frame.size.width,0);
    [UIView animateWithDuration:0.8 animations:^(void){
    
    
        [self AnimateLayerTotheRightWithAngle:M_PI*0.5];
    } completion:^(BOOL finished){
    
        [self GetPrePage];
        _webview.layer.transform = CATransform3DIdentity;
    
    }];
    
}
-(void)NextPageAction:(id)sender
{
    _webview.layer.anchorPoint = CGPointMake(0.0, 0.0);
    _webview.layer.position = CGPointMake(0,0);
    [UIView animateWithDuration:0.8 animations:^(void){
        
        
        [self AnimateLayerToTheLeftWithAngle:-(M_PI*0.5)];
    } completion:^(BOOL finished){
        
        [self GetNextPage];
        _webview.layer.transform = CATransform3DIdentity;
        
    }];
}
//************************************************************************************************************


-(void)GetNextPage
{
    int count = [self._ePubContent._spine count]-1;
    if (count>_pageNumber) {
        
        _pageNumber++;
        [self loadPage];
    }
}
-(void)GetPrePage
{
    if (_pageNumber>0) {
        
        _pageNumber--;
        [self loadPage];
    }
}
-(void)SwipLeftHandler:(UISwipeGestureRecognizer*)recognizer
{
    [self GetNextPage];
    
}
-(void)SwipRightHandler:(UISwipeGestureRecognizer*)recognizer
{
    [self GetPrePage];
}
- (void)unzipAndSaveFile{
	
	ZipArchive* za = [[ZipArchive alloc] init];
    BOOL UnZipOpen ;
    if(_FileInDocumentsDirectory==YES)
    {
        UnZipOpen =[za UnzipOpenFile:[NSString stringWithFormat:@"%@/%@",[self applicationDocumentsDirectory],_strFileName,nil]];
    }else
    {
        UnZipOpen = [za UnzipOpenFile:[[NSBundle mainBundle] pathForResource:_strFileName ofType:@"epub"]];
    }
    
    
	if( UnZipOpen ){
		
		NSString *strPath=[NSString stringWithFormat:@"%@/UnzippedEpub",[self applicationDocumentsDirectory]];
		//Delete all the previous files
		NSFileManager *filemanager=[[NSFileManager alloc] init];
		if ([filemanager fileExistsAtPath:strPath]) {
			
			NSError *error;
			[filemanager removeItemAtPath:strPath error:&error];
		}
		filemanager=nil;
		//start unzip
		BOOL ret = [za UnzipFileTo:[NSString stringWithFormat:@"%@/",strPath] overWrite:YES];
		if( NO==ret ){
			// error handler here
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
														  message:@"An unknown error occured"
														 delegate:self
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
			[alert show];
			
			alert=nil;
		}
		[za UnzipCloseFile];
	}
    za = nil;
}
- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}
- (NSString*)getRootFilePath{
	
	//check whether root file path exists
	NSFileManager *filemanager=[[NSFileManager alloc] init];
	NSString *strFilePath=[NSString stringWithFormat:@"%@/UnzippedEpub/META-INF/container.xml",[self applicationDocumentsDirectory]];
	if ([filemanager fileExistsAtPath:strFilePath]) {
		
		//valid ePub
		NSLog(@"Parse now");
		
		
		filemanager=nil;
		
		return strFilePath;
	}
	else {
		
		//Invalid ePub file
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
													  message:@"Root File not Valid"
													 delegate:self
											cancelButtonTitle:@"OK"
											otherButtonTitles:nil];
		[alert show];
		
		alert=nil;
		
	}
	
	filemanager=nil;
	return @"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark XMLHandler Delegate Methods

- (void)foundRootPath:(NSString*)rootPath{
	
	//Found the path of *.opf file
	
	//get the full path of opf file
	NSString *strOpfFilePath=[NSString stringWithFormat:@"%@/UnzippedEpub/%@",[self applicationDocumentsDirectory],rootPath];
	NSFileManager *filemanager=[[NSFileManager alloc] init];
	
	self._rootPath=[strOpfFilePath stringByReplacingOccurrencesOfString:[strOpfFilePath lastPathComponent] withString:@""];
	
	if ([filemanager fileExistsAtPath:strOpfFilePath]) {
		
		
		[_xmlHandler parseXMLFileAt:strOpfFilePath];
	}
	else {
		
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
													  message:@"OPF File not found"
													 delegate:self
											cancelButtonTitle:@"OK"
											otherButtonTitles:nil];
		[alert show];
		
		alert=nil;
	}
	
	filemanager=nil;
	
}

- (void)finishedParsing:(EpubContent*)ePubContents{
    
	_pagesPath=[NSString stringWithFormat:@"%@/%@",self._rootPath,[ePubContents._manifest valueForKey:[ePubContents._spine objectAtIndex:0]]];
	self._ePubContent=ePubContents;
	_pageNumber=0;
	[self loadPage];
}
- (void)loadPage{
	
	_pagesPath=[NSString stringWithFormat:@"%@/%@",self._rootPath,[self._ePubContent._manifest valueForKey:[self._ePubContent._spine objectAtIndex:_pageNumber]]];
	[_webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:_pagesPath]]];
    
    
    

}

@end
