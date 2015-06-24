//
//  AFNetworkRequestHandlder.m
//  AFNetworking2.0
//
//  Created by Sauvik Dolui on 6/23/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "AFNetworkRequestHandler.h"
#import "AFUploadObject.h"

@implementation AFNetworkRequestHandler


+ (void)getServerDataFromURL:(NSString*)url parameter:(NSDictionary*)parameter withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock andProgressBlock:(RequestProgressBlock)progressBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *getRequeast = [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation,
                                                                                             id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(nil, error);
    }];
    
    // Here is the download progress
    [getRequeast setDownloadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten,
                                            long long totalBytesExpectedToWrite) {
        double percentDone = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        // Download Progress bar here
        progressBlock(percentDone);
    }];
    
}

+ (void)downloadFileDataFromURL:(NSString*)url withCompletionBlock:(FileDownloadCompletionBlock)completionBlock
               andProgressBlock:(RequestProgressBlock)progressBlock{
    
    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        double percentDone = (double)totalBytesRead / (double)totalBytesExpectedToRead;
        progressBlock(percentDone);
    }];
    __weak AFURLConnectionOperation *weakOperation = operation;
    [operation setCompletionBlock:^{
        completionBlock(weakOperation.responseData, weakOperation.error);
    }];
    [operation start];    
}

+ (void)postSimpleData:(NSDictionary*)simpleDataDictionary attachmentData:(NSDictionary*)attachmentDictionary toPath:(NSString*)path withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock andProgressBlock:(RequestProgressBlock)progressBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *requestOperation = [manager POST:path parameters:simpleDataDictionary
                                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                       
           if (attachmentDictionary) {
               // Adding attachment data in form one by one
               for (NSString *attachmentKey in attachmentDictionary.allKeys) {
                   
                   AFUploadObject *singleObject = [attachmentDictionary objectForKey:attachmentKey];
                   if (singleObject.valid) {
                       [formData appendPartWithFileData:singleObject.fileData name:attachmentKey fileName:singleObject.fileName
                                               mimeType:singleObject.fileMIMEType];
                   }else{
                       NSLog(@"AFUploadObject was not valid while adding to form data");
                   }
               }
           }
                                       
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(nil, error);
    }];
    // Here is the upload progress
    [requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        double percentDone = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        // Upload Progress bar here
        progressBlock(percentDone);
    }];
    [requestOperation start];
}

+ (void)deleteDataInServerSideAtPath:(NSString*)path parameter:(NSDictionary*)parameter withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(nil, error);
    }];
}
+ (void)putDataInServerSideAtPath:(NSString*)path parameter:(NSDictionary*)parameter withCompletionBlock:(ServerDataLoadCompletionBlock)completionBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager PUT:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(nil, error);
    }];
}
@end
