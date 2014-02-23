//
//  CGProfileViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 23/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "CGProfileViewController.h"
#import "ILTranslucentView.h"
#import <QuartzCore/QuartzCore.h> //you need QuartzCore

@interface CGProfileViewController ()

@property (nonatomic, strong)UIImage *Myimage;


@end


@implementation CGProfileViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bkImage2.jpg"]];
    //[self.tableView setSeparatorColor:[UIColor clearColor]];
    //[self.tableView setUserInteractionEnabled:NO];

    CGSize screen = self.view.bounds.size;
    //[self.tableView setContentOffset:CGPointMake(0, 10)];

    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, -20, 650, 650)];
    [self.view addSubview:translucentView]; //that's it :)

    //optional:
    translucentView.translucentAlpha = 0.8;
    translucentView.translucentStyle = UIBarStyleDefault;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];

    //UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(40, 200, 280, 192)];



    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(screen.width/2-50, screen.height/2 -200, 100, 97)];
    imgView.layer.cornerRadius =  imgView.frame.size.height /2;
    imgView.layer.masksToBounds = YES;
    imgView.layer.borderWidth = 1;
    UIImage *image = [UIImage imageNamed:@"chow2.jpg"];
    imgView.image = image;
    // optional:
    // [imageHolder sizeToFit];
    [self.view addSubview:imgView];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.width/2-57, screen.height/2 -120, screen.width, (screen.height - 470))];
    [nameLabel setText:@"Leslie Chow"];
    nameLabel.font = [UIFont fontWithName:@"Montserrat" size:19];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:nameLabel];

    UIView *HzlineView = [[UIView alloc] initWithFrame:CGRectMake(30, 260, self.view.bounds.size.width-60, 1)];
    HzlineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:HzlineView];


    UIView *VrlineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, 260, 1, 50)];
    VrlineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:VrlineView];


    UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.width/2-115, screen.height/2 - 35, screen.width, (screen.height - 470))];
    [rateLabel setText:@"\uE804 \uE804 \uE804 \uE804 \uE805"];
    [rateLabel setTextColor:[UIColor colorWithRed:0.851 green:0.565 blue:0.012 alpha:1]];
    rateLabel.font = [UIFont fontWithName:@"icons" size:14];
    [self.view addSubview:rateLabel];


    UILabel *locationSolLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.width/2-75, screen.height/2 - 95, screen.width, (screen.height - 470))];
    [locationSolLabel setText:@"DETROIT, U.S   ||   5 Solutions"];
    locationSolLabel.font = [UIFont fontWithName:@"Montserrat" size:10];
    [self.view addSubview:locationSolLabel];


    UILabel *repLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.width/2-115, screen.height/2 - 55, screen.width, (screen.height - 470))];
    [repLabel setText:@"REPUTATION"];
    repLabel.font = [UIFont fontWithName:@"Montserrat" size:13];
    [repLabel setTextColor:[UIColor blackColor] ];
    [self.view addSubview:repLabel];


    UILabel *followerLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, screen.height/2 - 55, screen.width, (screen.height - 470))];
    [followerLabel setText:@"FOLLOWERS"];
    followerLabel.font = [UIFont fontWithName:@"Montserrat" size:13];
    [followerLabel setTextColor:[UIColor blackColor] ];
    [self.view addSubview:followerLabel];


    UILabel *followerValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, screen.height/2 - 35, screen.width, (screen.height - 470))];
    [followerValueLabel setText:@"        599"];
    followerValueLabel.font = [UIFont fontWithName:@"Montserrat" size:13];
    [followerValueLabel setTextColor:[UIColor blackColor] ];
    [self.view addSubview:followerValueLabel];


    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 470, screen.width/2, (screen.height - 470))];
    [messageLabel setText:@"      \ue806 "];
    [messageLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:122/255.0f blue:71/255.0f alpha:1.0f]];
    [messageLabel setTextColor:[UIColor whiteColor] ];
    messageLabel.font = [UIFont fontWithName:@"icons" size:34];
    [self.view addSubview:messageLabel];


    UILabel *chatLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 470, screen.width/2, (screen.height - 470))];
    [chatLabel setText:@"       \ue807 "];
    [chatLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:56/255.0f blue:122/255.0f alpha:1.0f]];
    [chatLabel setTextColor:[UIColor whiteColor] ];
    chatLabel.font = [UIFont fontWithName:@"icons" size:34];
    [self.view addSubview:chatLabel];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(200, 10, screen.width/2, (screen.height - 470))];
    [closeButton setTitle:@"\ue803 " forState:UIControlStateNormal];
    [closeButton.titleLabel setTextColor:[UIColor whiteColor]];
    [closeButton.titleLabel setFont:[UIFont fontWithName:@"icons" size:25]];
    [closeButton addTarget:self action:@selector(dismissx) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
}

- (void)dismissx
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissProfileView" object:nil];
    NSLog(@"i reached");
}

@end
