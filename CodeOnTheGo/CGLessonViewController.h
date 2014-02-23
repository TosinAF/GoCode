//
//  CGLessonViewController.h
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 22/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGLessonViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) UILabel *instructionLabel;
@property (nonatomic, strong) NLTextView *input;
@property (nonatomic, strong) UITextView *output;

@end
