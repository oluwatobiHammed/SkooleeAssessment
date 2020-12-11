//
//  SJFluidSegmentedControlExtension.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

extension SJFluidSegmentedControl{
    func prepareSegmentControl(dataSource: AnyObject, delegate: AnyObject) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.backgroundColor = ThemeManager.currentTheme().borderColor
        self.cornerRadius = 20
        self.textColor = UIColor.gray
        self.selectedSegmentTextColor = UIColor.white
        self.selectorViewColor = ThemeManager.currentTheme().mainColor
    }
}

