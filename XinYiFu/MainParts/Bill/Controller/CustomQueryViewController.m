//
//  CustomQueryViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CustomQueryViewController.h"
#import "IncomeRecordHeadCell.h"
#import "IncomeRecordContentCell.h"

@interface CustomQueryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *backTableView;
@property (nonatomic ,assign) BOOL getResult;

@property (nonatomic ,strong) UITextField *startTime;
@property (nonatomic ,strong) NSDate *startDate;
@property (nonatomic ,strong) UITextField *endTime;
@property (nonatomic ,strong) NSDate *endDate;
@property (nonatomic ,strong) UITextField *chooseTF;

@property (nonatomic ,strong) UIView *datePickerBackView;
@property (nonatomic ,strong) UIDatePicker *datePicker;
@property (nonatomic ,strong) NSDate *lastDate;
@end

@implementation CustomQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义查询";
    [self prepareViews];
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = ThemeColor;
    self.backTableView.separatorStyle = NO;
    [self.view addSubview:self.backTableView];
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.getResult+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [self createTimeCellWithTitle:@"开始时间"];
            if (!self.startTime) {
                self.startTime = [UITextField textFieldWithPlaceHolder:@"选择日期"];
                self.startTime.font = [UIFont systemFontOfSize:16.f];
                self.startTime.enabled = NO;
            }
            [cell.contentView addSubview:self.startTime];
            [self.startTime mas_makeConstraints:^(MASConstraintMaker *make){
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(100);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-30);
            }];
            return cell;
        }else if (indexPath.row == 1) {
            UITableViewCell *cell = [self createTimeCellWithTitle:@"截止时间"];
            if (!self.endTime) {
                self.endTime = [UITextField textFieldWithPlaceHolder:@"选择日期"];
                self.endTime.font = [UIFont systemFontOfSize:16.f];
                self.endTime.enabled = NO;
            }
            [cell.contentView addSubview:self.endTime];
            [self.endTime mas_makeConstraints:^(MASConstraintMaker *make){
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(100);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-30);
            }];
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            UILabel *button = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#F04D1A"] font:18 aligment:NSTextAlignmentCenter];
            button.text = @"查询";
            [cell.contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make){
                make.center.mas_equalTo(cell);
            }];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            return [IncomeRecordHeadCell cellWithTableView:tableView indexPath:indexPath count:@"2" total:@"￥23.00"];
        }else {
            return [IncomeRecordContentCell cellWithTableView:tableView indexPath:indexPath name:@"2018-12-1" time:@"收款笔数：1" money:@"￥20.00"];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.chooseTF = self.startTime;
            [self createDatePickerView];
        }else if(indexPath.row == 1) {
            self.chooseTF = self.endTime;
            [self createDatePickerView];
        }else if (indexPath.row == 2) {
            if ([self.endDate compare:self.startDate] >= 0) {
                self.getResult = YES;
                [tableView reloadData];
            }else{
                [SVProgressHUD showInfoWithStatus:@"截止时间需晚于开始时间"];
                [SVProgressHUD dismissWithDelay:2];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        if (indexPath.row == 0) {
            return 86.f;
        }
        return 66.f;
    }
}

- (UITableViewCell *)createTimeCellWithTitle:(NSString *)titleName{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel *title = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    title.text = titleName;
    [cell.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *segLine = [[UILabel alloc] init];
    segLine.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [cell.contentView addSubview:segLine];
    [segLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.mas_equalTo(0);
        make.right.mas_equalTo(cell.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = NO;
    return cell;
}

- (void)createDatePickerView{
    self.datePickerBackView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    self.datePickerBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIApplication sharedApplication].keyWindow.frame) - 170, CGRectGetWidth(self.view.frame), 170)];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    if (self.lastDate) {
        [self.datePicker setDate:self.lastDate];
    }else{
        [self.datePicker setDate:[NSDate date] animated:YES];
    }
    [self.datePicker setMaximumDate:[NSDate date]];
    [self.datePickerBackView addSubview:self.datePicker];
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.backgroundColor = [UIColor whiteColor];
    [self.datePickerBackView addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *cancel = [UIButton buttonWithTitle:@"取消" font:16 titleColor:WordCloseBlack backGroundColor:nil aligment:0];
    [cancel addTarget:self action:@selector(closeDatePickerView:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(40);
    }];
    
    UIButton *sure = [UIButton buttonWithTitle:@"确定" font:16 titleColor:WordCloseBlack backGroundColor:nil aligment:0];
    [sure addTarget:self action:@selector(submitTime:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:sure];
    [sure mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(toolBar.mas_right).offset(-20);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(40);
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.datePickerBackView];
}

- (void)closeDatePickerView:(id)sender{
    [self.datePickerBackView removeFromSuperview];
}

- (void)submitTime:(id)sender{
    self.lastDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    self.chooseTF.text = [dateFormat stringFromDate:self.datePicker.date];
    if (self.chooseTF == self.startTime) {
        self.startDate = self.datePicker.date;
    }else{
        self.endDate = self.datePicker.date;
    }
    [self.datePickerBackView removeFromSuperview];
}


- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
