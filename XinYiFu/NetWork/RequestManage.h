

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface RequestManage : NSObject
/**
 *  普通HTTP请求
 *
 *  @return manage
 */
+ (AFHTTPSessionManager *)shareHTTPManage;
/**
 *  下载或上传任务
 *
 *  @return manage
 */
+ (AFURLSessionManager *)shareTaskManage;

+ (NSString *)baseUrl;
@end
