//
//  AFNetworkRequestHandlder.h
//  AFNetworking2.0
//
//  Created by Sauvik Dolui on 6/23/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^FileDownloadCompletionBlock)(NSData *data, NSError* error);
typedef void(^ServerDataLoadCompletionBlock)(id responseObject, NSError* error);
typedef void(^RequestProgressBlock)(float downloadProgressFraction);

@interface AFNetworkRequestHandler : NSObject


+ (void)getServerDataFromURL:(NSString*)url parameter:(NSDictionary*)parameter withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock andProgressBlock:(RequestProgressBlock)progressBlock;


+ (void)downloadFileDataFromURL:(NSString*)url withCompletionBlock:(FileDownloadCompletionBlock)completionBlock andProgressBlock:(RequestProgressBlock)progressBlock;

+ (void)postSimpleData:(NSDictionary*)simpleDataDictionary attachmentData:(NSDictionary*)attachmentDictionary toPath:(NSString*)path withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock andProgressBlock:(RequestProgressBlock)progressBlock;

+ (void)deleteDataInServerSideAtPath:(NSString*)path parameter:(NSDictionary*)parameter withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock;

+ (void)putDataInServerSideAtPath:(NSString*)path parameter:(NSDictionary*)parameter withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock;


@end
