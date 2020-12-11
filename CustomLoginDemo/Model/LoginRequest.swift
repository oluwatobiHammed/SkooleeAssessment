//
//  LoginRequest.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let email: String
    let password: String
    let role: String
    
}

