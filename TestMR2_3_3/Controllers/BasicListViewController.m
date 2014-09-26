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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TestViewController * testVC = segue.destinationViewController;
    testVC.delegate = self;
}

- (void)callBack
{
    //do bunch of things on background thread. Application logic
    NSManagedObjectContext *context = [NSManagedObjectContext MR_context];

    [context performBlock:^{
        NSPredicate *p = [NSPredicate predicateWithFormat:@"uuid == %@", @"1"];
        Test1 *test = [Test1 MR_findFirstWithPredicate:p inContext:context];

        if(test) {
            NSString *randomString = [BasicListViewController randomStringOfLength:10];
            test.fName = [NSString stringWithFormat:@"ChangedFirstName_%@", randomString];
            [context MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                [self.listingTableView reloadData];
            }];
        }
    }];
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
