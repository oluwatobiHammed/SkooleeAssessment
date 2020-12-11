//
//  SignUpViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: BaseViewController {

    @IBOutlet weak var formTable: DynamicFormTable!
    @IBOutlet weak var callToAction: ButtomActionButton!
    var formFields: SigUpViewModel!
    var dynamicFormViewModel = DynamicFormTableViewModel()
    var message: String?
    override func viewDidLoad() {
        super.viewDidLoad()
             callToAction.delegate = self
             self.formTable.prepareTable()
             self.formTable.bindToViewModel(viewModel: dynamicFormViewModel)
             formFields = SigUpViewModel(viewModel: dynamicFormViewModel)
             formFields.kickOff(buttonBar: callToAction)
        // Do any additional setup after loading the view.
  
    }
    

 
    
    func validateNewUser(request: ValidateSignUpRequest){
          self.currentLoadingModal = LoadingViewController.showViewController(self, mainTitle: "Validating Account", subTitle: "please wait....")
        if let email = request.email, let password = request.password,let confirmPassword = request.passwordConfirmation, let firstName = request.firstName, let lastName = request.lastName, let middleName = request.middleName, let cityId = Int(request.cityId!), let driverType = request.driverType, let phoneNumber = request.phone {
            if (password != confirmPassword) {
                self.dismissCurrentLoadingModal()
                let alert = UIAlertController(title: "Login Error", message:"The password confirmation does not match", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            signup(email: email, password: password, passwordConfirmation: confirmPassword, firstName: firstName, lastName: lastName, middleName: middleName, driverType: driverType, cityId: cityId, phoneNumber: phoneNumber) { (res, status) in
                switch res {
                case .success(let user):
                    print(user.token)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.dismissCurrentLoadingModal()
                        self.navigationController?.pushViewController(MapViewController(), animated: true)
                    }
                case .failure(let error):
                    self.dismissCurrentLoadingModal()
                    let alert = UIAlertController(title: "SignUp Error", message:"\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   
                case .none:
                    break
                }
            }
             
        }
      }
    
}
extension SignUpViewController: ButtomButtonClickDelegate {
    func onButtonClicked(button: UIButton) {
     if let request = formFields.getRequestData() {
              validateNewUser(request: request)
          }
    }
}

