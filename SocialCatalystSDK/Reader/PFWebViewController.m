//
//  PFWebViewController.m
//  PFWebViewController
//
//  Created by Cee on 9/19/16.
//  Copyright © 2016 Cee. All rights reserved.
//

#import "PFWebViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <Appodeal/Appodeal.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface PFWebViewController () <WKNavigationDelegate,WKScriptMessageHandler> {
    BOOL isReaderMode;
    
    NSString *readerHTMLString;
    NSString *readerArticleTitle;
}

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *webMaskView;
@property (nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, strong) WKWebView *readerWebView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation PFWebViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Life Cycle

- (id)initWithURL:(NSURL *)url {
    
    self.offset = SCREENWIDTH < SCREENHEIGHT ? 20.f : 0.f;
    
    self = [super init];
    if (self) {
        self.url = url;
        self.progressBarColor = [UIColor blackColor];
    }
    return self;
}

- (id)initWithURLString:(NSString *)urlString {
    
    self.offset = SCREENWIDTH < SCREENHEIGHT ? 20.f : 0.f;
    
    self = [super init];
    if (self) {
        self.url = [NSURL URLWithString:urlString];
        self.progressBarColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [WebConsole enable];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.progressView];

    [self setupReaderMode];
    
    [self loadWebContent];
    
    [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];

}

- (void)loadWebContent {
    if (self.url) {
        [SVProgressHUD show];
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        return;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [SVProgressHUD dismiss];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.offset = SCREENWIDTH < SCREENHEIGHT ? 20.f : 0.f;
    
    self.webView.frame = CGRectMake(0, self.offset + 20.5f, SCREENWIDTH, SCREENHEIGHT - 50.5f - 20.5f - self.offset);
    self.progressView.frame = CGRectMake(0, 19 + 45 + self.offset, SCREENWIDTH, 2);
    
    self.webMaskView.frame = self.webView.frame;
    self.readerWebView.frame = self.webView.frame;
    self.maskLayer.frame = CGRectMake(0.0f, 0.0f, _readerWebView.frame.size.width, self.maskLayer.bounds.size.height);
}

#pragma mark - Lazy Initialize

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.offset + 20.5f, SCREENWIDTH, SCREENHEIGHT - 50.5f - 20.5f - self.offset) configuration:[self configuration]];
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.navigationDelegate = self;
        _webView.hidden = true;
    }
    return _webView;
}

- (UIView *)webMaskView {
    if (!_webMaskView) {
        _webMaskView = [[UIView alloc] initWithFrame:self.webView.frame];
        _webMaskView.backgroundColor = [UIColor clearColor];
        _webMaskView.userInteractionEnabled = NO;
    }
    return _webMaskView;
}

- (WKWebView *)readerWebView {
    if (!_readerWebView) {
        _readerWebView = [[WKWebView alloc] initWithFrame:self.webView.frame configuration:[self configuration]];
        _readerWebView.allowsBackForwardNavigationGestures = NO;
        _readerWebView.navigationDelegate = self;
        _readerWebView.userInteractionEnabled = NO;
        _readerWebView.layer.masksToBounds = YES;
    }
    return _readerWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, self.offset + 19.f, SCREENWIDTH, 2)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = self.progressBarColor;
    }
    return _progressView;
}

#pragma mark - Reader Mode

- (void)setupReaderMode {
    isReaderMode = NO;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.webMaskView];

    self.maskLayer = [CALayer layer];
    self.maskLayer.frame = CGRectMake(0.0f, 0.0f, self.readerWebView.frame.size.width, 0.0f);
    self.maskLayer.borderWidth = self.readerWebView.frame.size.height / 2.0f;
    self.maskLayer.anchorPoint = CGPointMake(0.5, 1.0f);
    
    [self.readerWebView.layer setMask:self.maskLayer];
    
    [self.view addSubview:self.readerWebView];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if ([change[NSKeyValueChangeNewKey] isKindOfClass:[NSNumber class]]) {
            [self progressChanged:change[NSKeyValueChangeNewKey]];
        }
    }
    
}

#pragma mark - Private

- (void)progressChanged:(NSNumber *)newValue {
    if (self.progressView.alpha == 0) {
        self.progressView.alpha = 1.f;
    }
    
    [self.progressView setProgress:newValue.floatValue animated:YES];
    
    if (self.progressView.progress == 1) {
        [UIView animateWithDuration:.5f animations:^{
            self.progressView.alpha = 0;
        } completion:^(BOOL finished) {
            self.progressView.progress = 0;
        }];
    } else if (self.progressView.alpha == 0){
        [UIView animateWithDuration:.1f animations:^{
            self.progressView.alpha = 1.f;
        }];
    }
}

