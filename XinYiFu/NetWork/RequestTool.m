

#import "RequestTool.h"
#import "RequestManage.h"
#import "NSObject+Unicode.h"
#import <objc/runtime.h>
#import "BaseResponse.h"
#import "UIImage+tool.h"

@implementation RequestTool

- (NSString *)baseUrl{
    return [RequestManage shareHTTPManage].baseURL.absoluteString;
}

+ (instancetype)shareManager{
    static RequestTool *shareManage = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareManage = [[RequestTool alloc] init];
    });
    return shareManage;
}



- (void)sendRequestWithAPI:(NSString *)requestAPI
                    withVC:(UIViewController *)vc
                withParams:(NSDictionary *)params
             withClassName:(NSString *)className
             responseBlock:(RequestResponse)response{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //修改为GBK编码
    [RequestManage shareHTTPManage].requestSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //不处理cookie
    [RequestManage shareHTTPManage].requestSerializer.HTTPShouldHandleCookies = NO;
    NSString *baseUrl = [RequestManage shareHTTPManage].baseURL.absoluteString;
    //清除Response
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    
    NSMutableDictionary *generalParam = [NSMutableDictionary new];
    NSArray *digestArray = @[@"app", @"userLogin", [self sortParams:params], @"1545655591864", @"Jg9eWSEllo"];
    NSString *md5Digest = [NSString stringToMD5:[digestArray componentsJoinedByString:@""]];
    NSString *base64Digest = [[md5Digest dataUsingEncoding:NSUTF8StringEncoding]base64EncodedStringWithOptions:0];
//    NSString *digest = [[[NSString stringToMD5:[digestArray componentsJoinedByString:@""]] dataUsingEncoding:NSUTF8StringEncoding]base64EncodedStringWithOptions:0];;
    
    if (params) {
        [generalParam setObject:[NSString convertToJsonData:params] forKey:@"params"];
    }
    [generalParam setObject:@"app" forKey:@"appKey"];
    [generalParam setObject:@"userLogin" forKey:@"serviceCode"];
    [generalParam setObject:@"1545655591864" forKey:@"timestamp"];
    [generalParam setObject:base64Digest forKey:@"digest"];

    NSLog(@"md5Digest========%@\nbase64Digest===========%@\nparameter ====== %@", md5Digest, base64Digest, generalParam);
    NSLog(@"------------%@------%@", [NSString stringWithFormat:@"%@%@", baseUrl,requestAPI], [baseUrl isEqualToString:@"http://118.31.79.1:8081"] ? params: generalParam);
    [[RequestManage shareHTTPManage] POST:[NSString stringWithFormat:@"%@%@", baseUrl,requestAPI] parameters:[baseUrl isEqualToString:@"http://118.31.79.1:8081"] ? params: generalParam progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //响应
        VDLog(@"\nResponse=====>URL:%@%@\nresult:%@",baseUrl,requestAPI,[responseObject my_description]);
        
        typedef void (^RequestResponse)(id response, NSString *errorMessage,NSInteger errorCode);
        
        if (className) {
            Class classVC = NSClassFromString(className);
            BaseResponse *baseResponse = [[classVC alloc]initWithDictionary:(NSDictionary *)responseObject error:nil];
            if (baseResponse) {
                response(baseResponse,baseResponse.msg,[baseResponse.code integerValue]);
            }
            else{
                VDLog(@"请查看您的Model结构^_^");
                response(nil,@"解析出错",-10000);
            }
        }
        else{
            response(responseObject,responseObject[@"msg"],[[responseObject valueForKey:@"code"] integerValue]);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        VDLog(@"failure error:%@",error);
        if (error.code == -1009) {
            response(nil,@"互联网的连接似乎已经断开",error.code);
        }
        else if(error.code == -1001){
            response(nil,@"请求超时,请检查下网络",error.code);
        }
        else if(error.code == -1011){
            response(nil,@"不支持该响应类型",error.code);
        }
        else if(error.code == -3840){
            response(nil,@"槽糕！貌似掉进异次元了",error.code);
        }
        else if(error.code == -1005){
            response(nil,@"网络状况貌似不太好",error.code);
        }
        else{
            response(nil,@"服务器需要休息片刻",error.code);
        }
        
    }];
    
}

#pragma mark [下载和上传]
//- (NSArray *)finishTasks{
//    
//    NSArray *array = (NSArray *)[[UserInfoModel sharedManage]getObjWithKey:@"finishTasks"];
//    if (array) {
//        return array;
//    }
//    return [NSArray array];
//}
//
//- (void)setFinishTasks:(NSArray *)finishTasks{
//    
//    [[UserInfoModel sharedManage]saveObjWithKey:@"finishTasks" andValue:finishTasks];
//}
//
//- (NSArray *)taskList{
//    
//    NSArray *array = (NSArray *)[[UserInfoModel sharedManage]getObjWithKey:@"taskList"];
//    if (array) {
//        return array;
//    }
//    return [NSArray array];
//}
//- (void)setTaskList:(NSArray *)taskList{
//    
//    [[UserInfoModel sharedManage]saveObjWithKey:@"taskList" andValue:taskList];
//}


