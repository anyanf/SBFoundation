//
//  XCPrePermissions.m
//  XCPrePermissions
//
//  Created by xiehaiduo on 20/6/16.
//  Copyright (c) 2020 xiehaiduo. All rights reserved.
//

typedef NS_ENUM(NSInteger, XCTitleType) {
    XCTitleTypeRequest,
    XCTitleTypeDeny
};

#import "XCPrePermissions.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
//at least iOS 9 code here
@import Contacts;
#endif

NSString *const XCPrePermissionsDidAskForPushNotifications = @"XCPrePermissionsDidAskForPushNotifications";

@interface XCPrePermissions () <UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertView *preAVPermissionAlertView;
@property (copy, nonatomic) XCPrePermissionCompletionHandler avPermissionCompletionHandler;

@property (strong, nonatomic) UIAlertView *prePhotoPermissionAlertView;
@property (copy, nonatomic) XCPrePermissionCompletionHandler photoPermissionCompletionHandler;

@property (strong, nonatomic) UIAlertView *preContactPermissionAlertView;
@property (copy, nonatomic) XCPrePermissionCompletionHandler contactPermissionCompletionHandler;

@property (strong, nonatomic) UIAlertView *preEventPermissionAlertView;
@property (copy, nonatomic) XCPrePermissionCompletionHandler eventPermissionCompletionHandler;

@property (strong, nonatomic) UIAlertView *preLocationPermissionAlertView;
@property (copy, nonatomic) XCPrePermissionCompletionHandler locationPermissionCompletionHandler;

@property (assign, nonatomic) XCLocationAuthorizationType locationAuthorizationType;
@property (assign, nonatomic) XCPushNotificationType requestedPushNotificationTypes;
@property (strong, nonatomic) UIAlertView *prePushNotificationPermissionAlertView;
@property (copy, nonatomic) XCPrePermissionCompletionHandler pushNotificationPermissionCompletionHandler;

@property (strong, nonatomic) UIAlertView *gpsPermissionAlertView;
@property (strong, nonatomic) XCPrePermissionCompletionHandler gpsPermissionCompletionHandler;

@end

static XCPrePermissions *__sharedInstance;

@implementation XCPrePermissions

+ (instancetype) sharedPermissions
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[XCPrePermissions alloc] init];
    });
    return __sharedInstance;
}

+ (XCAuthorizationStatus) AVPermissionAuthorizationStatusForMediaType:(NSString*)mediaType
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
            return XCAuthorizationStatusAuthorized;

        case AVAuthorizationStatusDenied:
            return XCAuthorizationStatusDenied;

        case AVAuthorizationStatusRestricted:
            return XCAuthorizationStatusRestricted;

        default:
            return XCAuthorizationStatusUnDetermined;
    }
}

+ (XCAuthorizationStatus) cameraPermissionAuthorizationStatus
{
    return [XCPrePermissions AVPermissionAuthorizationStatusForMediaType:AVMediaTypeVideo];
}

+ (XCAuthorizationStatus) photoPermissionAuthorizationStatus
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
        case ALAuthorizationStatusAuthorized:
            return XCAuthorizationStatusAuthorized;

        case ALAuthorizationStatusDenied:
            return XCAuthorizationStatusDenied;

        case ALAuthorizationStatusRestricted:
            return XCAuthorizationStatusRestricted;

        default:
            return XCAuthorizationStatusUnDetermined;
    }
}

