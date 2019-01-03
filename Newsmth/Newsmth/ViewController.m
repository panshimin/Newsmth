//
//  ViewController.m
//  Newsmth
//
//  Created by 潘世民 on 2018/9/10.
//  Copyright © 2018年 潘世民. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *URL = [NSURL URLWithString:@"http://www.newsmth.net/nForum/user/ajax_login.json"];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URL.absoluteString parameters:nil error:nil];
    
    NSString *user = @"zzupanshimin";
    NSString *password = @"panshimin@689";
    NSString *postBody = [NSString stringWithFormat:@"id=%@&passwd=%@&save=on", user, password];
    NSData *data = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    NSString *user_agent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36";
    NSString *content_type = @"application/x-www-form-urlencoded; charset=UTF-8";
    NSString *referer = @"http://www.newsmth.net/nForum/";
    NSString *accept_lanuage = @"zh-CN,zh;q=0.9,en;q=0.8,ja;q=0.7";
    NSString *accept = @"application/json, text/javascript, */*; q=0.01";
    NSString *host = @"www.newsmth.net";
    NSString *XRequestedWith = @"XMLHttpRequest";
    NSString *connection = @"keep-alive";
    NSString *cookie = [[self class] fetchCookie];
    NSString *accept_encoding = @"gzip, deflate";
    request.timeoutInterval = 30;
    [request setValue:user_agent forHTTPHeaderField:@"User-Agent"];
    [request setValue:content_type forHTTPHeaderField:@"Content-Type"];
    [request setValue:referer forHTTPHeaderField:@"Referer"];
    [request setValue:accept_lanuage forHTTPHeaderField:@"Accept-Language"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];
    [request setValue:XRequestedWith forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:host forHTTPHeaderField:@"Host"];
    [request setValue:connection forHTTPHeaderField:@"Connection"];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:accept_encoding forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:data];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json" ,@"text/javascript", nil];
    manager.responseSerializer = responseSerializer;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                   uploadProgress:nil
                                                 downloadProgress:nil
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    if (error) {
                                                        NSLog(@"Error : %@",error);
                                                    } else {
                                                        NSLog(@"Response : %@",response);
                                                    }
                                                }];
    [dataTask resume];
    
}


+ (NSString *)fetchCookie {
    NSString *cookie = [NSString stringWithFormat:@"Hm_lvt_9c7f4d9b7c00cb5aba2c637c64a41567=%ld; Hm_lvt_bbac0322e6ee13093f98d5c4b5a10912=%ld; main[XWJOKE]=hoho; main[UTMPUSERID]=guest; main[UTMPKEY]=59133252; main[UTMPNUM]=23560; Hm_lpvt_bbac0322e6ee13093f98d5c4b5a10912=%ld",[self fetchTimestamp],[self fetchTimestamp],[self fetchTimestamp]];
    
    return cookie;
}

+ (NSUInteger)fetchTimestamp {
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    return (NSUInteger)timeStamp;
}


@end
