//
//  CGConsoleViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 22/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "NLContext.h"
#import "CGConsoleViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface CGConsoleViewController ()

@property (nonatomic, strong) UITextView *inputView;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NSMutableArray *log;

@end

@implementation CGConsoleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* Set Up navbar in another function */

    [self setTitle:@"Demo"];

    /* Setup JS Stuff */
    self.context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    [NLContext attachToContext:self.context];

    self.log = [[NSMutableArray alloc] init];

    // Exception Handler
    __weak CGConsoleViewController *weakSelf = self;
    self.context.exceptionHandler = ^(JSContext *c, JSValue *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[weakSelf error:[e toString]];
            NSLog(@"%@ stack: %@", e, [e valueForProperty:@"stack"]);
        });
    };

    _context[@"console"] = @{@"log": ^(JSValue *thing) {
        [JSContext.currentArguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [weakSelf.log addObject:[obj toObject]];
        }];
    }};

    CGSize screenSize = self.view.bounds.size;

    self.inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height / 2)];
    [self.inputView setBackgroundColor:[UIColor blackColor]];
    [self.inputView setTextColor:[UIColor whiteColor]];
    self.inputView.delegate = self;

    UIButton *executeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [executeButton setTitle:@"Run!" forState:UIControlStateNormal];
    [executeButton setFrame:CGRectMake(200, 200, 100, 50)];
    [executeButton addTarget:self action:@selector(executeJS) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.inputView];
    [self.view addSubview:executeButton];
}

- (void)executeJS
{
    //JSContext *context = [[JSContext alloc] init];
    JSValue *result = [self.context evaluateScript:self.inputView.text];

    [NLContext runEventLoop];

    NSLog(@"%@", self.log);

    NSLog(@"script output = %d", [result toInt32]);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}



@end
