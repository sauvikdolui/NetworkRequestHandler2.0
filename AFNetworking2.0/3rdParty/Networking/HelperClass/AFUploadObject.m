//
//  AFUploadObject.m
//  AFNetworking2.0
//
//  Created by Sauvik Dolui on 6/23/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "AFUploadObject.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation AFUploadObject


- (instancetype)initWithData:(NSData*)data andFileName:(NSString*)fileName{
    if (self = [super init]) {
        _fileData = data;
        _fileName = fileName;
        _fileMIMEType = [self mimeFromFileName:_fileName];
    }
    return self;
}

- (NSString*)mimeFromFileName:(NSString*)fileName{
    NSString *fileExtension = [fileName pathExtension];
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)fileExtension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    return contentType;
}

- (BOOL)isValid{
    if (_fileName && _fileData && _fileMIMEType) {
        return YES;
    }
    return NO;
}

@end
