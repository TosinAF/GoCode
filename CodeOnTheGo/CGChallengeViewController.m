//
//  CGChallengeViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 23/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "CGLandscapeViewController.h"
#import "CGChallengeViewController.h"

static NSString *cellIdentifier = @"CellIdentifier";

@interface CGChallengeViewController ()

@property (nonatomic,strong) NSArray *challenges;
@property (nonatomic,strong) NSArray *answers;
@property (nonatomic,strong) NSArray *titles;

@end

@implementation CGChallengeViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Pick a Challenge"];

    [self configureNavbarApperance];

    self.challenges = [[NSArray alloc] initWithObjects:@"How many numbers are divisble by 3 within the range of 1-100?", @"Write a function, calculateAge that takes arguments: birth year, current year. Call with arguements, 1994 & 2016", @"Write a fareheneit to celcius converter. Call with -40F.", nil];

    self.titles = [[NSArray alloc] initWithObjects:@"Divisble Numbers", @"Calcualte Ages", @"Farehenheit To Celcius", nil];

    self.answers = [[NSArray alloc] initWithObjects:@"33", @"22", @"-40", nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];

}

- (void)configureNavbarApperance
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.180 green:0.502 blue:0.714 alpha:1]];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	[[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName:[UIFont fontWithName:@"Montserrat" size:18.0f],
                                                            NSForegroundColorAttributeName:[UIColor whiteColor] }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.challenges count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGLandscapeViewController *landscapeViewController = [[CGLandscapeViewController alloc] initWithChallenge:[self.challenges objectAtIndex:[indexPath row]] answer:[self.answers objectAtIndex:[indexPath row]]];
    [self.navigationController pushViewController:landscapeViewController animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];

    [cell.textLabel setText:[self.titles objectAtIndex:[indexPath row]]];


    if ([indexPath row] == 0) {
        [cell.detailTextLabel setText:@"Hard"];
    }

    if ([indexPath row] == 1) {
        [cell.detailTextLabel setText:@"Easy"];
    }

    if ([indexPath row] == 2) {
        [cell.detailTextLabel setText:@"Medium"];
    }

    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15.0]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:10.0]];
    
    return cell;
}

@end
