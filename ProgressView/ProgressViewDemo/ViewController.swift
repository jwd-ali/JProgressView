//
//  ViewController.swift
//  ProgressViewDemo
//
//  Created by Jawad Ali on 03/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import ProgressView
class ViewController: UIViewController {
    private lazy var progessView = ProgressView() //ProgressView(colors: [.black, .red, .green, .yellow])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        progessView.StartAnimating(in: self.view)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        progessView.stopAnimating()
    }
    
}

