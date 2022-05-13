//
//  ViewController.swift
//  CaptchaViewDemo
//
//  Created by User on 2022/5/13.
//

import UIKit

class ViewController: UIViewController {

    let captchaView = CaptchaView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captchaView.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(captchaView)
        captchaView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        captchaView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        captchaView.heightAnchor.constraint(equalToConstant:44).isActive = true
        captchaView.widthAnchor.constraint(equalToConstant: 105).isActive = true
        // Do any additional setup after loading the view.
    }


}

