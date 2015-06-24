# NetworkRequestHandler 2.0

#### NetworkRequestHandler2.0 implements the basic networking task in iOS using AFNetworking 2.0.
Task that can be performed using it

1. Download a file (Image, Video,Audio etc.) with download progress using GET request.
2. Get server side data (JSON) with a GET request with/ without parameter.
3. Post data(Inculding File) to server with a upload progress with POST request. 
4. Put request to server with PUT request.
5. Delete request to server with DELETE request.

#### USAGES EXAMPLE

Add import statement in your ViewController
```objective-c
#import "AFNetworkRequestHandler.h"
```

#### 1. File Download (GET)

```objective-c
    [AFNetworkRequestHandler downloadFileDataFromURL:@"https://awesomewallpapers.files.wordpress.com/2015/06/autowallpaper_-200139.jpg" 
          withCompletionBlock:^(NSData *data, NSError *error) {
        if (!erro) {
          // Use the data here
        } else {
          // Handle Error
          NSLog(@"File download error %@", error.localizedDescription);
        }
    } andProgressBlock:^(float downloadProgressFraction) {
        NSLog(@"Download procgress = %f", downloadProgressFraction);
        // May be you will wish to show a progress of this download action.
    }];
```
#### 2. Data Download request with parameter (GET)

```objective-c
    [AFNetworkRequestHandler getServerDataFromURL:@"http://www.raywenderlich.com/demos/weather_sample/weather.php"
                                        parameter:@{@"format":@"json"}
                              withCompletionBlock:^(id responseObject, NSError *error) {
                                  
                                  // Handle the responseObject (Generally NSDictionary)
    } andProgressBlock:^(float downloadProgressFraction) {
        // If large amount of data is being downloaded , you might be wishing to show a progress
    }];
```

#### 3. Data + File Upload (POST)

```objective-c
    NSDictionary *dataDictionary = @{
                                        @"userName" : @"geek",
                                        @"password": @"12345"
                                     };
    
    NSString *profilePictureFileName = @"DSC_0758.jpg";
    NSString *userProfilePicFilePath = [[NSBundle mainBundle] pathForResource:[[profilePictureFileName lastPathComponent]
                                                                               stringByDeletingPathExtension]
                                                                       ofType:[profilePictureFileName pathExtension]];
    NSData *profilePictureImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:userProfilePicFilePath]];
    AFUploadObject *profilePictureUploadData = [[AFUploadObject alloc]initWithData:profilePictureImageData andFileName:profilePictureFileName];
    NSString *serverPath = @"https://example.com/createNewUser";
    
    [AFNetworkRequestHandler postSimpleData:dataDictionary attachmentData:@{@"profilePicture": profilePictureUploadData}
                                     toPath:serverPath withCompletionBlock:^(id responseObject, NSError *error) {
                                         if (!error) {
                                             // Handle the responseObject (Generally NSDictionary)
                                         }else{
                                             NSLog(@"Faced Error :%@", error.localizedDescription);
                                         }
                                     } andProgressBlock:^(float downloadProgressFraction) {
                                         // You might be wishing to show upload progress of that profile picture
    }];
```


#### 4. PUT Request (PUT)

```objective-c
    NSDictionary *parameters = @{
                                    @"newName":@"Geek2.0",
                                    @"userID":@"2ewrFWE342343D"
                                 };
    [AFNetworkRequestHandler putDataInServerSideAtPath:@"https://example.com/updateUser" parameter:parameters
                                   withCompletionBlock:^(id responseObject, NSError *error) {
                                       if (!error) {
                                           // Handle the responseObject (Generally NSDictionary)
                                       }else{
                                           NSLog(@"Faced Error :%@", error.localizedDescription);
                                       }
    }];
```

#### 5. DELETE Request (DELETE)

```objective-c
    NSDictionary *parameters = @{
                                    @"userID":@"2ewrFWE342343D"
                                 };
    [AFNetworkRequestHandler deleteDataInServerSideAtPath:@"https://example.com/deleteUser" parameter:parameters
                                   withCompletionBlock:^(id responseObject, NSError *error) {
                                       if (!error) {
                                           // Handle the responseObject (Generally NSDictionary)
                                       }else{
                                           NSLog(@"Faced Error :%@", error.localizedDescription);
                                       }
    }];
```


