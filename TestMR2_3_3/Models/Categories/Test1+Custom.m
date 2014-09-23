//
//  Test1+Custom.m
//  TestMR2_3_3
//
//  Created by Richard Wylie on 28/07/2014.
//  Copyright (c) 2014 sigmundfridge. All rights reserved.
//

#import "Test1+Custom.h"

@implementation Test1 (Custom)

-(NSString*)initial {
//    NSLog(@"Initial : %@", [self.lName substringToIndex:1]);
    return [self.fName substringToIndex:1];
}

@end
