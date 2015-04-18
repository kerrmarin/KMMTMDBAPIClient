//
//  KMMKeyword.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMKeyword.h"

@implementation KMMKeyword

-(instancetype)initWithKeywordID:(NSInteger)keywordID andName:(NSString *)name {
    
    if(self = [super init]) {
        _keywordID = keywordID;
        _name = [name copy];
    }
    return self;
}

@end


@implementation KMMKeywordParser

-(KMMKeyword *)keywordFromDictionary:(NSDictionary *)json {
    
    NSInteger keywordID = [json[@"id"] integerValue];
    NSString *name = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    
    KMMKeyword *keyword = [[KMMKeyword alloc] initWithKeywordID:keywordID andName:name];
    return keyword;
}


@end
