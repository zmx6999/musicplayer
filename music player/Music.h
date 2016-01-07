//
//  Music.h
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *lrcname;

@property (nonatomic, copy) NSString *singer;

@property (nonatomic, copy) NSString *singerIcon;

@property (nonatomic, copy) NSString *icon;

+ (instancetype)musicWithDict:(NSDictionary *)dict;

+ (NSArray *)songs;

@end
