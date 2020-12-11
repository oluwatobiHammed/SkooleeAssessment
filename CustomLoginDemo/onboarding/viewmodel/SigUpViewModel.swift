//
//  SigUpViewModel.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi Hammed on 19/05/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SigUpViewModel: BaseViewModelPopulator {
    
    var usernameValidation: Disposable?
    var usernameInput: InputFieldGroup?
    var role: [String] = ["driver","ride"]
  
    let FIELD_EMAIL = "email"
    let FIELD_PHONE = "phone"
    let FIELD_FIRST_NAME = "firstName"
    let FIELD_LAST_NAME = "lastName"
    let FIELD_MIDDLE_NAME = "middleName"
    let FIELD_CITY_ID = "cityId"
    let FIELD_DRIVER_TYPE = "driverType"
    let FIELD_PASSWORD = "password"
    let FIELD_PASSWORD_CONFIRMATION = "passwordConfirmation"
    var passwordProgress: UIProgressView!
    
    
    override func addFirstField() {
        self.addFirstName()
        self.addLastName()
        self.addMiddleName()
        self.addEmail()
        self.addPassword()
        self.addConfirmPassword()
        self.addPhone()
        self.addCityId()
        self.addDriverType()
    }


    func addEmail() {
          let row = self.addTextField(fieldName: FIELD_EMAIL, placeholder: "Email", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .email
        row.getInputFieldGroup()?.removeLeftIconSpace = true
        row.getInputFieldGroup()?.validEmail = true
      }
    
    func addFirstName() {
          let row = self.addTextField(fieldName: FIELD_FIRST_NAME, placeholder: "first name", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .username
        row.getInputFieldGroup()?.removeLeftIconSpace = true
      }
    
    func addLastName() {
          let row = self.addTextField(fieldName: FIELD_LAST_NAME, placeholder: "last name", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .username
        row.getInputFieldGroup()?.removeLeftIconSpace = true
      }
    func addMiddleName() {
          let row = self.addTextField(fieldName: FIELD_MIDDLE_NAME, placeholder: "middle name", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .username
        row.getInputFieldGroup()?.removeLeftIconSpace = true
       
      }
    
    func addCityId() {
          let row = self.addTextField(fieldName: FIELD_CITY_ID, placeholder: "city id", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .number
        row.getInputFieldGroup()?.removeLeftIconSpace = true
        
      }
    
    
    func addPhone() {
          let row = self.addTextField(fieldName: FIELD_PHONE, placeholder: "phone number", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .number
        row.getInputFieldGroup()?.removeLeftIconSpace = true
        row.getInputFieldGroup()?.minLength = 12
        
      }
    
    func addDriverType() {
        let row =  DynamicFormSectionRow()
        let field = SelectPickerInputGroup()
        field.items = role
        field.placeholder = "driver type"
        let label = ""
        row.widgetView = field
        let _ = DynamicFormSectionData.addSection(toModel: self.viewModel, formField: row, fieldName: self.FIELD_DRIVER_TYPE, headerTitle: label)
    }

    func addPassword() {
          let row = self.addTextField(fieldName: FIELD_PASSWORD, placeholder: "Password", header: "", required: true)
        row.getInputFieldGroup()?.keyboardTypeValue = .password
        row.getInputFieldGroup()?.removeLeftIconSpace = true
        row.getInputFieldGroup()?.passwordVisibility = true
        row.getInputFieldGroup()?.minLength = 8
    }
    
    func addConfirmPassword() {
          let row = self.addTextField(fieldName: FIELD_PASSWORD_CONFIRMATION, placeholder: "confirm Password", header: "", required: true)
        row.getInputFieldGroup()?.keyboardType = "password"
        row.getInputFieldGroup()?.removeLeftIconSpace = true
        row.getInputFieldGroup()?.passwordVisibility = true
        row.getInputFieldGroup()?.minLength = 8
    }
   
    
    func getRequestData()-> ValidateSignUpRequest? {
         if self.viewModel.validateAndSave() {
             let request = ValidateSignUpRequest()
            
            request.email = self.getFieldValueAsString(fieldName: FIELD_EMAIL)
            request.password = self.getFieldValueAsString(fieldName: FIELD_PASSWORD)
            request.passwordConfirmation = self.getFieldValueAsString(fieldName: FIELD_PASSWORD_CONFIRMATION)
            request.firstName = self.getFieldValueAsString(fieldName: FIELD_FIRST_NAME)
            request.lastName = self.getFieldValueAsString(fieldName: FIELD_LAST_NAME)
            request.middleName = self.getFieldValueAsString(fieldName: FIELD_MIDDLE_NAME)
            request.phone = self.getFieldValueAsString(fieldName: FIELD_PHONE)
            request.driverType = self.getFieldValueAsString(fieldName: FIELD_DRIVER_TYPE)
            request.cityId = self.getFieldValueAsString(fieldName: FIELD_CITY_ID)
            return request
         }
         return nil
     }
    
}
