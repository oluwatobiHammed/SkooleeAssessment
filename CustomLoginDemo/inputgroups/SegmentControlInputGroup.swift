//
//  SegmentControlInputGroup.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi on 11/12/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SegmentControlInputGroup: InputFieldGroup {
    
    var segmentedControl: SJFluidSegmentedControl!
    var segmentTitles: [RadioListDataItem] = []
    fileprivate var indexSelectionSubject = PublishSubject<(Int, Int)>()
    var indexSelection: Observable<(Int, Int)>!
    var segmentProviderDisposable: Disposable?
    var disposeBag: DisposeBag = DisposeBag()
    var prepared = false
    
    var segmentProvider: Observable<RadioListDataItem>? = nil {
        didSet {
            self.segmentProviderDisposable?.dispose()
            segmentTitles.removeAll()
            if let segmentProvider = self.segmentProvider {
                
                self.segmentProviderDisposable = segmentProvider.subscribe(onNext: { (segmentText) in
                    self.segmentTitles.append(segmentText)
                }, onError: { (error) in
                    
                }, onCompleted: {
                    if !self.prepared {
                        self.segmentedControl.prepareSegmentControl(dataSource: self, delegate: self)
                        self.prepared = true
                        if self.segmentTitles.count > 0 {
                            self.selectTitleAtIndex(index: 0)
                        }
                    }
                    self.segmentedControl.reloadData()
                }) {
                    
                }
                self.segmentProviderDisposable?.disposed(by: disposeBag)
                
            }
        }
    }
    override func setupXnib() {
        self.isTextInput = false
        super.setupXnib()
        self.indexSelection = indexSelectionSubject.asObserver()
        self.segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        self.segmentedControl.backgroundColor = UIColor.clear
        self.layer.borderWidth = 0
        self.contentView?.backgroundColor = UIColor.clear
        self.contentView?.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        if let parent = contentView {
            segmentedControl.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            parent.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor).isActive = true
            segmentedControl.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            parent.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        }
    }
    
    override func shouldReceiveTapGesture()-> Bool {
        return false
    }
    
    func selectTitleAtIndex(index: Int) {
        let selectedText = segmentTitles[index]
        self.fieldValue = selectedText
    }
}

extension SegmentControlInputGroup: SJFluidSegmentedControlDataSource {
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return segmentTitles.count
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          titleForSegmentAtIndex index: Int) -> String? {
        return segmentTitles[index].getItemLabel()
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        return [ThemeManager.currentTheme().mainColor, ThemeManager.currentTheme().accentColor]
    }
    
}


extension SegmentControlInputGroup: SJFluidSegmentedControlDelegate{
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          didChangeFromSegmentAtIndex fromIndex: Int,
                          toSegmentAtIndex toIndex:Int) {
        indexSelectionSubject.onNext((fromIndex, toIndex))
        // the item has been selected, blur from the field so it's value can be saved
        self.selectTitleAtIndex(index: toIndex)
        let _ = self.resignFirstResponder()
    }
}