#pragma mark - AV Permissions Help
- (void) showAVPermissionsWithType:(XCAVAuthorizationType)mediaType
                             title:(NSString *)requestTitle
                           message:(NSString *)message
                   denyButtonTitle:(NSString *)denyButtonTitle
                  grantButtonTitle:(NSString *)grantButtonTitle
                 completionHandler:(XCPrePermissionCompletionHandler)completionHandler
{
    if (requestTitle.length == 0) {
        switch (mediaType) {
            case XCAVAuthorizationTypeCamera:
                requestTitle = @"Access Camera?";
                break;

            default:
                requestTitle = @"Access Microphone?";
                break;
        }
    }
    denyButtonTitle  = [self titleFor:XCTitleTypeDeny fromTitle:denyButtonTitle];
    grantButtonTitle = [self titleFor:XCTitleTypeRequest fromTitle:grantButtonTitle];

    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:[self AVEquivalentMediaType:mediaType]];
    if (status == AVAuthorizationStatusNotDetermined) {
        self.avPermissionCompletionHandler = completionHandler;
        self.preAVPermissionAlertView = [[UIAlertView alloc] initWithTitle:requestTitle
                                                                   message:message
                                                                  delegate:self
                                                         cancelButtonTitle:denyButtonTitle
                                                         otherButtonTitles:grantButtonTitle, nil];
        self.preAVPermissionAlertView.tag = mediaType;
        [self.preAVPermissionAlertView show];
    } else if(status == AVAuthorizationStatusDenied) {
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        if (mediaType == XCAVAuthorizationTypeCamera) {
            [self showNoAutherOrRefuseAutherWithMessage:[NSString stringWithFormat:@"请在iPhone的”设置-隐私-相机”选项中，\r允许“%@”访问您的相册。",appName]];
        }else{
            [self showNoAutherOrRefuseAutherWithMessage:[NSString stringWithFormat:@"请在iPhone的”设置-隐私-麦克风”选项中，允许“%@”访问您的麦克风。",appName]];
        }
    }else{
        if (completionHandler) {
            completionHandler((status == AVAuthorizationStatusAuthorized),
                              XCDialogResultNoActionTaken,
                              XCDialogResultNoActionTaken);
        }
    }
}

- (void) showCameraPermissionsWithTitle:(NSString *)requestTitle
                                message:(NSString *)message
                        denyButtonTitle:(NSString *)denyButtonTitle
                       grantButtonTitle:(NSString *)grantButtonTitle
                      completionHandler:(XCPrePermissionCompletionHandler)completionHandler
{
    [self showAVPermissionsWithType:XCAVAuthorizationTypeCamera
                              title:requestTitle
                            message:message
                    denyButtonTitle:denyButtonTitle
                   grantButtonTitle:grantButtonTitle
                  completionHandler:completionHandler];
}

- (void) showMicrophonePermissionsWithTitle:(NSString *)requestTitle
                                    message:(NSString *)message
                            denyButtonTitle:(NSString *)denyButtonTitle
                           grantButtonTitle:(NSString *)grantButtonTitle
                          completionHandler:(XCPrePermissionCompletionHandler)completionHandler
{
    [self showAVPermissionsWithType:XCAVAuthorizationTypeMicrophone
                              title:requestTitle
                            message:message
                    denyButtonTitle:denyButtonTitle
                   grantButtonTitle:grantButtonTitle
                  completionHandler:completionHandler];
}

- (void) showActualAVPermissionAlertWithType:(XCAVAuthorizationType)mediaType
{
    [AVCaptureDevice requestAccessForMediaType:[self AVEquivalentMediaType:mediaType]
                             completionHandler:^(BOOL granted) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [self fireAVPermissionCompletionHandlerWithType:mediaType];
                                 });
                             }];
}


- (void) fireAVPermissionCompletionHandlerWithType:(XCAVAuthorizationType)mediaType
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:[self AVEquivalentMediaType:mediaType]];
    if (self.avPermissionCompletionHandler) {
        XCDialogResult userDialogResult = XCDialogResultGranted;
        XCDialogResult systemDialogResult = XCDialogResultGranted;
        if (status == AVAuthorizationStatusNotDetermined) {
            userDialogResult = XCDialogResultDenied;
            systemDialogResult = XCDialogResultNoActionTaken;
        } else if (status == AVAuthorizationStatusAuthorized) {
            userDialogResult = XCDialogResultGranted;
            systemDialogResult = XCDialogResultGranted;
        } else if (status == AVAuthorizationStatusDenied) {
            userDialogResult = XCDialogResultGranted;
            systemDialogResult = XCDialogResultDenied;
        } else if (status == AVAuthorizationStatusRestricted) {
            userDialogResult = XCDialogResultGranted;
            systemDialogResult = XCDialogResultParentallyRestricted;
        }
        self.avPermissionCompletionHandler((status == AVAuthorizationStatusAuthorized),
                                           userDialogResult,
                                           systemDialogResult);
        self.avPermissionCompletionHandler = nil;
    }
}

- (NSString*)AVEquivalentMediaType:(XCAVAuthorizationType)mediaType
{
    if (mediaType == XCAVAuthorizationTypeCamera) {
        return AVMediaTypeVideo;
    }
    else {
        return AVMediaTypeAudio;
    }
}

