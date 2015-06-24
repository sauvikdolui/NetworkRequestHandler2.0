//
//  ViewController.m
//  AFNetworking2.0
//
//  Created by Sauvik Dolui on 6/23/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkRequestHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [AFNetworkRequestHandler downloadFileDataFromURL:@"https://awesomewallpapers.files.wordpress.com/2015/06/autowallpaper_-200139.jpg" withCompletionBlock:^(NSData *data, NSError *error) {
        _imageView.image = [UIImage imageWithData:data];
    } andProgressBlock:^(float downloadProgressFraction) {
        NSLog(@"Download procgress = %f", downloadProgressFraction);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
