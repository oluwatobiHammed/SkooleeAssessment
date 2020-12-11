//
//  RadioButtonsInputGroup.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RadioButtonsInputGroup: InputFieldGroup {
    //var scroller: HorizontalScroller!
    var radioGroup: RadioButtonGroup!
    var yesNoButtonChanged: EmptyCallback?
    
    var buttonCreated: ((_ radioButton: RadioButton)-> Void)?
    
    override func setupXnib() {
        self.isTextInput = false
        super.setupXnib()
        self.contentView?.layer.borderWidth = 0
        radioGroup = RadioButtonGroup()
        //scroller = HorizontalScroller(frame: CGRect.zero)
        inputView?.isHidden = true
        leftAddon?.isHidden = true
        rightAddon?.isHidden = true
        
//        contentView?.addSubview(scroller)
//        self.contentView?.backgroundColor = UIColor.clear
//        self.layer.borderWidth = 0
//        scroller.translatesAutoresizingMaskIntoConstraints = false
//        scroller.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor).isActive = true
//        scroller.topAnchor.constraint(equalTo: contentView!.topAnchor).isActive = true
//        
//        contentView!.trailingAnchor.constraint(equalTo: scroller!.trailingAnchor).isActive = true
//        contentView!.bottomAnchor.constraint(equalTo: scroller!.bottomAnchor).isActive = true
//        
        radioGroup.buttonSelect.subscribe(onNext: { (values) in
            let button = values.0
            let selection = values.1
            switch selection {
            case .selected:
                if (button.radioItemData as? YesNoSingleRadioButtonItem) != nil {
                    self.fieldValue = YesNoSingleItem.yes
                    self.yesNoButtonChanged?()
                }
                else {
                    self.fieldValue = button.radioItemData
                }
            case .deselected:
                if (button.radioItemData as? YesNoSingleRadioButtonItem) != nil {
                    self.fieldValue = YesNoSingleItem.no
                    self.yesNoButtonChanged?()
                }
                else {
                    self.fieldValue = nil
                }
            }
            let _ = self.resignFirstResponder()
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: self.disposeBab)
        
    }
    
    override func shouldReceiveTapGesture()-> Bool {
        return false
    }
    
    func addRadioButton(item: RadioButtonItem) {
        radioGroup.addButton(createRadioButton(item: item))
        reloadScroller()
    }
    
    func setRadioButtons(items: [RadioButtonItem]) {
        let buttons = items.map { (item) -> RadioButton in
            return createRadioButton(item: item)
        }
        radioGroup.setButtonsArray(buttons)
        reloadScroller()
    }
    
    fileprivate func createRadioButton(item: RadioButtonItem)-> RadioButton {
        let radioButton = RadioButton(type: .custom)
        buttonCreated?(radioButton)
        radioButton.setTitle(item.getRadioButtonItemLabel(), for: .normal)
        radioButton.radioItemData = item
        return radioButton
    }
    
    fileprivate func reloadScroller() {
        let buttons = Observable.from(radioGroup.getButtons).map { (button) -> UIView in
            return button
        }.toArray()
       // self.scroller.itemsView = buttons.asObservable()
    }
    
    func selectButton(atIndex: Int) {
        self.radioGroup.selectButtonAtIndex(index: atIndex)
    }
    
}

