//
//  Contacts.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//


import Foundation
import RxSwift

class ContactsDisplayRequester {
    fileprivate var requestSubject = PublishSubject<UIViewController>()
    
    static let shared = ContactsDisplayRequester()
    
    var showContactsObserver: Observable<UIViewController> {
        return requestSubject.asObserver()
    }
    
    fileprivate init() {}
    
    func requestPresentController(viewController: UIViewController) {
        self.requestSubject.onNext(viewController)
    }
}
