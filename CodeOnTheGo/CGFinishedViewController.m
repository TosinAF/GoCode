//
//  CGFinishedViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 23/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "CGFinishedViewController.h"

@interface CGFinishedViewController ()

@end

@implementation CGFinishedViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    CGSize screen = self.view.bounds.size;

    UILabel *trophy = [[UILabel alloc] initWithFrame:CGRectMake(screen.width/2-60, 90, screen.width, (screen.height - 420))];
    [trophy setText:@"\ue805"];
    [trophy setTextColor:[UIColor colorWithRed:255/255.0f green:179/255.0f blue:20/255.0f alpha:1.0f]];
    trophy.font = [UIFont fontWithName:@"fontello" size:140];
    [self.view addSubview:trophy];

    UILabel *congratsText = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, screen.width, (screen.height - 470))];
    [congratsText setText:@"Congratulations !"];
    [congratsText setTextColor:[UIColor colorWithRed:7/255.0f green:115/255.0f blue:255/255.0f alpha:1.0f]];
    congratsText.font = [UIFont fontWithName:@"Hanging Letters" size:45];
    [self.view addSubview:congratsText];


    UILabel *messageText = [[UILabel alloc] initWithFrame:CGRectMake(20, 290, screen.width, (screen.height - 470))];
    messageText.numberOfLines = 0;
    [messageText setText:@"You have successfully finished this lesson  :P "];
    [messageText setTextColor:[UIColor colorWithRed:7/255.0f green:115/255.0f blue:255/255.0f alpha:1.0f]];
    messageText.font = [UIFont fontWithName:@"Montserrat" size:12];

    [self.view addSubview:messageText];

    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    //Implement method when you press the Next Button

    [nextButton addTarget:self action:@selector(nextLevel) forControlEvents:UIControlEventTouchDown];
    [nextButton setTitle:@"Next Lesson" forState:UIControlStateNormal];
    nextButton.frame = CGRectMake(180,screen.height-60, 160.0, 40.0);
    [self.view addSubview: nextButton];
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    //Implement method when you press the Next Button

    [homeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchDown];
    [homeButton setTitle:@"Home" forState:UIControlStateNormal];
    homeButton.frame = CGRectMake(-40,screen.height-60, 160.0, 40.0);
    [self.view addSubview: homeButton];
}

- (void)nextLevel
{
    UIViewController *lessonPicker = [[self.navigationController viewControllers] objectAtIndex:1];
    [self.navigationController popToViewController:lessonPicker animated:YES];
}

- (void)home
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
