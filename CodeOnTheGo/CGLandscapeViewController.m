//
//  CGLandscapeViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 23/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "NLContext.h"
#import "NLTextView.h"
#import "CSNotificationView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CGLandscapeViewController.h"

@interface CGLandscapeViewController ()

@property (nonatomic, strong) UILabel *instructionLabel;
@property (nonatomic, strong) NLTextView *input;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NSMutableArray *log;

@property (nonatomic, strong) UIButton *nextButton;


@end

@implementation CGLandscapeViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.input becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:YES];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL) shouldAutorotate {
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGSize screenSize = self.view.bounds.size;

    [self configureNavbarApperance];
    //[self setupViews];

    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)) {

        self.instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, screenSize.width - 40, 100)];
        //[self.instructionLabel setText:@"What is the sound equal after the first if-statement is run?"];
        [self.instructionLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16.0]];
        [self.instructionLabel setNumberOfLines:0];
        [self.instructionLabel setBackgroundColor:[UIColor whiteColor]];
        [self.instructionLabel setTextColor:[UIColor blackColor]];

        self.input = [[NLTextView alloc] initWithFrame:CGRectMake(0, 140, screenSize.width, 212) textContainer:nil];
        [self.input setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:17.0]];
        //[self.input setBackgroundColor:[UIColor colorWithRed:0.169 green:0.169 blue:0.169 alpha:1]];
        //[self.input setTextColor:[UIColor whiteColor]];
        [self.input setUserInteractionEnabled:YES];
        [self.input setKeyboardAppearance:UIKeyboardAppearanceDark];
        [self.input setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self.input setDelegate:self];

        self.output = [[UITextView alloc] initWithFrame:CGRectMake(0, 352, screenSize.width, 216)];
        [self.output setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:17.0]];
        [self.output setBackgroundColor:[UIColor colorWithRed:0.227 green:0.227 blue:0.235 alpha:1]];
        [self.output setTextColor:[UIColor whiteColor]];
        [self.output setEditable:NO];

        UIView *underlay = [[UIView alloc] initWithFrame:CGRectMake(0, 352, screenSize.width, 216)];
        [underlay setBackgroundColor:[UIColor colorWithRed:0.169 green:0.169 blue:0.169 alpha:1]];

        [self.view addSubview:self.instructionLabel];
        [self.view addSubview:self.input];
        [self.view addSubview:underlay];
    } else {
        UILabel *changeToLandscapeLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
        [changeToLandscapeLabel setText:@"Change To Landscaper"];
        [changeToLandscapeLabel setBackgroundColor:[UIColor grayColor]];
        [changeToLandscapeLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:40.0]];
        [self.view addSubview:changeToLandscapeLabel];
        NSLog(@"Not reached");
    }

    [self setupJSInterpreter];

}

- (void)setupViews
{
    CGSize screenSize = self.view.bounds.size;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {


    } else {

    }
}

- (void)configureNavbarApperance
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.180 green:0.502 blue:0.714 alpha:1]];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	[[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName:[UIFont fontWithName:@"Montserrat" size:18.0f],
                                                            NSForegroundColorAttributeName:[UIColor whiteColor] }];

    UIButton *executeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [executeButton setFrame:CGRectMake(0, 0, 30, 30)];
    [executeButton setTitle:@"\uE801" forState:UIControlStateNormal];
    [executeButton.titleLabel setFont:[UIFont fontWithName:@"icons" size:25]];
    [executeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [executeButton addTarget:self action:@selector(executeJS) forControlEvents:UIControlEventTouchUpInside];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(0, 0, 30, 30)];
    [closeButton setTitle:@"\uE803" forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[UIFont fontWithName:@"icons" size:25]];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(dismissLesson) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:executeButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
}

- (void)dismissLesson
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupJSInterpreter
{
    self.log = [[NSMutableArray alloc] init];
    self.context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    [NLContext attachToContext:self.context];

    // Exception Handler
    __weak CGLandscapeViewController *weakSelf = self;
    _context.exceptionHandler = ^(JSContext *c, JSValue *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf error:[e toString]];
            NSLog(@"%@ stack: %@", e, [e valueForProperty:@"stack"]);
        });
    };

    _context[@"console"] = @{@"log": ^(JSValue *thing) {
        [JSContext.currentArguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [weakSelf.log addObject:[obj toString]];
        }];
    }};
}

- (void)executeJS
{
    JSValue *result = [self.context evaluateScript:self.input.text];
    [NLContext runEventLoopAsync];
    //NSMutableString *output = [[NSMutableString alloc] initWithString:@""];

    if (![result isUndefined]) {
        [self output:[result toString]];
    }

    if ([self.log count]) {

        /*for (NSString *item in self.log) {
         [output appendString:item];
         [output appendString:@"\n"];
         }*/
        NSMutableString *out = [[NSMutableString alloc] initWithString:[self.log firstObject]];
        [out appendString:@". Congrats. You got it right. Click on the next button to see even more."];
        [self.output setText:out];
        [self.log removeAllObjects];
        [self.view addSubview:self.output];
        [self.view addSubview:self.nextButton];
        [self.view endEditing:YES];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (![self.output isHidden]) {
        [self.output removeFromSuperview];
        [self.nextButton removeFromSuperview];
    }
    return YES;
}

- (void)output:(NSString *)message {
    [CSNotificationView showInViewController:self
                                       style:CSNotificationViewStyleSuccess
                                     message:message];
}

- (void)error:(NSString *)message {
    [CSNotificationView showInViewController:self
                                       style:CSNotificationViewStyleError
                                     message:message];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.input resignFirstResponder];
}



@end