- (WKWebViewConfiguration *)configuration {
    // Load reader mode js script
    NSBundle *bundle;
    if ( [NSBundle bundleWithIdentifier:@"ru.lwts.SocialCatalystSDK"] != nil) {
        bundle = [NSBundle bundleWithIdentifier:@"ru.lwts.SocialCatalystSDK"];
    } else {
        NSBundle *frameworkBundle = [NSBundle bundleForClass:self.class];
        NSURL *bundleURL = [frameworkBundle.resourceURL URLByAppendingPathComponent:@"SocialCatalyst.bundle"];
        bundle = [NSBundle bundleWithURL:bundleURL];
    }
    
    NSString *readerScriptFilePath = [bundle pathForResource:@"safari-reader" ofType:@"js"];
    NSString *readerCheckScriptFilePath = [bundle pathForResource:@"safari-reader-check" ofType:@"js"];
    
    NSString *indexPageFilePath = [bundle pathForResource:@"index" ofType:@"html"];
    
    // Load HTML for reader mode
    readerHTMLString = [[NSString alloc] initWithContentsOfFile:indexPageFilePath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *script = [[NSString alloc] initWithContentsOfFile:readerScriptFilePath encoding:NSUTF8StringEncoding error:nil];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    
    NSString *check_script = [[NSString alloc] initWithContentsOfFile:readerCheckScriptFilePath encoding:NSUTF8StringEncoding error:nil];
    WKUserScript *check_userScript = [[WKUserScript alloc] initWithSource:check_script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:userScript];
    [userContentController addUserScript:check_userScript];
    [userContentController addScriptMessageHandler:self name:@"JSController"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;

    return configuration;
}

- (void)webViewDidSwitchReaderModel:(BOOL) isAvailableFromHTML{
    isReaderMode = !isReaderMode;
    if (isAvailableFromHTML) {
        if (isReaderMode) {
            [_webView evaluateJavaScript:
              @"var ReaderArticleFinderJS = new ReaderArticleFinder(document);"
              "var article = ReaderArticleFinderJS.findArticle(); article.element.outerHTML" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
                  NSLog(@"object %@ %@", object, error);
                  if ([object isKindOfClass:[NSString class]] && self->isReaderMode) {
                      [self->_webView evaluateJavaScript:@"ReaderArticleFinderJS.articleTitle()" completionHandler:^(id _Nullable object_in, NSError * _Nullable error) {
                          self->readerArticleTitle = object_in;
                        
                          NSMutableString *mut_str = [self->readerHTMLString mutableCopy];
                        
                        // Replace page title with article title
                          [mut_str replaceOccurrencesOfString:@"Reader" withString:self->readerArticleTitle options:NSLiteralSearch range:NSMakeRange(0, 300)];
                        NSRange t = [mut_str rangeOfString:@"<div id=\"article\" role=\"article\">"];
                        NSInteger location = t.location + t.length;
                        
                        NSString *t_object = [NSString stringWithFormat:@"<div style=\"position: absolute; top: -999em; min-height: 999em\">%@</div>", object];
                        [mut_str insertString:t_object atIndex:location];
                        NSLog(@"done %@", mut_str);

                          [self->_readerWebView loadHTMLString:mut_str baseURL:nil];
                          self->_readerWebView.alpha = 0.0f;

                          [self->_webView evaluateJavaScript:@"ReaderArticleFinderJS.prepareToTransitionToReader();" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
                            NSLog(@"object %@ %@", object, error);

                        }];
                    }];
                }
            }];
        } else {
            [UIView animateWithDuration:0.2f animations:^{
                self.webMaskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
                self.maskLayer.frame = CGRectMake(0.0f, 0.0f, self->_readerWebView.frame.size.width, 0.0f);
            } completion:^(BOOL finished) {
                self->_readerWebView.userInteractionEnabled = NO;
            }];
        }
    } else {
        readerArticleTitle = _titleFromLink;
        
        NSMutableString *mut_str = [self->readerHTMLString mutableCopy];
        
        // Replace page title with article title
        [mut_str replaceOccurrencesOfString:@"Reader" withString:readerArticleTitle options:NSLiteralSearch range:NSMakeRange(0, 300)];
        NSRange t = [mut_str rangeOfString:@"<div id=\"article\" role=\"article\">"];
        NSInteger location = t.location + t.length;
        
        NSString *t_object = [NSString stringWithFormat:@"<div style=\"position: absolute; top: -999em; min-height: 999em\">%@</div>", _textFromLink];
        [mut_str insertString:t_object atIndex:location];
        NSLog(@"done %@", mut_str);
        
        [_readerWebView loadHTMLString:mut_str baseURL:nil];
        _readerWebView.alpha = 0.0f;
        [_webView evaluateJavaScript:@"var message = { 'code' : 0 }; window.webkit.messageHandlers.JSController.postMessage(message);" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
            NSLog(@"object %@ %@", object, error);
            
        }];
    }
}

#pragma mark - WKWebViewNavigationDelegate Methods

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    if ([webView isEqual:self.readerWebView]) {
        return;
    }
    
    if (![self.webView.URL.absoluteString isEqualToString:@"about:blank"]) {
        // Cache current url after every frame entering if not blank page
        self.url = self.webView.URL;
        isReaderMode = NO;
        
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    if (webView == _webView) {
        [SVProgressHUD dismiss];
        // Set reader mode button status when navigation finished
        [webView evaluateJavaScript:@"var ReaderArticleFinderJS = new ReaderArticleFinder(document); ReaderArticleFinderJS.isReaderModeAvailable();" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
            NSLog(@"object %@ %@", object, error);
            if ([object integerValue] == 1) {
                [self webViewDidSwitchReaderModel: true];
            } else {
                [self webViewDidSwitchReaderModel: false];
            }
        }];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView isEqual:self.readerWebView]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    if (![navigationAction.request.URL.absoluteString containsString:@"http://"] && ![navigationAction.request.URL.absoluteString containsString:@"https://"]) {
        
        UIApplication *application = [UIApplication sharedApplication];
#ifndef __IPHONE_10_0
#define __IPHONE_10_0  100000
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        [application openURL:navigationAction.request.URL options:@{} completionHandler:nil];
#else
        [application openURL:navigationAction.request.URL];
#endif
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    _readerWebView.alpha = 1.0f;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.webMaskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
            self.maskLayer.frame = CGRectMake(0.0f, 0.0f, self->_readerWebView.frame.size.width, self->_readerWebView.frame.size.height);
        } completion:^(BOOL finished) {
            self->_readerWebView.userInteractionEnabled = YES;
        }];
    });
    
}

@end
