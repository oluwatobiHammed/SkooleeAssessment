//
//  SelectPickerInputGroup.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import UIKit

class SelectPickerInputGroup: InputFieldGroup {
    
    var pickerView = UIPickerView()
    
    var items: [RadioListDataItem] = []
    var renderDelegate: ((_ item: RadioListDataItem)-> String?)?
    var selectedRenderDelegate: ((_ item: RadioListDataItem)-> String?)?
    
    override func setupXnib() {
        self.isTextInput = false
        super.setupXnib()
        self.rightIcon = "caret_down"
        self.showLeftIcon = false
        createDatePicker()
    }
    
    
    func createDatePicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
        doneToolbarButtonText = "Select"
        titleToolbarButtonText = "Pick a value"
        inputField?.inputView = pickerView
    }
    
    override func toolbarDoneButtonClicked() {
        let selectedIndex = self.pickerView.selectedRow(inComponent: 0)
        if selectedIndex >= 0 && selectedIndex < items.count {
            self.fieldValue = items[selectedIndex]
            setSelectedValue(item: items[selectedIndex], resign: false)
        }
        super.toolbarDoneButtonClicked()
    }
    
    func clearSelection(resign: Bool = false) {
        self.fieldValue = nil
        self.inputField?.attributedPlaceholder = nil
        if resign {
            super.toolbarDoneButtonClicked()
        }
    }
    
    override func activateField() {
        self.inputField?.becomeFirstResponder()
    }
    
    func setSelectedValue(item: RadioListDataItem, resign: Bool = false) {
        self.fieldValue = item
        //        simpleText.inputGroup.inputField?.attributedPlaceholder
        let attribute = NSAttributedString(string: selectedRenderDelegate?(item) ?? item.getItemLabel(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        self.inputField?.attributedPlaceholder = attribute
        if resign {
            super.toolbarDoneButtonClicked()
        }
    }
    
    
}

extension SelectPickerInputGroup: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = items[row]
        return renderDelegate?(item) ?? item.getItemLabel()
    }
}

extension SelectPickerInputGroup: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
}

