//
//  KMMViewController.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 01/10/2015.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import "KMMViewController.h"

#import <KMMTMDBAPIClient/KMMTMDBAPIClient.h>

#import "UIImageView+AFNetworking.h"

@interface KMMViewController ()

@property(nonatomic, weak) IBOutlet UILabel *titleLabel;
@property(nonatomic, weak) IBOutlet UILabel *releaseDateLabel;
@property(nonatomic, weak) IBOutlet UILabel *popularityLabel;

@end

@implementation KMMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[KMMTMDBAPIClient client] fetchPopularMoviesInPage:1 complete:^(id results, NSError *error) {
        NSDictionary *firstMovie = results[@"results"][0];
        self.titleLabel.text = firstMovie[@"original_title"];
        self.releaseDateLabel.text = firstMovie[@"release_date"];
        self.popularityLabel.text = [@"Popularity: " stringByAppendingFormat: @"%f", [firstMovie[@"popularity"] doubleValue] ];
    }];
}

@end
