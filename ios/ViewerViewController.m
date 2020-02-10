//
//  ViewerViewController.m
//  TecateAr
//
//  Created by MacBook on 2/7/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "ViewerViewController.h"

@interface ViewerViewController ()

@end

@implementation ViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button1 = [[UIButton alloc] init];
    [button1 setTitle: @"BUTTON 1" forState: UIControlStateNormal];
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setTitle: @"BUTTON 2" forState: UIControlStateNormal];
    UIButton *button3 = [[UIButton alloc] init];
    [button3 setTitle: @"BUTTON 3" forState: UIControlStateNormal];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"CABRRLLON";
    
    UIStackView *stack = [[UIStackView alloc] init];
    stack.axis = UILayoutConstraintAxisVertical;
    [stack addArrangedSubview:button1];
    [stack addArrangedSubview:button2];
    [stack addArrangedSubview:button3];
    
    [stack addArrangedSubview:label];
    stack.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:stack];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    // Objective-C
    [NSLayoutConstraint activateConstraints: @[
        [stack.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [stack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
        // ... more constraints ...
     ]
    ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
