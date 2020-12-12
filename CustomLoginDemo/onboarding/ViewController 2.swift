//
//  ViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set up video in the background
        
        let  _ = StoryBoardsID.boardMain.navigate(to: .LoadingViewController, from: self)
    }
    
 
    
   


}

