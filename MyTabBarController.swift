//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by Jack Burton on 8/7/16.
//  Copyright © 2016 Pork Chop Express. All rights reserved.////

import UIKit


class MyTabBarController: UITabBarController {
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return nil
    }
}
