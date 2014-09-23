//
//  TestViewController.h
//  TestMR2_3_3
//
//  Created by HIMANSHU RETAREKAR on 23/09/14.
//  Copyright (c) 2014 sigmundfridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestViewControllerDelegate <NSObject>

- (void) callBack;
@end

@interface TestViewController : UIViewController
- (IBAction)doneButtonClicked:(id)sender;

@property (assign, atomic) id<TestViewControllerDelegate> delegate;
@end
