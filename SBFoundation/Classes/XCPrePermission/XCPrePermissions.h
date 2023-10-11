//
//  XCPrePermissions.h
//  XCPrePermissions
//
//  Created by xiehaiduo on 20/6/16.
//  Copyright (c) 2020 xiehaiduo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCPrePermissions : NSObject

/**
 * A general descriptor for the possible outcomes of a dialog.
 */
typedef NS_ENUM(NSInteger, XCDialogResult) {
    /// User was not given the chance to take action.
    /// This can happen if the permission was
    /// already granted, denied, or restricted.
    XCDialogResultNoActionTaken,
    /// User declined access in the user dialog or system dialog.
    XCDialogResultDenied,
    /// User granted access in the user dialog or system dialog.
    XCDialogResultGranted,
    /// The iOS parental permissions prevented access.
    /// This outcome would only happen on the system dialog.
    XCDialogResultParentallyRestricted
};

/**
 * A general descriptor for the possible outcomes of Authorization Status.
 */
typedef NS_ENUM(NSInteger, XCAuthorizationStatus) {
    /// Permission status undetermined.
    XCAuthorizationStatusUnDetermined,
    /// Permission denied.
    XCAuthorizationStatusDenied,
    /// Permission authorized.
    XCAuthorizationStatusAuthorized,
    /// The iOS parental permissions prevented access.
    XCAuthorizationStatusRestricted
};

/**
 * Authorization methods for the usage of location services.
 */
typedef NS_ENUM(NSInteger, XCLocationAuthorizationType) {
    /// the “when-in-use” authorization grants the app to start most
    /// (but not all) location services while it is in the foreground.
    XCLocationAuthorizationTypeWhenInUse,
    /// the “always” authorization grants the app to start all
    /// location services
    XCLocationAuthorizationTypeAlways,
};

/**
 * Authorization methods for the usage of event services.
 */
typedef NS_ENUM(NSInteger, XCEventAuthorizationType) {
    /// Authorization for events only
    XCEventAuthorizationTypeEvent,     // 日历
    /// Authorization for reminders only
    XCEventAuthorizationTypeReminder   // 提醒事项
};

/**
 * Authorization methods for the usage of Contacts services(Handling existing of AddressBook or Contacts framework).
 */
typedef NS_ENUM(NSInteger, XCContactsAuthorizationType){
    XCContactsAuthorizationStatusNotDetermined = 0,
    /*! The application is not authorized to access contact data.
     *  The user cannot change this application’s status, possibly due to active restrictions such as parental controls being in place. */
    XCContactsAuthorizationStatusRestricted,
    /*! The user explicitly denied access to contact data for the application. */
    XCContactsAuthorizationStatusDenied,
    /*! The application is authorized to access contact data. */
    XCContactsAuthorizationStatusAuthorized
};

/**
 * Authorization methods for the usage of AV services.
 */
typedef NS_ENUM(NSInteger, XCAVAuthorizationType) {
    /// Authorization for Camera only
    XCAVAuthorizationTypeCamera,      // 相机
    /// Authorization for Microphone only
    XCAVAuthorizationTypeMicrophone   // 麦克风
};

typedef NS_OPTIONS(NSUInteger, XCPushNotificationType) {
  XCPushNotificationTypeNone = 0, // the application may not present any UI upon a notification being received
  XCPushNotificationTypeBadge = 1 << 0, // the application may badge its icon upon a notification being received
  XCPushNotificationTypeSound = 1 << 1, // the application may play a sound upon a notification being received
  XCPushNotificationTypeAlert = 1 << 2, // the application may display an alert upon a notification being received
};

/**
 * General callback for permissions.
 * @param hasPermission Returns YES if system permission was granted 
 *                      or is already available, NO otherwise.
 * @param userDialogResult Describes whether the user granted/denied access, 
 *                         or if the user didn't have an opportunity to take action. 
 *                         GCDialogResultParentallyRestricted is never returned.
 * @param systemDialogResult Describes whether the user granted/denied access, 
 *                           or was parentally restricted, or if the user didn't 
 *                           have an opportunity to take action.
 * @see GCDialogResult
 */
typedef void (^XCPrePermissionCompletionHandler)(BOOL hasPermission,
                                              XCDialogResult userDialogResult,
                                              XCDialogResult systemDialogResult);

+ (instancetype) sharedPermissions;

+ (XCAuthorizationStatus) cameraPermissionAuthorizationStatus;
+ (XCAuthorizationStatus) photoPermissionAuthorizationStatus;

- (void) showCameraPermissionsWithTitle:(NSString *)requestTitle
                                message:(NSString *)message
                        denyButtonTitle:(NSString *)denyButtonTitle
                       grantButtonTitle:(NSString *)grantButtonTitle
                      completionHandler:(XCPrePermissionCompletionHandler)completionHandler;

- (void) showPhotoPermissionsWithTitle:(NSString *)requestTitle
                               message:(NSString *)message
                       denyButtonTitle:(NSString *)denyButtonTitle
                      grantButtonTitle:(NSString *)grantButtonTitle
                     completionHandler:(XCPrePermissionCompletionHandler)completionHandler;


@end
