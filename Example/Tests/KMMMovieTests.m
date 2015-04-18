//
//  KMMMovieTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 18/04/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface KMMMovieTests : XCTestCase

@end

@implementation KMMMovieTests

- (void)testValidParsing {
    id validJSON = @{@"adult":@false,
                     @"backdrop_path":@"/hNFMawyNDWZKKHU4GYCBz1krsRM.jpg",
                     @"belongs_to_collection":[NSNull null],
                     @"budget":@63000000,
                     @"genres":
                         @[
                             @{@"id":@18, @"name":@"Drama"}
                             ],
                     @"homepage":@"",
                     @"id":@550,
                     @"imdb_id":@"tt0137523",
                     @"original_title":@"Fight Club",
                     @"overview":@"A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
                     @"popularity":@"4.20745311089828",
                     @"poster_path":@"/hpt3aa5i0TrSAnEdl3VJrRrje8C.jpg",
                     @"production_companies":@[
                             @{@"name":@"20th Century Fox",@"id":@25},
                             @{@"name":@"Fox 2000 Pictures",@"id":@711},
                             @{@"name":@"Regency Enterprises",@"id":@508}
                             ],
                     @"production_countries":@[
                             @{@"iso_3166_1":@"DE",@"name":@"Germany"},
                             @{@"iso_3166_1":@"US",@"name":@"United States of America"}
                             ],
                     @"release_date":@"1999-10-14",
                     @"revenue":@100853753,
                     @"runtime":@139,
                     @"spoken_languages":@[
                             @{@"iso_639_1":@"en",
                               @"name":@"English"}
                             ],
                     @"status":@"Released",
                     @"tagline":@"How much can you know about yourself if you've never been in a fight?",
                     @"title":@"Fight Club",
                     @"vote_average":@7.7,
                     @"vote_count":@3093,
                     @"alternative_titles":@{@"titles":@[
                                                     @{@"iso_3166_1":@"PL",
                                                       @"title":@"Podziemny krąg"},
                                                     @{@"iso_3166_1":@"TW",
                                                       @"title":@"鬥陣俱樂部"},
                                                     @{@"iso_3166_1":@"HU",
                                                       @"title":@"Harcosok klubja"},
                                                     @{@"iso_3166_1":@"BR",
                                                       @"title":@"Clube da Luta"}
                                                     ]
                                             },
                     @"videos":@{@"results":@[
                                         @{@"id":@"533ec654c3a36854480003eb",
                                           @"iso_639_1":@"en",
                                           @"key":@"SUXWAEX2jlg",
                                           @"name":@"Trailer 1",
                                           @"site":@"YouTube",
                                           @"size":@720,
                                           @"type":@"Trailer"}
                                         ]
                                 },
                     @"credits":@{
                             @"cast":@[
                                     @{@"cast_id":@4,
                                       @"character":@"The Narrator",
                                       @"credit_id":@"52fe4250c3a36847f80149f3",
                                       @"id":@819,
                                       @"name":@"Edward Norton",
                                       @"order":[NSNumber numberWithInt:0],
                                       @"profile_path":@"/iUiePUAQKN4GY6jorH9m23cbVli.jpg"},
                                     @{@"cast_id":@5,
                                       @"character":@"Tyler Durden",
                                       @"credit_id":@"52fe4250c3a36847f80149f7",
                                       @"id":@287,
                                       @"name":@"Brad Pitt",
                                       @"order":@1,
                                       @"profile_path":@"/2xrLcP4YRakx8aAc2jdwRbctr0Y.jpg"}
                                     ],
                             @"crew":@[
                                     @{@"credit_id":@"52fe4250c3a36847f8014a0b",
                                       @"department":@"Production",
                                       @"id":@7475,
                                       @"job":@"Producer",
                                       @"name":@"Ceán Chaffin",
                                       @"profile_path":[NSNull null]},
                                     @{@"credit_id":@"52fe4250c3a36847f8014a11",
                                       @"department":@"Production",
                                       @"id":@1254,
                                       @"job":@"Producer",
                                       @"name":@"Art Linson",
                                       @"profile_path":@"/dEtVivCXxQBtIzmJcUNupT1AB4H.jpg"}
                                     ]
                             },
                     @"images":@{@"backdrops":@[
                                         @{@"aspect_ratio":@"1.77777777777778",
                                           @"file_path":@"/hNFMawyNDWZKKHU4GYCBz1krsRM.jpg",
                                           @"height":@720,
                                           @"iso_639_1":@"xx",
                                           @"vote_average":@"5.52154195011338",
                                           @"vote_count":@21,
                                           @"width":@1280},
                                         @{@"aspect_ratio":@"1.77777777777778",
                                           @"file_path":@"/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg",
                                           @"height":@720,
                                           @"iso_639_1":@"en",
                                           @"vote_average":@"5.43977591036415",
                                           @"vote_count":@22,
                                           @"width":@1280}
                                         ],
                                 @"posters":@[
                                         @{@"aspect_ratio":@"0.666666666666667",
                                           @"file_path":@"/hpt3aa5i0TrSAnEdl3VJrRrje8C.jpg",
                                           @"height":@1500,
                                           @"id":@"517fd4c6760ee31cd5d7820f",
                                           @"iso_639_1":@"en",
                                           @"vote_average":@"5.48906048906049",
                                           @"vote_count":@11,
                                           @"width":@1000},
                                         @{@"aspect_ratio":@"0.666666666666667",
                                           @"file_path":@"/2lECpi35Hnbpa4y46JX0aY3AWTy.jpg",
                                           @"height":@1500,
                                           @"id":@"4ea5cc8334f8633bdc000a59",
                                           @"iso_639_1":@"en",
                                           @"vote_average":@"5.47800799709197",
                                           @"vote_count":@68,
                                           @"width":@1000}
                                         ]
                                 },
                     @"keywords":@{@"keywords":@[
                                           @{@"id":@397,
                                             @"name":@"bare knuckle boxing"},
                                           @{@"id":@825,
                                             @"name":@"support group"},
                                           @{@"id":@851,
                                             @"name":@"dual identity"},
                                           @{@"id":@1541,
                                             @"name":@"nihilism"},
                                           @{@"id":@3848,
                                             @"name":@"support"},
                                           @{@"id":@3927,
                                             @"name":@"rage and hate"},
                                           @{@"id":@4142,
                                             @"name":@"insomnia"},
                                           @{@"id":@11250,
                                             @"name":@"boxing"},
                                           @{@"id":@17977,
                                             @"name":@"underground fighting"}
                                           ]
                                   },
                     @"releases":@{@"countries":@[
                                           @{@"iso_3166_1":@"US",
                                             @"certification":@"R",
                                             @"release_date":@"1999-10-14"},
                                           @{@"iso_3166_1":@"DE",
                                             @"certification":@"18",
                                             @"release_date":@"1999-11-10"},
                                           @{@"iso_3166_1":@"GB",
                                             @"certification":@"18",
                                             @"release_date":@"1999-11-12"},
                                           @{@"iso_3166_1":@"FR",
                                             @"certification":@"16",
                                             @"release_date":@"1999-11-10"},
                                           @{@"iso_3166_1":@"TR",
                                             @"certification":@"",
                                             @"release_date":@"1999-12-10"}
                                           ]
                                   },
                     @"similar":@{@"page":@1,
                                  @"results":@[
                                          @{@"adult":@false,
                                            @"backdrop_path":@"/5X0l0G0S95iTzJMptyIMZO80XNS.jpg",
                                            @"id":@54833,
                                            @"original_title":@"The Big Man",
                                            @"release_date":@"1991-08-09",
                                            @"poster_path":@"/v2RAbH8HJuLdMYnwC9RAFx08aeU.jpg",
                                            @"popularity":@"0.209660090867616",
                                            @"title":@"The Big Man",
                                            @"vote_average":@10.0,
                                            @"vote_count":@10},
                                          @{@"adult":@false,
                                            @"backdrop_path":@"/v3gnNqCUu3WGaN931bDaCsmjElr.jpg",
                                            @"id":@16825,
                                            @"original_title":@"La coda dello scorpione",
                                            @"release_date":@"1971-08-16",
                                            @"poster_path":@"/ejihDlbPT7nx9P9FiUaIsdUjcBq.jpg",
                                            @"popularity":@"0.596505040621643",
                                            @"title":@"The Case of the Scorpion's Tail",
                                            @"vote_average":@7.3,
                                            @"vote_count":@4}],
                                  @"total_pages":@1,
                                  @"total_results":@3},
                     @"reviews":@{@"page":@1,
                                  @"results":@[],
                                  @"total_pages":@1,
                                  @"total_results":@1
                                  }
                     };
//    KMMMovieParser *parser = [KMMMovieParser new];
//    KMMMovie *movie = [parser parseMovieFromJSON:validJSON];
//    XCTAssertNotNil(movie);
}


@end
