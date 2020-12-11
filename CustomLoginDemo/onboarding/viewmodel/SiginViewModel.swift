//
//  SiginUpViewModel.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi Hammed on 20/05/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SiginViewModel: BaseViewModelPopulator {
    
    var usernameValidation: Disposable?
    var usernameInput: InputFieldGroup?
    var role: [String] = ["driver","ride"]
    let FIELD_Role = "role"
    let FIELD_EMAIL = "email"
    let FIELD_PASSWORD = "password"
    var passwordProgress: UIProgressView!
    
    
    override func addFirstField() {
        self.addEmail()
        self.addPassword()
        self.addRole()
    }


    func addEmail() {
          let row = self.addTextField(fieldName: FIELD_EMAIL, placeholder: "Email", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .email
        row.getInputFieldGroup()?.removeLeftIconSpace = true
        row.getInputFieldGroup()?.validEmail = true
      }
    func addPassword() {
          let row = self.addTextField(fieldName: FIELD_PASSWORD, placeholder: "Signup Password", header: "", required: true)
        row.getInputFieldGroup()?.keyboardType = "password"
        row.getInputFieldGroup()?.removeLeftIconSpace = true
        row.getInputFieldGroup()?.passwordVisibility = true
        row.getInputFieldGroup()?.minLength = 8
    }
    
    func addRole() {
        let row =  DynamicFormSectionRow()
        let field = SelectPickerInputGroup()
        field.items = role
        field.placeholder = "Role"
        let label = ""
        row.widgetView = field
        let _ = DynamicFormSectionData.addSection(toModel: self.viewModel, formField: row, fieldName: self.FIELD_Role, headerTitle: label)
    }
   
    
    func getRequestData()-> ValidateSignInRequest? {
         if self.viewModel.validateAndSave() {
             let request = ValidateSignInRequest()
            request.email = self.getFieldValueAsString(fieldName: FIELD_EMAIL)
            request.password = self.getFieldValueAsString(fieldName: FIELD_PASSWORD)
            request.role = self.getFieldValueAsString(fieldName: FIELD_Role)
            return request
         }
         return nil
     }
    
}
