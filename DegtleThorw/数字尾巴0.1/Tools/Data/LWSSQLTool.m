//
//  LWSSQLTool.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

/**
 
 数据库还需要研究
 
 */

#import "LWSSQLTool.h"
#import "FMDB.h"

#define SQLCREATE @"create table if not exists collection (id integer primary key , title text , url text , summary text , type integer);"
#define SQLSELECTALL @"select * from collection"
#define SQLINSERT @"insert into collection (title , url , summary , type) values ('%@' , '%@' , '%@', '%ld')", title , url , summary , type
#define SQLDELETE @"delete from collection where title = %@",title
#define SQLSELECTbyTitle @"select * from collection where title = '%@'",model.title
#define SQLDELETEALL @"delete from collection"

static FMDatabase *db;
static NSString *path;

@implementation LWSSQLTool

/**只在第一次使用时会调用的方法 */
+ (void)initialize{
    path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"collection.sqlite"];
    db = [FMDatabase databaseWithPath:filePath];
    [db open];
    /**id integer primary key创建自增一的id */
    NSString *sqlCreate = SQLCREATE;
    /**fmdb执行除查询外全部操作使用的语句 */
    [db executeUpdate:sqlCreate];
    [db close];
}

+ (NSMutableArray *)selectCollection:(NSString *)SQLselect{
    [db open];
    FMResultSet *results;
    if (![SQLselect isEqualToString:@""]) {
        results = [db executeQuery:SQLselect];
    }
    else
    results = [db executeQuery:SQLSELECTALL];
    
    NSMutableArray *array = [NSMutableArray array];
    while ([results next]) {
        LWSSQLModel *model = [[LWSSQLModel alloc]init];
        model.title = [results stringForColumn:@"title"];
        model.summary = [results stringForColumn:@"summary"];
        model.type = [results intForColumn:@"type"];
        model.url = [results stringForColumn:@"url"];
        [array addObject:model];
    }
    [db close];
    return array;
}

+ (void)insertCollectionWithModel:(LWSSQLModel *)model{
    if ([LWSSQLTool selectCollection:[NSString stringWithFormat:SQLSELECTbyTitle]].count == 0) {
        [db open];
        NSString *title = model.title;
        NSString *url = model.url;
        NSString *summary = model.summary;
        NSInteger type = model.type;
        [db executeUpdate:[NSString stringWithFormat:SQLINSERT]];
        [db close];

    }
    else{
        NSLog(@"已经添加过了");
    }
}

+ (void)deleteCollectionAllItems{
    [db open];
    [db executeUpdateWithFormat:SQLDELETEALL];
    [db close];
}

+ (void)deleteCollectionWithTitle:(NSString *)title{
    [db open];
    [db executeUpdateWithFormat:SQLDELETE];
    [db close];
}

@end
