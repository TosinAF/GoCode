//
//  CGTableViewController.m
//  CodeOnTheGo
//
//  Created by Tosin Afolabi on 23/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "CGTableViewController.h"

static NSString *cellIdentifier = @"CellIdentifier";

@interface CGTableViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation CGTableViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Pick a Lessson"];

    [self configureNavbarApperance];

    self.data = [[NSArray alloc] initWithObjects:@"Getting Started", @"Data Types", @"Variables", @"Comparisons", @"If.. Else...", nil];
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
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    [cell.textLabel setText:[self.data objectAtIndex:[indexPath row]]];

    UIProgressView *progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    progress.frame = CGRectMake(0, 44, self.view.bounds.size.width, 30);
    [progress setProgressTintColor:[UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1]];


    if ([indexPath row] == 0) {
        progress.progress = 0.65;
    }

    if ([indexPath row] % 3 == 1) {
        [cell.detailTextLabel setText:@"Hard"];
    } else if ([indexPath row] % 3 == 2) {
        [cell.detailTextLabel setText:@"Medium"];
    } else {
        [cell.detailTextLabel setText:@"Easy"];
    }

    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15.0]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:10.0]];

    [cell.contentView addSubview:progress];

    return cell;
}

@end
