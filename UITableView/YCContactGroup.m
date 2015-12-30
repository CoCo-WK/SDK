//
//  YCContactGroup.m
//  UITableView
//
//  Created by 朱毅成 on 15/10/30.
//  Copyright © 2015年 朱毅成. All rights reserved.
//

#import "YCContactGroup.h"

@implementation YCContactGroup


-(YCContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts{
    if (self=[super init]) {
        self.name=name;
        self.detail=detail;
        self.contacts=contacts;
        self.swState = 0;
    }
    return self;
}

+(YCContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts{
    YCContactGroup *group1=[[YCContactGroup alloc]initWithName:name andDetail:detail andContacts:contacts];
    return group1;
}
@end
