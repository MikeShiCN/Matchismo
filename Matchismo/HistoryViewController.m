//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Yuan Shi on 2017/8/20.
//  Copyright © 2017年 Mike Yuan Shi. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateMyTextViewUsingArrayToBeShown];
    // Do any additional setup after loading the view.
}

- (void)updateMyTextViewUsingArrayToBeShown {
    if (!self.arrayToBeShown) {
        return;
    }
    
    NSString * text = [self.arrayToBeShown componentsJoinedByString:@"\n"];
    self.historyTextView.text = text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
