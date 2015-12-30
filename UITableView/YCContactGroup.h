//
//  YCContactGroup.h
//  UITableView
//
//  Created by 朱毅成 on 15/10/30.
//  Copyright © 2015年 朱毅成. All rights reserved.
//

//联系人群组
#import <Foundation/Foundation.h>

#import "YCContact.h"

@interface YCContactGroup : NSObject

#pragma mark 组名
@property (nonatomic,strong) NSString *name;

#pragma mark 分组描述
@property (nonatomic,strong) NSString *detail;

#pragma mark 开关状态
@property (nonatomic,assign) int swState;

#pragma mark 联系人
@property (nonatomic,strong) NSMutableArray *contacts;

#pragma mark 带参数个构造函数
-(YCContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

#pragma mark 静态初始化方法
+(YCContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

@end
