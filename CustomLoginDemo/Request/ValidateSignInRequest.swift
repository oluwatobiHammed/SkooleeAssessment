//
//  ValidateSignUpProfileRequest.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi Hammed on 19/05/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import Alamofire

class ValidateSignInRequest:ParameterProvider {
    public typealias Parameters = [String: Any]
    var baseParameter: Parameters = [:]
    
    
    
    var email: String? {
          didSet{
              self.baseParameter["email"] = email
          }
      }
    var password: String?{
        didSet{
            self.baseParameter["password"] = password
        }
    }
    
    var role: String?{
        didSet{
            self.baseParameter["role"] = role
        }
    }
    
    func provideParameter() -> Parameters {
        return self.baseParameter
    }
}
