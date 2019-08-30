//
//  ViewController.m
//  ObserverTable
//
//  Created by Jion on 2017/7/19.
//  Copyright © 2017年 天天. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)pushNextVC:(id)sender {
    TableViewController *table = [[TableViewController alloc] init];
//    TableViewController *table = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TableViewController"];
    [self.navigationController pushViewController:table animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
