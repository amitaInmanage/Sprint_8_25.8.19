//
//  ViewController.swift
//  NewBaseProjectSwift
//
//  Created by Shani on 25/04/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationItemTitle(title: "שם אפליקציה")
        self.hideBackBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func didTapBtn(_ sender: Any) {
        
        if let homePage = self.storyboard?.instantiateViewController(withIdentifier: MainViewController.className) as? MainViewController {

            ApplicationManager.sharedInstance.navigationController.pushViewController(homePage, animated: true)
            
        }
        
    }
    
}

