//
//  ViewController2.swift
//  StickySegmented
//
//  Created by Nicolas on 4/23/19.
//  Copyright © 2019 doapps. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableHeight.constant = CGFloat(44*20)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


