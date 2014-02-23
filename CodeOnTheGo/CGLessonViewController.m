//
//  CGLessonViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 22/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "NLContext.h"
#import "CSNotificationView.h"
#import "CGLessonViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface CGLessonViewController ()

@property (nonatomic, strong) UILabel *instructionLabel;
@property (nonatomic, strong) UITextView *input;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NSMutableArray *log;

@end

@implementation CGLessonViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.input becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setTitle:@"Lesson"];
    [self configureNavbarApperance];
    [self setupViews];

    [self setupJSInterpreter];

}

- (void)setupViews
{
    CGSize screenSize = self.view.bounds.size;

    self.instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, screenSize.width - 40, 100)];
    [self.instructionLabel setText:@"What is the sound equal after the first if-statement is run?"];
    [self.instructionLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16.0]];
    [self.instructionLabel setNumberOfLines:0];
    [self.instructionLabel setBackgroundColor:[UIColor whiteColor]];
    [self.instructionLabel setTextColor:[UIColor blackColor]];

    self.input = [[UITextView alloc] initWithFrame:CGRectMake(0, 140, screenSize.width, 212)];
    [self.input setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:17.0]];
    [self.input setBackgroundColor:[UIColor colorWithRed:0.169 green:0.169 blue:0.169 alpha:1]];
    [self.input setTextColor:[UIColor whiteColor]];
    [self.input setUserInteractionEnabled:YES];
    [self.input setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.input setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.input setDelegate:self];

    self.output = [[UITextView alloc] initWithFrame:CGRectMake(0, 352, screenSize.width, 216)];
    [self.output setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:17.0]];
    [self.output setBackgroundColor:[UIColor colorWithRed:0.227 green:0.227 blue:0.235 alpha:1]];
    [self.output setTextColor:[UIColor whiteColor]];
    [self.output setEditable:NO];

    [self.view addSubview:self.instructionLabel];
    [self.view addSubview:self.input];

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

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:executeButton];
}

- (void)setupJSInterpreter
{
    self.log = [[NSMutableArray alloc] init];
    self.context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    [NLContext attachToContext:self.context];

    // Exception Handler
    __weak CGLessonViewController *weakSelf = self;
    _context.exceptionHandler = ^(JSContext *c, JSValue *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf error:[e toString]];
            NSLog(@"%@ stack: %@", e, [e valueForProperty:@"stack"]);
        });
    };

    _context[@"console"] = @{@"log": ^(JSValue *thing) {
        [JSContext.currentArguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [weakSelf.log addObject:[obj toObject]];
        }];
    }};
}

- (void)executeJS
{
    //JSContext *context = [[JSContext alloc] init];
    JSValue *result = [self.context evaluateScript:self.input.text];
    [NLContext runEventLoop];

    if (![result isUndefined]) {
        [self output:[result toString]];
    }
    if ([self.log count]) {

        [self.output setText:[self.log firstObject]];
        NSLog(@"%@", self.log);
        [self.log removeAllObjects];
        [self.view addSubview:self.output];
        //[self resignFirstResponder];
        [self.view endEditing:YES];
    }


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
