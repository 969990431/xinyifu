//
//  AddressPickerView.m
//  XinYiFu
//
//  Created by apple on 2019/1/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AddressPickerView.h"

@interface AddressPickerView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) id<AddressViewDelegate>delegate;
@property (nonatomic ,strong) UITableView *tableViewOne;

@property (nonatomic ,strong) NSString *currPro;

@property (nonatomic ,strong) NSMutableDictionary *dataDict;
@property (nonatomic ,assign) NSInteger buttonTag;

@property (nonatomic ,assign) BOOL complete;
@end

@implementation AddressPickerView


+ (void)showWithData:(NSArray *)array delegate:(nonnull id<AddressViewDelegate>)delegate{
    AddressPickerView *view = [[AddressPickerView alloc]init];
    [view.dataDict setObject:array forKey:@"10001"];
    [view.tableViewOne reloadData];
    view.delegate = delegate;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (id)init{
    if (self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        self.dataDict = [[NSMutableDictionary alloc] init];
        
        UIView *tapView = [[UIView alloc] init];
        [self addSubview:tapView];
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-240);
        }];
        [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction:)]];
        
        UIView *contentView = [[UIView alloc] init];
        contentView.tag = 1001;
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(240);
            make.bottom.mas_equalTo(self);
        }];
        
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.tag = self.buttonTag = 10001;
        [tabButton setTitleColor:WordCloseBlack forState:UIControlStateNormal];
        [tabButton setTitleColor:[UIColor colorWithHexString:@"#3FC3C2"] forState:UIControlStateSelected];
        [tabButton setTitle:@"请选择" forState:UIControlStateSelected];
        tabButton.selected = YES;
        tabButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [tabButton addTarget:self action:@selector(tabButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:tabButton];
        [tabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo([tabButton.titleLabel.text boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:tabButton.titleLabel.font, NSFontAttributeName, nil] context:nil].size.width + 10);
        }];
        
        UIView *segLine = [[UIView alloc] init];
        segLine.backgroundColor = SegGray;
        [contentView addSubview:segLine];
        [segLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(39);
            make.height.mas_equalTo(1);
            make.left.right.mas_equalTo(0);
        }];
        
        self.tableViewOne = [[UITableView alloc] init];
        self.tableViewOne.delegate = self;
        self.tableViewOne.dataSource = self;
        self.tableViewOne.separatorStyle = NO;
        [contentView addSubview:self.tableViewOne];
        [self.tableViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(contentView.mas_bottom).offset(-44);
        }];
        
        segLine = [[UIView alloc] init];
        segLine.backgroundColor = SegGray;
        [contentView addSubview:segLine];
        [segLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(contentView.mas_bottom).offset(-43);
        }];

        
        UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveButton setTitle:@"确定" forState:UIControlStateNormal];
        [saveButton setTitleColor:WordCloseBlack forState:UIControlStateNormal];
        saveButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:saveButton];
        [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(contentView.mas_bottom).offset(0);
            make.height.mas_equalTo(44);
        }];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataDict[[NSString stringWithFormat:@"%ld",self.buttonTag]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ADDRESSCELL"];
    cell.textLabel.text = self.dataDict[[NSString stringWithFormat:@"%ld",self.buttonTag]][indexPath.row][@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = WordDeepGray;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.complete = YES;
    UIView *contentView = [self viewWithTag:1001];
    
    NSDictionary *dict = self.dataDict[[NSString stringWithFormat:@"%ld",self.buttonTag]][indexPath.row];
    UIButton *lastButton = [contentView viewWithTag:self.buttonTag - 1];
    UIButton *selectButton = [contentView viewWithTag:self.buttonTag];
    [selectButton setTitle:dict[@"name"] forState:UIControlStateNormal];
    [selectButton setTitle:dict[@"name"] forState:UIControlStateSelected];
    [selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (lastButton) {
            make.left.mas_equalTo(lastButton.mas_right);
        }else{
            make.left.mas_equalTo(5);
        }
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo([selectButton.titleLabel.text boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:selectButton.titleLabel.font, NSFontAttributeName, nil] context:nil].size.width + 10);
    }];
    
    NSArray *array = self.dataDict[[NSString stringWithFormat:@"%ld",self.buttonTag]][indexPath.row][@"children"];
    if ([array isKindOfClass:[NSArray class]]) {
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.tag = self.buttonTag = selectButton.tag + 1;
        [tabButton setTitleColor:WordCloseBlack forState:UIControlStateNormal];
        [tabButton setTitleColor:[UIColor colorWithHexString:@"#3FC3C2"] forState:UIControlStateSelected];
        [tabButton setTitle:@"请选择" forState:UIControlStateSelected];
        tabButton.selected = YES;
        tabButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [tabButton addTarget:self action:@selector(tabButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:tabButton];
        [tabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(selectButton.mas_right);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo([tabButton.titleLabel.text boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:tabButton.titleLabel.font, NSFontAttributeName, nil] context:nil].size.width + 10);
        }];
        
        [self.dataDict setObject:array forKey:[NSString stringWithFormat:@"%ld",tabButton.tag]];
        [self.tableViewOne reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableViewOne scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        });
        selectButton.selected = NO;
    }else{
        self.complete = YES;
    }
}

- (void)tabButtonAction:(UIButton *)sender{
    if (sender.selected){
        return;
    }
    UIView *contentView = [self viewWithTag:1001];
    for (long int i = self.buttonTag; i > sender.tag ; i--) {
        UIView *view = [contentView viewWithTag:i];
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    sender.selected = YES;
    UIButton *lastButton = [contentView viewWithTag:sender.tag - 1];
    [sender setTitle:@"请选择" forState:UIControlStateNormal];
    [sender setTitle:@"请选择" forState:UIControlStateSelected];
    [sender mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (lastButton) {
            make.left.mas_equalTo(lastButton.mas_right);
        }else{
            make.left.mas_equalTo(5);
        }
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo([sender.titleLabel.text boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:sender.titleLabel.font, NSFontAttributeName, nil] context:nil].size.width + 10);
    }];
    self.buttonTag = sender.tag;
    [self.tableViewOne reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableViewOne scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
}

- (void)cancelAction:(UITapGestureRecognizer *)sender{
    [self removeFromSuperview];
}

- (void)saveButtonAction:(UIButton *)sender{
    if (!self.complete) {
        [SVProgressHUD showErrorWithStatus:@"地址选择不完整"];
        return;
    }
    UIView *view = [self viewWithTag:1001];
    UIButton *one = [view viewWithTag:10001];
    UIButton *two = [view viewWithTag:10002];
    UIButton *three = [view viewWithTag:10003];
    
    if ([self.delegate respondsToSelector:@selector(completingTheSelection:city:area:)]) {
        [self.delegate completingTheSelection:one.titleLabel.text city:two.titleLabel.text area:three.titleLabel.text];
    }
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
