//
//  KKViewController.m
//  KKCategories
//
//  Created by v_ljqliang on 09/04/2020.
//  Copyright (c) 2020 v_ljqliang. All rights reserved.
//

#import "KKViewController.h"
#import <NSArray+KK.h>

@interface KKViewController ()

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray <NSNumber *>*list = @[@(1),@(3),@(2),@(4)].mutableCopy;
    
    [list quickSort:^BOOL(NSNumber *element1, NSNumber *element2) {
        return element1.intValue > element2.intValue;
    }];
    
    NSLog(@"%@",list);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
