//
//  ViewController.m
//  UITableView
//
//  Created by 朱毅成 on 15/10/30.
//  Copyright © 2015年 朱毅成. All rights reserved.
//

#import "ViewController.h"
//数据 两个类
#import "YCContact.h"
#import "YCContactGroup.h"

#define ycContactToolbarHeight 50

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_contacts;//联系人模型
    
    UIToolbar *toolbar;
    int _isInsert;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addToolbar];
    //初始化数据
    [self initData];
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, ycContactToolbarHeight+20, self.view.frame.size.width, self.view.frame.size.height-ycContactToolbarHeight) style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理（为了设置）
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
}

#pragma mark 加载数据
-(void)initData{
    _contacts=[[NSMutableArray alloc]init];
    
    YCContact *contact1=[YCContact initWithFirstName:@"Cui" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    YCContact *contact2=[YCContact initWithFirstName:@"Cui" andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    YCContactGroup *group1=[YCContactGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    [_contacts addObject:group1];
    
    
    
    YCContact *contact3=[YCContact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    YCContact *contact4=[YCContact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    YCContact *contact5=[YCContact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    YCContactGroup *group2=[YCContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    [_contacts addObject:group2];
    
    
    
    YCContact *contact6=[YCContact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    YCContact *contact7=[YCContact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];
    
    YCContactGroup *group3=[YCContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    [_contacts addObject:group3];
    
    
    YCContact *contact8=[YCContact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    YCContact *contact9=[YCContact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
    YCContact *contact10=[YCContact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
    YCContact *contact11=[YCContact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
    YCContact *contact12=[YCContact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
    YCContactGroup *group4=[YCContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    [_contacts addObject:group4];
    
    
    YCContact *contact13=[YCContact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    YCContact *contact14=[YCContact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    YCContact *contact15=[YCContact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    YCContactGroup *group5=[YCContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    [_contacts addObject:group5];
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"计算分组数");
    return _contacts.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"计算每组(组%ld)行数",section);
    YCContactGroup *group1=_contacts[section];
    return group1.contacts.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
//    NSLog(@"生成单元格(组：%ld,行%ld)",indexPath.section,indexPath.row);
    //取出 组
    YCContactGroup *group=_contacts[indexPath.section];
    //通过 组 取出 组员
    YCContact *contact=group.contacts[indexPath.row];
    //性能优化！
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    static NSString *cellIdentifierForFirstRow=@"UITableViewCellIdentifierKeyWithSwitch";
    //首先根据标示去缓存池取
    UITableViewCell *cell;
    if (indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifierForFirstRow];
        //bug解决步骤1 （一开始没有加载的页面加载时会用到之前的某个标识符进行重载,所以要判断开关状态）
        UISwitch *sw = (UISwitch *)cell.accessoryView;
        if (group.swState == 0) {
            sw.on = 0;
        }
        else{
            sw.on = 1;
        }
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        if (indexPath.row==0) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifierForFirstRow];
            UISwitch *sw=[[UISwitch alloc]init];
            [sw addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=sw;
            if (group.swState == 0) {
                sw.on = NO;
            }
        }else{
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDetailButton;
        }
    }
    //设置开关tag
    if(indexPath.row==0){
        ((UISwitch *)cell.accessoryView).tag=indexPath.section;
    }
    //设置cell的标签
    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text=contact.phoneNumber;
    //cell的装饰样式
//    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"生成组（组%ld）名称",section);
    YCContactGroup *group=_contacts[section];
    return group.name;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    NSLog(@"生成尾部（组%ld）详情",section);
    YCContactGroup *group=_contacts[section];
    return group.detail;
}

#pragma mark 返回每组标题索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSLog(@"生成组索引");
    NSMutableArray *indexs=[[NSMutableArray alloc]init];
    for(YCContactGroup *group in _contacts){
        [indexs addObject:group.name];
    }
    return indexs;
}

//设置行高
#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 50;
    }
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

//监听点击
#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YCContactGroup *group=_contacts[indexPath.section];
    YCContact *contact=group.contacts[indexPath.row];
    //创建弹出窗口(新版)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"System Info" message:[contact getName] preferredStyle:UIAlertControllerStyleAlert];
    //alert中间添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.text = contact.phoneNumber;
    }];
    //添加取消按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
    }]];
    //添加确定按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //获取文本框
        UITextField *textField= [alert textFields][0];
        //修改模型数据
        YCContactGroup *group=_contacts[indexPath.section];
        YCContact *contact=group.contacts[indexPath.row];
        contact.phoneNumber=textField.text;
        //刷新整个UITableView(实际开发中并不可取)
//        [_tableView reloadData];
        //局部刷新
        NSArray *indexPaths=@[indexPath];//需要局部刷新的单元格的组、行
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];//后面的参数代表更新时的动画(None,Fade,Automatic,Top,Left,Bottom,Right,Middle)
    }]];
    //显示弹出框
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark 重写状态样式方法
//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}
//
#pragma mark 切换开关转化事件
//bug:已解决(参考bug解决步骤1，2)
//如果有些UITableViewCell的UISwitch设置为on当其他控件重用时状态也是on，解决这个问题可以在模型中设置对应的属性记录其状态，在生成cell时设置当前状态（为了尽可能简化上面的代码这里就不再修复这个问题）；
-(void)switchValueChange:(UISwitch *)sw{
    //bug解决步骤2 （修改开关时，修改纪录开关状态的变量）
    YCContactGroup *group = _contacts[sw.tag];
    if (sw.isOn) {
        group.swState = 1;
    }
    else
    {
        group.swState = 0;
    }
    NSLog(@"section:%ld,switch:%i",sw.tag, sw.on);
}

//tableView学习 之 常用操作
#pragma mark 添加工具栏
-(void)addToolbar{
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, ycContactToolbarHeight)];
//    toolbar.backgroundColor=[UIColor colorWithHue:246/255.0 saturation:246/255.0 brightness:246/255.0 alpha:1];
    [self.view addSubview:toolbar];
    UIBarButtonItem *removeButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(remove)];
    //两个按钮之间，空开固定距离
    UIBarButtonItem *flexibleButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    NSArray *buttonArray=[NSArray arrayWithObjects:removeButton,flexibleButton,addButton, nil];
    toolbar.items=buttonArray;
}

#pragma mark 1.删除
-(void)remove{
    //直接通过下面的方法设置编辑状态没有动画
//    _tableView.editing=!_tableView.isEditing;
    _isInsert = 0;
    [_tableView setEditing:!_tableView.isEditing animated:true];
}

#pragma mark 2.添加
-(void)add{
    _isInsert = 1;
    [_tableView setEditing:!_tableView.isEditing animated:true];
}

#pragma mark 取得当前操作状态，根据不同的状态左侧出现不同的操作按钮
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isInsert) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

