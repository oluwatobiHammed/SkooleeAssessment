//
//  MainNavigationController.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            //assume user is logged in
            let mapViewController = MapViewController()
            viewControllers = [mapViewController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: {
            //perhaps we'll do something here later
        })
    }
}


