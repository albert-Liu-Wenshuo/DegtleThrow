//
//  LWSSQLUser.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSSQLUser.h"

#import "FMDB.h"

#define SQLCREATE @"create table if not exists user (id integer primary key , name text , password text , email text );"
#define SQLSELECTALL @"select * from user"
#define SQLINSERT @"insert into user (name , password , email ) values ('%@' , '%@' , '%@')", name, password , email
#define SQLDELETE @"delete from user where name = %@",name
#define SQLSELECTbyNANE @"select * from user where name = '%@'", name
#define SQLDELETEALL @"delete from user"

static FMDatabase *db;
static NSString *path;

@implementation LWSSQLUser

/**只在第一次使用时会调用的方法 */
+ (void)initialize{
    path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"user.sqlite"];
    db = [FMDatabase databaseWithPath:filePath];
    [db open];
    /**id integer primary key创建自增一的id */
    NSString *sqlCreate = SQLCREATE;
    /**fmdb执行除查询外全部操作使用的语句 */
    [db executeUpdate:sqlCreate];
    [db close];
}

+ (NSMutableArray *)selectUserByName:(NSString *)name{
    [db open];
    FMResultSet *results;
    if (name) {
        results = [db executeQuery:[NSString stringWithFormat:SQLSELECTbyNANE]];
    }
    else
        results = [db executeQuery:SQLSELECTALL];
    
    NSMutableArray *array = [NSMutableArray array];
    while ([results next]) {
        LWSUserModel *model = [[LWSUserModel alloc]init];
        model.name = [results stringForColumn:@"name"];
        model.password = [results stringForColumn:@"password"];
        model.email = [results stringForColumn:@"email"];
        [array addObject:model];
    }
    [db close];
    return array;
}

+ (BOOL)insertUserWithModel:(LWSUserModel *)model{
    NSString *name = model.name;
    if ([LWSSQLUser selectUserByName:name].count == 0) {
        [db open];
        NSString *name = model.name;
        NSString *password = model.password;
        NSString *email = model.email;
        NSLog(@"%@",path);
        [db executeUpdate:[NSString stringWithFormat:SQLINSERT]];
        [db close];
        return YES;
    }
    else
        return NO;
}

+ (void)deleteUserAllItems{
    [db open];
    [db executeUpdateWithFormat:SQLDELETEALL];
    [db close];
}

+ (void)deleteUserWithName:(NSString *)name{
    [db open];
    [db executeUpdateWithFormat:SQLDELETE];
    [db close];
}


@end
