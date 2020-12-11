//
//  ValidateSignUpRequest.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import Alamofire

class ValidateSignUpRequest:ParameterProvider {
    var baseParameter: Parameters = [:]
    
    
    
    var email: String? {
          didSet{
              self.baseParameter["email"] = email
          }
      }
    
    var phone: String? {
          didSet{
              self.baseParameter["phone"] = phone
          }
      }
    
    var firstName: String? {
          didSet{
              self.baseParameter["first_name"] = firstName
          }
      }
    
    var  lastName: String? {
          didSet{
              self.baseParameter["last_name"] =  lastName
          }
      }
    
    var middleName: String? {
          didSet{
              self.baseParameter["middle_name"] = middleName
          }
      }
    var password: String?{
        didSet{
            self.baseParameter["password"] = password
        }
    }
    
    var passwordConfirmation: String?{
        didSet{
            self.baseParameter["password_confirmation"] = passwordConfirmation
        }
    }
    
    var driverType: String?{
        didSet{
            self.baseParameter["driver_type"] = driverType
        }
    }
    
    var cityId: String? {
          didSet{
              self.baseParameter["city_id"] = cityId
          }
      }
    func provideParameter() -> Parameters {
        return self.baseParameter
    }
}
