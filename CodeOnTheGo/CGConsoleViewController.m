//
//  CGConsoleViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 22/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "CGConsoleViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface CGConsoleViewController ()

@property (nonatomic, strong) UITextView *inputView;

@end

@implementation CGConsoleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"Demo"];

    CGSize screenSize = self.view.bounds.size;

    self.inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height / 2)];
    [self.inputView setBackgroundColor:[UIColor blackColor]];
    [self.inputView setTextColor:[UIColor whiteColor]];

    UIButton *executeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [executeButton setTitle:@"Run!" forState:UIControlStateNormal];
    [executeButton setFrame:CGRectMake(200, 200, 100, 50)];
    [executeButton addTarget:self action:@selector(executeJS) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.inputView];
    [self.view addSubview:executeButton];
}

- (void)executeJS
{
    JSContext *context = [[JSContext alloc] init];
    JSValue *result = [context evaluateScript:self.inputView.text];

     NSLog(@"script output = %d", [result toInt32]);
}


@end
