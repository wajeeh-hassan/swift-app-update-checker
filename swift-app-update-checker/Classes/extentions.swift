//
//  extentions.swift
//  swift-app-update-checker
//
//  Created by wajeeh hassan on 27/11/2021.
//

import Foundation


enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}


public extension UIViewController {
    
     func showAppUpdateAlert( Version : String, Force: Bool, AppURL: String) {
    
         let appName = Bundle.appName()

        let alertTitle = "New Version"
        let alertMessage = "\(appName) Version \(Version) is available on AppStore."

        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)

        if !Force {
            let notNowButton = UIAlertAction(title: "Not Now", style: .default)
            alertController.addAction(notNowButton)
        }

        let updateButton = UIAlertAction(title: "Update", style: .default) { (action:UIAlertAction) in
            AppUpdateChecker.shared.openAppStore(AppURL: AppURL)
        }

        alertController.addAction(updateButton)
        self.present(alertController, animated: true, completion: nil)
    }
}


extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
