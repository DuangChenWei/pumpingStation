//
//  NetWorkData.m
//  textNSURLSession
//
//  Created by cw on 16/3/29.
//  Copyright © 2016年 Chen Wei. All rights reserved.
//

#import "NetWorkData.h"
static NetWorkData *netdata=nil;
@implementation NetWorkData
+(NetWorkData *)shareData{
    if (netdata==nil) {
        netdata=[[NetWorkData alloc] init];
        //会话配置，这里配置为短暂配置，还有默认配置和后台配置
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //配置请求头
//        [config setHTTPAdditionalHeaders:@{@"Authorization":[Dropbox apiAuthorizationHeader]}];
        //初始化会话
        netdata.session = [NSURLSession sessionWithConfiguration:config ];
    }
    
    return netdata;
}

-(void)GETMethod:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    //显示加载提示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //获取你的Dropbox的根目录
    NSURL *url = [NSURL URLWithString:URLString];
    //创建数据任务，这个方法主要用来请求HTTP的GET方法，并返回NSData对象，我们需要将数据再解析成我们需要的数据
    //2:创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    //设置request
    [request setHTTPMethod:@"GET"];

    NSURLSessionDataTask *dataaa=[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // 响应状态代码为200，代表请求数据成功，判断成功后我们再进行数据解析
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            //            NSLog(@"+++++%d",httpResp.statusCode);
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                //解析NSData数据
                NSDictionary *notesJSON =
                [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!jsonError) {
                        
                        // NSURLSession的方法是在异步执行的，所以更新UI回到主线程
                        
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        success(notesJSON);
                        
                    }else{
                        
                        failure(jsonError);
                    }
                });
            }
        }
        else{
            failure(error);
            //            NSLog(@"error::%@",error);
        }

    }];
    [dataaa resume];
    
 
    
    
//    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!error) {
//            // 响应状态代码为200，代表请求数据成功，判断成功后我们再进行数据解析
//            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
////            NSLog(@"+++++%d",httpResp.statusCode);
//            if (httpResp.statusCode == 200) {
//                NSError *jsonError;
//                //解析NSData数据
//                NSDictionary *notesJSON =
//                [NSJSONSerialization JSONObjectWithData:data
//                                                options:NSJSONReadingAllowFragments
//                                                  error:&jsonError];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (!jsonError) {
//                        
//                        // NSURLSession的方法是在异步执行的，所以更新UI回到主线程
//                        
//                            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//                            success(notesJSON);
//                        
//                    }else{
//                    
//                        failure(jsonError);
//                    }
//                });
//            }
//        }
//        else{
//            failure(error);
////            NSLog(@"error::%@",error);
//        }
//    }];
    //启动任务
//    [dataTask resume];
    
    
}
-(NSDictionary *)getTTTTTTTT:(NSString *)URLString{
    //显示加载提示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //获取你的Dropbox的根目录
    NSURL *url = [NSURL URLWithString:URLString];
    //创建数据任务，这个方法主要用来请求HTTP的GET方法，并返回NSData对象，我们需要将数据再解析成我们需要的数据
    //2:创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    //设置request
    [request setHTTPMethod:@"GET"];
     dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    self.dataDic=nil;
    NSURLSessionDataTask *dataaa=[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // 响应状态代码为200，代表请求数据成功，判断成功后我们再进行数据解析
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            //            NSLog(@"+++++%d",httpResp.statusCode);
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                //解析NSData数据
                NSDictionary *notesJSON =
                [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                
                NSLog(@"++---%@",notesJSON);
                self.dataDic=notesJSON;
                        // NSURLSession的方法是在异步执行的，所以更新UI回到主线程
                        
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    
                    dispatch_semaphore_signal(semaphore);
                        
                
            }
        }
        else{
          
            dispatch_semaphore_signal(semaphore);
            //            NSLog(@"error::%@",error);
        }
        
    }];
    [dataaa resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return self.dataDic;
    
}






-(void)PostMethod:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{

    
    
    //1:准备url
    NSURL *url=[NSURL URLWithString:URLString];
    
    //第二部:创建请求对象
    NSMutableURLRequest *requst=[NSMutableURLRequest requestWithURL:url];
    
    //设置request
    [requst setHTTPMethod:@"POST"];
    NSData *bodyData=[parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    [requst setHTTPBody:bodyData];
    
//    NSURLSessionDataTask *da=[self.session dataTaskWithRequest:requst];
//    
//    [da resume];
//    NSLog(@"+++%d",da.response);
    
    
    NSURLSessionDataTask *dataaa=[self.session dataTaskWithRequest:requst completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // 响应状态代码为200，代表请求数据成功，判断成功后我们再进行数据解析
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            //            NSLog(@"+++++%d",httpResp.statusCode);
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                //解析NSData数据
                NSDictionary *notesJSON =
                [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!jsonError) {
                        
                        // NSURLSession的方法是在异步执行的，所以更新UI回到主线程
                        
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        success(notesJSON);
                        
                    }else{
                        
                        failure(jsonError);
                    }
                });
            }
        }
        else{
            failure(error);
            //            NSLog(@"error::%@",error);
        }
        
    }];
    [dataaa resume];

    
    
    
}
//1.接收到服务器响应的时候调用该方法
 -(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
 {
     //在该方法中可以得到响应头信息，即response
     NSLog(@"didReceiveResponse--%@",[NSThread currentThread]);

     //注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
     //默认是取消的
     /*
    59         NSURLSessionResponseCancel = 0,        默认的处理方式，取消
    60         NSURLSessionResponseAllow = 1,         接收服务器返回的数据
    61         NSURLSessionResponseBecomeDownload = 2,变成一个下载请求
    62         NSURLSessionResponseBecomeStream        变成一个流
    63      */

     completionHandler(NSURLSessionResponseAllow);
 }

 //2.接收到服务器返回数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
 -(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
 {
     NSLog(@"didReceiveData--%@",[NSThread currentThread]);

     //拼接服务器返回的数据
//     [self.responseData appendData:data];
 }

 //3.当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
 -(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
 {
     NSLog(@"didCompleteWithError--%@",[NSThread currentThread]);

     if(error == nil)
     {
            //解析数据,JSON解析请参考http://www.cnblogs.com/wendingding/p/3815303.html
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:nil];
//            NSLog(@"%@",dict);
         }
 }
@end
