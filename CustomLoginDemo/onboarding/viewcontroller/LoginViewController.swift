//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var formTable: DynamicFormTable!
    @IBOutlet weak var callToAction: ButtomActionButton!
    @IBOutlet weak var signUpbutton: UIButton!
    var formFields: SiginViewModel!
    var dynamicFormViewModel = DynamicFormTableViewModel()
    @IBOutlet weak var messageLabel: UILabel!
    var message: String?
    var statusCodes: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkifLoogedin()
        callToAction.delegate = self
        self.formTable.prepareTable()
        self.formTable.bindToViewModel(viewModel: dynamicFormViewModel)
        formFields = SiginViewModel(viewModel: dynamicFormViewModel)
        formFields.kickOff(buttonBar: callToAction)
        setupSignUpButton()
        observeKeyboardNotifications()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            }, completion: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            
            }, completion: nil)
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        let _ = formTable?.resignFirstResponder()
         let  _ = StoryBoardsID.boardMain.requestNavigation(to: .SignUpViewController, requestData: nil)
    }

    func validateLoginRequest(request: ValidateSignInRequest){
        self.currentLoadingModal = LoadingViewController.showViewController(self, mainTitle: "Validating User", subTitle: "please wait....")
            login(request: request) { [self] (res)  in
                switch res {
                case .success( _):
                    //print(user.token)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.dismissCurrentLoadingModal()
                        self.navigationController?.pushViewController(MapViewController(), animated: true)
                    }
                    UserDefaults.standard.setIsLoggedIn(value: true)
                case .failure(let error):
                    self.dismissCurrentLoadingModal()
                    message = "\(error.localizedDescription)"
                    
                    AlertView.instance.showAlert(title: "Login Error", message:"\(error.localizedDescription)", alertType: .failure)

                }

            } statusCode: { [self] (Code) in
                statusCodes = Code
                
            }
        
      
    }
    
    func setupSignUpButton(){
        let attributedTitleLable = NSMutableAttributedString(string: "Don't have an Account", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
       let  attributedTitle = NSAttributedString(string: "  Sign Up", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        messageLabel?.attributedText = attributedTitleLable
        signUpbutton?.setAttributedTitle(attributedTitle, for: .normal)
    }
    
}

extension LoginViewController: ButtomButtonClickDelegate {
    func onButtonClicked(button: UIButton) {
        if let request = formFields.getRequestData() {
            validateLoginRequest(request: request)
        }
    }
}

