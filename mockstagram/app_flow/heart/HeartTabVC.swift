//
//  HeartTabVC.swift
//  mockstagram
//
//  Created by Brad Phillips on 3/30/19.
//  Copyright © 2019 megaBreezy. All rights reserved.
//

import UIKit

class HeartTabVC: UIViewController
{
    /**
     To-Do: fix selected tab adjustment on orientation change
    **/
    
    private var nav_tabs : HeartTabSegmentedControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nav_tabs = HeartTabSegmentedControl(frame: self.navigationController?.navigationBar.bounds ?? .zero)
        
        self.navigationController?.navigationBar.addSubview(nav_tabs)
    }
    
    override func viewWillTransition(to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: {
            [unowned self] _ in
                self.nav_tabs.frame.size.width = self.navigationController?.navigationBar.bounds.width ?? .zero
                self.nav_tabs.frame.size.height = self.navigationController?.navigationBar.bounds.height ?? .zero
        })
    }
}
