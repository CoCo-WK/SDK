//
//  YCContact.h
//  UITableView
//
//  Created by 朱毅成 on 15/10/30.
//  Copyright © 2015年 朱毅成. All rights reserved.
//

//新增联系人
#import <Foundation/Foundation.h>

@interface YCContact : NSObject

#pragma mark 姓
@property (nonatomic,strong) NSString *firstName;
#pragma mark 名
@property (nonatomic,strong) NSString *lastName;
#pragma mark 手机号码
@property (nonatomic,strong) NSString *phoneNumber;

#pragma mark 带参数的构造函数
-(YCContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber;

#pragma mark 取得姓名
-(NSString *)getName;


#pragma mark 带参数的静态对象初始化方法
+(YCContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber;

@end
