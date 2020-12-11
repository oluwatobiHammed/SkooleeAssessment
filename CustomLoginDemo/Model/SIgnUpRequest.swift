//
//  SIgnUpRequest.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation

struct SIgnUpRequest: Codable {
    
    let email: String
    let password: String
    let passwordConfirmation: String
    let firstName: String
    let lastName: String
    let middleName: String
    let driverType: String
    let cityId: Int
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case passwordConfirmation = "password_confirmation"
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case driverType = "driver_type"
        case cityId = "city_id"
        case phoneNumber = "phone"
    }
    
}
