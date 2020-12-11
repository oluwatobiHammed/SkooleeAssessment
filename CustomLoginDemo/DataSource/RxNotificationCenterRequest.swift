//
//  RxNotificationCenterRequest.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxNotificationCenterRequest {
    
    fileprivate static var instance: RxNotificationCenterRequest?
    
    static var shared: RxNotificationCenterRequest {
        if let insta = instance {
            return insta
        }
        instance = RxNotificationCenterRequest()
        return instance!
    }
    
    fileprivate var shareNotificationSubject: PublishSubject<[Any]?>?
    
    var shareNotification:Observable<[Any]?> {
        guard shareNotificationSubject != nil else {
            shareNotificationSubject = PublishSubject<[Any]?>()
            return shareNotificationSubject!.asObserver()
        }
        return shareNotificationSubject!.asObserver()
    }
    
    fileprivate init() {
        
    }
    
    func sendShareNotification(data: [Any]?) {
        self.shareNotificationSubject?.onNext(data)
    }
    
//    func shareApplication() {
//        if let id = ApplicationUtility.applicationProperties.appItunesStoreID {
//            let iOSUrl = "https://itunes.apple.com/us/app/apple-store/\(id)"
//            var message = "Welcome to the convenient and eazzy way of banking. Everything is eazzy with FCMB New Mobile! Download for Android: https://goo.gl/tMEHPo iOS: \(iOSUrl)."
//            //or use this invite code:  GTA4HP
//            if let key = UserProfileDataSource.shared.referralKey {
//                message += "\n\nPlease use this referral code: \(key)"
//            }
//            RxNotificationCenterRequest.shared.sendShareNotification(data: [message])
//        }
//        
//    }
    
}

