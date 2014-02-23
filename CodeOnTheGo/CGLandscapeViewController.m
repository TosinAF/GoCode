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

BOOL challenge = NO;

@interface CGLandscapeViewController ()

@property (nonatomic, strong) UILabel *instructionLabel;
@property (nonatomic, strong) NLTextView *input;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NSMutableArray *log;

@property (nonatomic, strong) NSString *challengeStr;
@property (nonatomic, strong) NSString *answer;

@property (nonatomic, strong) UILabel *changeToLandscapeLabel;

@property (nonatomic, strong) UIButton *homeButton;
@property (nonatomic, strong) UIButton *executeButton;

@end

@implementation CGLandscapeViewController

- (id)initWithChallenge:(NSString *)challengeStr answer:(NSString *)answer
{
    self = [super init];

    if (self) {

        self.challengeStr = challengeStr;
        self.answer = answer;
        challenge = YES;

    }

    return self;
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

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    UIInterfaceOrientation devOrientation = self.interfaceOrientation;

    if (UIInterfaceOrientationLandscapeLeft == devOrientation || UIInterfaceOrientationLandscapeRight == devOrientation) {
        if (![self.changeToLandscapeLabel isHidden]) {
            [self.changeToLandscapeLabel removeFromSuperview];
            [self.homeButton removeFromSuperview];
        }
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self.view addSubview:self.instructionLabel];
        [self.view addSubview:self.input];
        [self.view addSubview:self.output];
        [self.view addSubview:self.executeButton];

    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.changeToLandscapeLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
        [self.changeToLandscapeLabel setText:@"Change To Landscape"];
        [self.changeToLandscapeLabel setTextColor:[UIColor colorWithRed:0.161 green:0.502 blue:0.725 alpha:1]];
        [self.changeToLandscapeLabel setBackgroundColor:[UIColor whiteColor]];
        [self.changeToLandscapeLabel setNumberOfLines:0];
        [self.changeToLandscapeLabel setTextAlignment:NSTextAlignmentCenter];
        [self.changeToLandscapeLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:40.0]];
        [self.view addSubview:self.changeToLandscapeLabel];

        self.homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.homeButton setFrame:CGRectMake(10, 30, 30, 30)];
        [self.homeButton setTitle:@"\uE808" forState:UIControlStateNormal];
        [self.homeButton.titleLabel setFont:[UIFont fontWithName:@"icons" size:25]];
        [self.homeButton setTitleColor:[UIColor colorWithRed:0.161 green:0.502 blue:0.725 alpha:1] forState:UIControlStateNormal];
        [self.homeButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.homeButton];

        if (![self.instructionLabel isHidden]) {
            [self.instructionLabel removeFromSuperview];
            [self.input resignFirstResponder];
            [self.input removeFromSuperview];
            [self.output removeFromSuperview];
            [self.executeButton removeFromSuperview];
        }
    }
}

- (void)goHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize screenSize = CGSizeMake(568, 320);
    [self.view setBackgroundColor:[UIColor whiteColor]];

    if (challenge) {
        self.instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, screenSize.width -20, 60)];
        [self.instructionLabel setText:self.challengeStr];
        [self.instructionLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:13.0]];
        [self.instructionLabel setNumberOfLines:0];
        [self.instructionLabel setTextColor:[UIColor blackColor]];
        self.input = [[NLTextView alloc] initWithFrame:CGRectMake(0, 60, screenSize.width, 150)];
    } else {
        self.input = [[NLTextView alloc] initWithFrame:CGRectMake(0, 30, screenSize.width, 150)];
    }



    self.output = [[UITextView alloc] initWithFrame:CGRectMake(0, 180, screenSize.width, 150)];
    [self.output setBackgroundColor:[UIColor colorWithRed:0.227 green:0.227 blue:0.235 alpha:1]];

    [self.input setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:17.0]];
    [self.input setUserInteractionEnabled:YES];
    [self.input setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.input setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.input setDelegate:self];

    [self.output setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:17.0]];
    [self.output setBackgroundColor:[UIColor colorWithRed:0.227 green:0.227 blue:0.235 alpha:1]];
    [self.output setTextColor:[UIColor colorWithRed:0.388 green:0.627 blue:0.424 alpha:1]];
    [self.output setEditable:NO];

    self.executeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.executeButton setTitle:@"Run" forState:UIControlStateNormal];
    [self.executeButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:15]];
    [self.executeButton setBackgroundColor:[UIColor colorWithRed:0.180 green:0.800 blue:0.443 alpha:1]];
    [self.executeButton setFrame:CGRectMake(490, 40, 70, 35)];
    [self.executeButton addTarget:self action:@selector(executeJS) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.executeButton];

    [self setupJSInterpreter];

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
    NSMutableString *output = [[NSMutableString alloc] initWithString:@""];

    if (![result isUndefined]) {
        [self output:[result toString]];
    }

    if ([self.log count]) {



        if (challenge && [[self.log firstObject] isEqualToString:self.answer ]) {
            [output appendString:[self.log firstObject]];
            [output appendString:@". Congratulations, you solved the challenge You have just gained 15 points."];
        } else {
            for (NSString *item in self.log) {
                [output appendString:item];
                [output appendString:@"\n"];
            }
        }

        [self.output setText:output];
        [self.log removeAllObjects];
        [self.view addSubview:self.output];
        [self.view endEditing:YES];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (![self.output isHidden]) {
        [self.output removeFromSuperview];
    }
    return YES;
}


- (void)canRotate { };

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