#pragma mark - Photo Permissions Help
- (void) showPhotoPermissionsWithTitle:(NSString *)requestTitle
                               message:(NSString *)message
                       denyButtonTitle:(NSString *)denyButtonTitle
                      grantButtonTitle:(NSString *)grantButtonTitle
                     completionHandler:(XCPrePermissionCompletionHandler)completionHandler
{
    if (requestTitle.length == 0) {
        requestTitle = @"Access Photos?";
    }
    denyButtonTitle  = [self titleFor:XCTitleTypeDeny fromTitle:denyButtonTitle];
    grantButtonTitle = [self titleFor:XCTitleTypeRequest fromTitle:grantButtonTitle];

    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusNotDetermined) {
        self.photoPermissionCompletionHandler = completionHandler;
        self.prePhotoPermissionAlertView = [[UIAlertView alloc] initWithTitle:requestTitle
                                                                      message:message
                                                                     delegate:self
                                                            cancelButtonTitle:denyButtonTitle
                                                            otherButtonTitles:grantButtonTitle, nil];
        [self.prePhotoPermissionAlertView show];
    } else if(status == ALAuthorizationStatusDenied){
        
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        [self showNoAutherOrRefuseAutherWithMessage:[NSString stringWithFormat:@"请在iPhone的”设置-隐私-相机”选项中，\r允许“%@”访问您的相机。",appName]];
    }else{
        if (completionHandler) {
            completionHandler((status == ALAuthorizationStatusAuthorized),
                              XCDialogResultNoActionTaken,
                              XCDialogResultNoActionTaken);
        }
    }
}

- (void) showActualPhotoPermissionAlert
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        // Got access! Show login
        dispatch_async(dispatch_get_main_queue(), ^{
            [self firePhotoPermissionCompletionHandler];
            *stop = YES;
        });
    } failureBlock:^(NSError *error) {
        // User denied access
        [self firePhotoPermissionCompletionHandler];
    }];
}

- (void) firePhotoPermissionCompletionHandler
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (self.photoPermissionCompletionHandler) {
        XCDialogResult userDialogResult = XCDialogResultGranted;
        XCDialogResult systemDialogResult = XCDialogResultGranted;
        if (status == ALAuthorizationStatusNotDetermined) {
            userDialogResult = XCDialogResultDenied;
            systemDialogResult = XCDialogResultNoActionTaken;
        } else if (status == ALAuthorizationStatusAuthorized) {
            userDialogResult = XCDialogResultGranted;
            systemDialogResult = XCDialogResultGranted;
        } else if (status == ALAuthorizationStatusDenied) {
            userDialogResult = XCDialogResultGranted;
            systemDialogResult = XCDialogResultDenied;
        } else if (status == ALAuthorizationStatusRestricted) {
            userDialogResult = XCDialogResultGranted;
            systemDialogResult = XCDialogResultParentallyRestricted;
        }
        self.photoPermissionCompletionHandler((status == ALAuthorizationStatusAuthorized),
                                              userDialogResult,
                                              systemDialogResult);
        self.photoPermissionCompletionHandler = nil;
    }
}

#pragma mark Public UIAlertView Show
- (void)showNoAutherOrRefuseAutherWithMessage:(NSString*)message
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {

        UIAlertView *enterSettings = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"设置", nil];
        enterSettings.tag = 100;
        [enterSettings show];
    }else{
    
        UIAlertView *photoAlertviews = [[UIAlertView alloc] initWithTitle:@"提示"message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [photoAlertviews show];
   }
}

#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.preAVPermissionAlertView) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            // User said NO, jerk.
            [self fireAVPermissionCompletionHandlerWithType:alertView.tag];
        } else {
            // User granted access, now show the REAL permissions dialog
            [self showActualAVPermissionAlertWithType:alertView.tag];
        }

        self.preAVPermissionAlertView = nil;
    } else if (alertView == self.prePhotoPermissionAlertView) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            // User said NO, jerk.
            [self firePhotoPermissionCompletionHandler];
        } else {
            // User granted access, now show the REAL permissions dialog
            [self showActualPhotoPermissionAlert];
        }

        self.prePhotoPermissionAlertView = nil;
    } else if (alertView.tag == 100){
        if (buttonIndex == 1) {
            NSURL*url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:url];
        }else{
            
        }
    }
}

#pragma mark - Titles
- (NSString *)titleFor:(XCTitleType)titleType fromTitle:(NSString *)title
{
    switch (titleType) {
        case XCTitleTypeDeny:
            title = (title.length == 0) ? @"Not Now" : title;
            break;
        case XCTitleTypeRequest:
            title = (title.length == 0) ? @"Give Access" : title;
            break;
        default:
            title = @"";
            break;
    }
    return title;
}

@end
