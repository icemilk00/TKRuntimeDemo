//
//  TKMainViewController.m
//  TKRuntimeDemo
//
//  Created by hp on 15/8/11.
//  Copyright (c) 2015年 hxp. All rights reserved.
//

#import "TKMainViewController.h"
#import "TKSceondViewController.h"

@interface TKMainViewController ()

@end

@implementation TKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupPushButton];
}


-(void)setupPushButton
{
    if (!_pushButton) {
        self.pushButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 100.0f, 50.0f, 20.0f)];
        [_pushButton setTitle:@"next" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pushButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_pushButton];
    }
}

-(void)pushButtonClicked:(UIButton *)sender
{
    TKSceondViewController *nextViewController = [[TKSceondViewController alloc] init];
    [self.navigationController pushViewController:nextViewController animated:YES];
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