#pragma mark 1.删除操作 2.添加操作
//实现了此方法向左滑动就会显示删除按钮
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    YCContactGroup *group =_contacts[indexPath.section];
    YCContact *contact=group.contacts[indexPath.row];
    //删除的情况
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //MVC的思想，要修改UI先修改数据!!!!
        [group.contacts removeObject:contact];
        //考虑到性能这里不建议使用reloadData
        //[tableView reloadData];
        //使用下面的方法既可以局部刷新又有动画效果
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        //如果当前组中没有数据则移除组刷新整个表格
        if (group.contacts.count==0) {
            [_contacts removeObject:group];
            [tableView reloadData];
        }
    }
    //添加的情况
    else if(editingStyle==UITableViewCellEditingStyleInsert){
        YCContact *newContact=[[YCContact alloc]init];
        newContact.firstName=@"first";
        newContact.lastName=@"last";
        newContact.phoneNumber=@"12345678901";
        //先修改模型
        [group.contacts insertObject:newContact atIndex:indexPath.row];
        //再修改UI
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];//注意这里没有使用reloadData刷新,用insert...刷新
    }
}

#pragma mark 3.排序
//只要实现这个方法在编辑状态右侧就有排序图标
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    YCContactGroup *sourceGroup =_contacts[sourceIndexPath.section];
    YCContact *sourceContact=sourceGroup.contacts[sourceIndexPath.row];
    YCContactGroup *destinationGroup =_contacts[destinationIndexPath.section];
    
    [sourceGroup.contacts removeObject:sourceContact];
    //移除后添加，再判断是否空重新reloadData－－－这句必须放到if之前(否则bug),因为此方法不刷新tableView数据
    [destinationGroup.contacts insertObject:sourceContact atIndex:destinationIndexPath.row];
    if(sourceGroup.contacts.count==0){
        [_contacts removeObject:sourceGroup];
        [tableView reloadData];
    }
}

@end
