//
//  ViewController.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 04/12/2019.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
}

