//
//  ViewController.swift
//  swift-app-update-checker
//
//  Created by wajeehulhassan on 11/27/2021.
//  Copyright (c) 2021 wajeehulhassan. All rights reserved.
//

import UIKit
import swift_app_update_checker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.async {
            AppUpdateChecker.shared.isUpdateAvailable{ isAvailable, localVersion, storeVersion  in
                
                print("update available : \(isAvailable)")
                print("local app version : \(localVersion)")
                print("store app version : \(storeVersion)")
                
                if isAvailable{
                    self.showAppUpdateAlert(Version: storeVersion, Force: false, AppURL: "Your app url on store")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

