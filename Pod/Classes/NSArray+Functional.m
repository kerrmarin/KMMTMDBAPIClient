//
//  NSArray+Functional.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

/**
 *  Applies a given block to each element of a list, returning a list of results.
 *
 *  @param block the block to apply to each member of the array,
 *  that will return another object
 *
 *  @return another array with (usually) different values
 */
-(instancetype)kmm_map:(id(^)(id obj))block {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for (id o in self) {
        id on = block(o);
        if (!on) {
            NSLog(@"NSArray::map() - object returned by block is nil!");
            abort();
        }
        [array addObject:on];
    }
    return [array copy];
}

@end