- (void)createDownloadTaskWithURL:(NSString *)url
                     withFileName:(NSString *)fileName
                             Task:(DownloadTask)downloadTask
                         Progress:(TaskProgress)progress
                           Result:(TaskResult)result{
    /**
     *  创建下载队列，其中"download"为线程标示符
     */
    task_queue("download", ^{
        NSURL *requestUrl = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        __block NSURLSessionDownloadTask *task = [[RequestManage shareTaskManage] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            //回到主线程
            main_view_queue(^{
                progress(downloadProgress.fractionCompleted,fileName);
            });
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            /**
             *  拼接返回路径，并返回给 destination block 块
             *
             *  @param NSCachesDirectory 沙盒中 Caches 的路径
             *  @param NSUserDomainMask  搜索文件的范围
             *  @param YES               是否返回绝对路径 YES 是返回绝对路径 NO 返回相对路径
             *
             *  @return 沙盒中 Caches 的绝对路径
             */
            NSString *cachaPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            NSString *path = [cachaPath stringByAppendingPathComponent:fileName];
            
            NSURL *fileUrl = [NSURL fileURLWithPath:path];
            
            /*设置文件的存储路径(路径你想怎么设我管不着)*/
            return fileUrl;
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            BOOL isError = NO;
            if (error) {
                isError = YES;
                NSLog(@"error:%@",[error my_description]);
            }
            else{
                NSLog(@"%@下载完成",fileName);
                
            }
            result(response,isError);
            
        }];
        [task resume];
        /* 这个描述可以当做一个任务的标识，一般需要控制任务是才会使用 */
        task.taskDescription = fileName;
        downloadTask(task);
    });
    
}

- (void)createUploadTaskWithUrl:(NSString *)url
                       WithMark:(NSString *)mark
                       withData:(NSData *)data
                           Task:(UploadTask)uploadTask
                       Progress:(TaskProgress)progress
                         Result:(TaskResult)result{
    //创建上传队列
    task_queue("upload", ^{
        
        NSURL *requestUrl = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        __block NSURLSessionUploadTask *task = [[RequestManage shareTaskManage]uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
            //回到主线程
            main_view_queue(^{
                progress(uploadProgress.fractionCompleted,task.taskDescription);
                
            });
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            BOOL isError = NO;
            if (error) {
                isError = YES;
            }
            result(response,isError);
        }];
        [task resume];
        /* 这个描述可以当做一个任务的标识，一般需要控制任务是才会使用 */
        task.taskDescription = mark;
        
    });
}

- (void)uploadImageWithUrl:(NSString *)url WithImage:(UIImage *)image Params:(NSDictionary *)params Task:(UploadTask)uploadTask Progress:(TaskProgress)progress Result:(TaskResult)result{
    NSString *formatAPI =  [params objectForKey:@"imgType"]? [NSString stringWithFormat:@"app/%@.htm?imgType=%ld",url,[[params objectForKey:@"imgType"] integerValue]]: [NSString stringWithFormat:@"app/%@.htm?token=%@",url,[params objectForKey:@"token"]];
    VDLog(@"\nRequest=====>URL:%@%@",[RequestManage shareHTTPManage].baseURL.absoluteString,formatAPI);
    NSData *data = [UIImage smallTheImageBackData:image];
    task_queue("uploadImage", ^{
        __block NSURLSessionDataTask * task = [[RequestManage shareHTTPManage]POST:formatAPI parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"file.png" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //回到主线程
            main_view_queue(^{
                progress(uploadProgress.fractionCompleted,task.taskDescription);
                
            });
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            result(responseObject,code==0?NO:YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            result(error,YES);
        }];
    });
    
}
/**
 *  任务队列
 *
 *  @param ^block 在此代码块中创建任务
 */
static void task_queue(char *taskName,void (^block)(void))
{
    /**
     *  为下载任务开辟线程
     *
     *  @param "download"              线程标示符
     *  @param DISPATCH_QUEUE_CONCURRENT 并行队列宏
     *
     */
    dispatch_queue_t queue = dispatch_queue_create(taskName, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        block();
        
    });
}

/**
 *  回到主线程
 *
 *  @param ^block 需要在主线程执行的代码块
 */
static void main_view_queue(void (^block)(void))
{
    /**
     *  涉及到跟 UI 界面元素相关的操作，需要回到主线程执行相关代码
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
    
}

- (NSString *)sortParams:(NSDictionary *)dic{
    NSArray *keysArr = [NSArray arrayWithArray:[dic allKeys]];
    NSMutableArray *lowerMutArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary *lowerMutDic = [[NSMutableDictionary alloc]init];
    for (NSString *s in keysArr) {
        if ([dic[s] isKindOfClass:[NSString class]]) {
            if ([dic[s] isEqualToString:@""]) { // 为空不参与加密计算
                continue;
            }
        }
        [lowerMutArr addObject:[s lowercaseString]];
        [lowerMutDic setObject:dic[s] forKey:[s lowercaseString]];
    }
    NSArray *sortedArr = [lowerMutArr sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *mutStr = [[NSMutableString alloc] initWithString:@"{"];;
    for (int i = 0; i < sortedArr.count; i ++) {
        NSString *key = sortedArr[i];
        
        [mutStr appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,lowerMutDic[key]]];
    }
    return [NSString stringWithFormat:@"%@}",[mutStr substringWithRange:NSMakeRange(0, mutStr.length - 1)]];
}

@end
