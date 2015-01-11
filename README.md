# KMMTMDBAPIClient

[![CI Status](http://img.shields.io/travis/kerrmarin/KMMTMDBAPIClient.svg?style=flat)](https://travis-ci.org/Kerr Marin Miller/KMMTMDBAPIClient)
[![Version](https://img.shields.io/cocoapods/v/KMMTMDBAPIClient.svg?style=flat)](http://cocoadocs.org/docsets/KMMTMDBAPIClient)
[![License](https://img.shields.io/cocoapods/l/KMMTMDBAPIClient.svg?style=flat)](http://cocoadocs.org/docsets/KMMTMDBAPIClient)
[![Platform](https://img.shields.io/cocoapods/p/KMMTMDBAPIClient.svg?style=flat)](http://cocoadocs.org/docsets/KMMTMDBAPIClient)

## Features

A TMDB API client that allows users to easily query movie and cast information.

  - Get movie details, including similar movies.
  - Get cast details.
  - Get company details.
  - Search for cast and crew.
  - Search for movies.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

This project has a dependency on AFNetworking.

Other requirements: 

- iOS 7.0 or greater
- ARC

## Installation

KMMTMDBAPIClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "KMMTMDBAPIClient"

## Examples

In your app delegate, set your API key:

**Code:**

```objc

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[KMMTMDBAPIClient client] setAPIKey:@"MY API KEY"];
    return YES;
}

```

In your view controller, query the API:

**Code:**

```objc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[KMMTMDBAPIClient client] fetchPopularMoviesInPage:1 complete:^(id results, NSError *error) {
        NSDictionary *firstMovie = results[@"results"][0];
        self.titleLabel.text = firstMovie[@"original_title"];
        self.releaseDateLabel.text = firstMovie[@"release_date"];
        self.popularityLabel.text = [@"Popularity: " stringByAppendingFormat: @"%f", [firstMovie[@"popularity"] doubleValue] ];
    }];
}


```


## Author

KMMTMDBAPIClient was developed by Kerr Marin Miller (@kerrmarin) in the development of Dejavu.

## License

KMMTMDBAPIClient is available under the MIT license. See the LICENSE file for more info.

