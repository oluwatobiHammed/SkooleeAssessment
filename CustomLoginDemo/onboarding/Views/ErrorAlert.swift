//
//  ErrorAlert.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 12/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import UIKit

class ErrorAlert: UIViewController {
    
    
    func Alert(title:String, message: String)  {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
