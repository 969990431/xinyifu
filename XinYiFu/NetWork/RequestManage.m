

#import "RequestManage.h"
//正式环境
static NSString *baseUrl = @"http://118.31.79.1:8081";
//测试环境
//static NSString *baseUrl = @"http://118.31.79.1:8081";

@implementation RequestManage

+ (AFHTTPSessionManager *)shareHTTPManage{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceSession;
    dispatch_once(&onceSession, ^{
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
        manager.requestSerializer.timeoutInterval = 20.f;//设置超时时间
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return manager;
}

+ (AFURLSessionManager *)shareTaskManage{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
}

+ (NSString *)baseUrl{
    return baseUrl;
}
@end
