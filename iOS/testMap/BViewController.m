//
//  BViewController.m
//  testMap
//
//  Created by vp on 2017/3/23.
//  Copyright © 2017年 wp. All rights reserved.
//

#import "BViewController.h"
#import "NetWorkData.h"
#import <ArcGIS/ArcGIS.h>
@interface BViewController ()
@property (strong, nonatomic)AGSMapView *mapView;
@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor yellowColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mapView=[NetWorkData shareData].mapView;
        self.mapView.frame=CGRectMake(0, 64, 375, [UIScreen mainScreen].bounds.size.height-64);
        [self.view addSubview:self.mapView];
    });
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{

    NSLog(@"5555");
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
