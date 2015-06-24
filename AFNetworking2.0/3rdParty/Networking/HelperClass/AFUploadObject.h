//
//  AFUploadObject.h
//  AFNetworking2.0
//
//  Created by Sauvik Dolui on 6/23/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFUploadObject : NSObject

/// Holds raw data to be uploaded
@property (strong, nonatomic) NSData *fileData;
/// Holds the file name of the content to be uploaded
@property (strong, nonatomic) NSString *fileName;
/// Holds the MIME type of the content
@property (strong, nonatomic) NSString *fileMIMEType;

@property (assign, nonatomic, getter=isValid) BOOL valid;

/*!
 *  Create an Upload objects with data and file name
 *
 *  @param data     Raw data associated with the resource to be uploaded to server
 *  @param fileName File name of the resource to be uploaded to server
 *
 *  @return An AFUploadObject which can be uploaded to server using AFNetworking
 */
- (instancetype)initWithData:(NSData*)data andFileName:(NSString*)fileName;
@end
