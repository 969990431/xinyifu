//
//  FeedbackProblemViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FeedbackProblemViewController.h"

@interface FeedbackProblemViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,NoNetworkViewDelegate,UITextViewDelegate>
@property (nonatomic ,strong) UITableView *backTableView;

@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) UILabel *textLength;

@property (nonatomic ,strong) UIView *imageWallView;
@property (nonatomic ,strong) NSMutableArray *imageArray;
@property (nonatomic ,strong) NSMutableArray *imageUrlArray;

@property (nonatomic ,strong) UIButton *submitBtn;
@end

@implementation FeedbackProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈问题";
    [self prepareViews];
}

- (void)refreshData{
    NSLog(@"1");
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    self.backTableView.backgroundColor = ThemeColor;
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *topTitleView = [[UIView alloc]init];
    [self.backTableView addSubview:topTitleView];
    [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    UILabel *topTitleLabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    topTitleLabel.text = @"问题和意见";
    [topTitleView addSubview:topTitleLabel];
    [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(topTitleView);
        make.height.mas_equalTo(22);
    }];
    
    UIView *textViewBackView = [[UIView alloc] init];
    textViewBackView.backgroundColor = [UIColor whiteColor];
    [self.backTableView addSubview:textViewBackView];
    [textViewBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(topTitleView.mas_bottom);
        make.height.mas_equalTo(180);
    }];
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请留下您对我们的不满以及您对我们软件的改良意见";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self.textView addSubview:placeHolderLabel];
    // same font
    self.textView.font = [UIFont systemFontOfSize:14.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    [textViewBackView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(165);
    }];
    self.textLength = [UILabel labelWithTextColor:WordGray font:12 aligment:NSTextAlignmentRight];
    self.textLength.text = @"0/50";
    [textViewBackView addSubview:self.textLength];
    [self.textLength mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-3);
        make.height.mas_offset(10);
    }];
    
    UIView *bottomTitleView = [[UIView alloc]init];
    [self.backTableView addSubview:bottomTitleView];
    [bottomTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textViewBackView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    UILabel *bottomTitleLabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    bottomTitleLabel.text = @"请提供相关问题的截图或照片";
    [bottomTitleView addSubview:bottomTitleLabel];
    [bottomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(bottomTitleView);
        make.height.mas_equalTo(22);
    }];
    CGFloat imageWidth = (CGRectGetWidth(self.view.frame) - 36 - 20) / 3;
    self.imageWallView = [[UIView alloc] init];
    self.imageWallView.backgroundColor = [UIColor whiteColor];
    [self.backTableView addSubview:self.imageWallView];
    [self.imageWallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomTitleView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(imageWidth + 20);
    }];
    
    [self reloadImageWall];
    
    self.submitBtn = [UIButton buttonWithTitle:@"提交" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    self.submitBtn.userInteractionEnabled = YES;
    [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backTableView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageWallView.mas_bottom).offset(36);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(40);
    }];
}

- (void)reloadImageWall{
    [self.imageWallView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat imageWidth = (CGRectGetWidth(self.view.frame) - 36 - 20) / 3;
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageArray[i]];
        [self.imageWallView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(18+imageWidth*i+10*i);
            make.width.height.mas_equalTo(imageWidth);
        }];
        
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        delBtn.tag = 20181227+i;
        [delBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [delBtn setBackgroundImage:GetImage(@"deletePic") forState:UIControlStateNormal];
        [self.imageWallView addSubview:delBtn];
        [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(-14);
            make.top.mas_equalTo(imageView.mas_top).offset(-6);
            make.width.height.mas_equalTo(20);
        }];
    }
    
    if (self.imageArray.count < 3) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:GetImage(@"shangchuantupian") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
        [self.imageWallView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(18+imageWidth*self.imageArray.count+10*self.imageArray.count);
            make.width.height.mas_equalTo(imageWidth);
        }];
    }

}

- (void)deleteImage:(UIButton *)sender{
    [self.imageArray removeObjectAtIndex:sender.tag - 20181227];
    [self reloadImageWall];
}

- (void)addImage{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.mediaTypes = temp_MediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
//            picker.mediaTypes = temp_MediaTypes;
            picker.delegate = self;
            picker.allowsEditing = NO;
        }
        [self presentViewController:picker animated:YES completion:nil];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (!self.imageArray) {
        self.imageArray = [[NSMutableArray alloc] init];
    }
    if (!self.imageUrlArray) {
        self.imageUrlArray = [[NSMutableArray alloc] init];
    }
    [SVProgressHUD show];
    [[RequestTool shareManager]uploadImageWithUrl:@"api/uploadFile" WithImage:info[@"UIImagePickerControllerOriginalImage"] Params:@{@"token":[UserPreferenceModel shareManager].token} Task:^(NSURLSessionUploadTask *task) {
        
    } Progress:^(float progress, NSString *taskDesc) {
        
    } Result:^(id response, BOOL isError) {
        if ([response[@"code"] integerValue] == 1) {
            [SVProgressHUD dismiss];
            [self.imageArray addObject:info[@"UIImagePickerControllerOriginalImage"]];
            [self.imageUrlArray addObject:response[@"data"][@"filepath"]];
            [self reloadImageWall];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败,请重试"];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if (range.location >= 50){
        return NO;
    }else{
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    self.textLength.text = [NSString stringWithFormat:@"%ld/50",textView.text.length];
    if (self.textView.text.length) {
        [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }else{
        [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
    }
}

- (void)submitAction:(UIButton *)sender{
    NSString *imgs = @"";
    for (NSString *str in self.imageUrlArray) {
        imgs = [imgs stringByAppendingString:str];
        imgs = [imgs stringByAppendingString:@","];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"content":self.textView.text}];
    if (imgs.length) {
        imgs = [imgs substringWithRange:NSMakeRange(0, imgs.length - 1)];
        [dict setObject:imgs forKey:@"imgs"];
    }
    [[RequestTool shareManager] sendNewRequestWithAPI:@"/api/suggestion/save" withVC:self withParams:dict withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        [SVProgressHUD dismiss];
        if (errorCode == 1) {
            [SVProgressHUD showInfoWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
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
