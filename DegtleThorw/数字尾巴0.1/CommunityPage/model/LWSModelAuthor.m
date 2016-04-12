//
//  LWSModelAuthor.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelAuthor.h"

@implementation LWSModelAuthor

- (instancetype)initWithName:(NSString *)name ForunUrl:(NSString *)forunUrl CollectionUrl:(NSString *)collectionUrl{
    self = [super init];
    if (self) {
        self.name = name;
        self.forunUrl = forunUrl;
        self.collectionUrl = collectionUrl;
    }
    return self;
}

+ (instancetype)modelAuthorWithName:(NSString *)name ForunUrl:(NSString *)forunUrl CollectionUrl:(NSString *)collectionUrl{
    return [[super alloc] initWithName:name ForunUrl:forunUrl CollectionUrl:collectionUrl];
}



@end
