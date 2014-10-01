//
//  BasicListViewController.m
//  TestMR2_3_3
//
//  Created by Richard Wylie on 28/07/2014.
//  Copyright (c) 2014 sigmundfridge. All rights reserved.
//

#import "BasicListViewController.h"
#import "Test1.h"
#import "TestViewController.h"

@interface BasicListViewController ()

@property(nonatomic, strong) NSFetchedResultsController *frc;

@end

@implementation BasicListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    NSManagedObjectContext *context = [NSManagedObjectContext MR_context];
    
    [context performBlock:^{
        Test1 *output = [Test1 MR_createEntityInContext:context];
        NSString *fNameStr = [BasicListViewController randomStringOfLength:10];
        output.fName = fNameStr;
        [context MR_saveToPersistentStoreWithCompletion:NULL];
    }];
    
    [self updateFRC];
    
}

- (void) viewDidAppear:(BOOL)animated {
}

- (void)updateFRC {
    NSLog(@"Start: Loading First (Grouped) FRC");
    self.frc = [Test1 MR_fetchAllGroupedBy:@"initial" withPredicate:nil sortedBy:@"fName" ascending:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger rows = [self.frc.sections[section] numberOfObjects];
    return rows;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.frc.sections.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Test1 *item = [self.frc objectAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    return [item.fName substringToIndex:1];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Test1 *item = [self.frc objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basic"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"basic"];
    }
    cell.textLabel.text = item.fName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


+(NSString*)randomStringOfLength:(int)length {
    static NSString *letters = @"abcdefghijlmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *string = [NSMutableString stringWithCapacity:length];
    for(int i=0;i<length;i++) {
        [string appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return string;
}

@end
