//
//  HHChatViewController.m
//  HHChatView
//
//  Created by Sherlock on 2018/5/25.
//  Copyright © 2018 daHuiGe. All rights reserved.
//

#import "HHChatViewController.h"
#import "HHMessageModel.h"
#import "HHMessageCell.h"

@interface HHChatViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    int _index;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property(nonatomic,strong)NSMutableArray * messages;/** 消息模型  */

@end

@implementation HHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHMessageCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.textField.delegate = self;
    
    //设置文本框
    [self settingTextField];
    //接收通知
    [self addNotification];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)settingTextField
{
    //这个很苦逼,,它在iOS中就是用来占位的!!!
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 2)];
    leftView.backgroundColor = [UIColor clearColor];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = leftView;
    
    //设置文本输入框的代理
    self.textField.delegate = self;
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _index += 1;
    HHMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    cell.message = self.messages[indexPath.row];
    return cell;
}


#pragma mark - <UITableViewDelegate>
//估算高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_index) {
        [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    }
    HHMessageModel * message = self.messages[indexPath.row];
    return message.cellHeight;
}


//返回指定高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHMessageModel * message = self.messages[indexPath.row];
    return message.cellHeight;
}

//监听tableview的滚动!!
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark - <UITextFieldDelegate>

//监听到用户点击return
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //1 获取文字
    NSString * text = textField.text;
    //2 添加模型
    HHMessageModel * msg = [[HHMessageModel alloc]init];
    msg.text = text;
    msg.type = HHMessageTypeMe;
    
    //3 将模型添加到数组中
    [self.messages addObject:msg];
    
    NSInteger lastRow = self.messages.count - 1;
    
    NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    //手动创建cell
    [self tableView:self.tableView cellForRowAtIndexPath:lastIndexPath];
    //刷新数据
    //    [self.tableView reloadData];
    [self.tableView insertRowsAtIndexPaths:@[lastIndexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    // 滚动tableview到指定的Cell 的那个位置UITableViewScrollPositionBottom Cell的地底部
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    self.textField.text = nil;
    
    return YES;
}

//这个方法,当用户开始编辑就会来到这里..然后可以控制是否允许编辑
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//这个方法,当用户结束编辑就会来到这里..然后可以控制是否允许结束编辑
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - <Notification>
-(void)addNotification
{
    //注册通知 UIKeyboardWillChangeFrameNotification 键盘frame改变就通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotifacation:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)keyboardNotifacation:(NSNotification *)not
{
    //UIKeyboardFrameEndUserInfoKey
    //取出键盘弹出或者退出的frame
    CGRect frame = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat margin = frame.origin.y - self.view.frame.size.height;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    self.view.transform = CGAffineTransformMakeTranslation(0, margin);
}

#pragma mark - <Lazy Load>
-(NSMutableArray *)messages
{
    if (!_messages) {
        //加载plist
        NSString * path = [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray * arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * tempArr = [NSMutableArray array];
        //存放上一个模型
        HHMessageModel * lastMode = nil;
        for (NSDictionary * dict in arr) {
            HHMessageModel * message = [HHMessageModel messageWithDict:dict];
            message.hiddenTime = [message.time isEqualToString:lastMode.time];
            //储存上一次模型
            lastMode = message;
            [tempArr addObject:message];
        }
        _messages = tempArr ;
    }
    return _messages;
}


@end
