
open class AppUpdateChecker {
    
    public static let shared = AppUpdateChecker()

   
    
    public func isUpdateAvailable(completion:@escaping(Bool,String,String)->Void){
        
        do {
            guard let info = Bundle.main.infoDictionary,
                  let currentVersion = info["CFBundleShortVersionString"] as? String,
                  let identifier = info["CFBundleIdentifier"] as? String,
                  let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                      completion(false,"","")
                      return
             }
                        
            let data = try Data(contentsOf: url)
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
                throw VersionError.invalidResponse
            }
            
            if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {

                let current = currentVersion
                let appStore = version
                let versionCompare = current.compare(appStore, options: .numeric)
                if versionCompare == .orderedSame {
                    // print("same version")
                    completion (false, current ,appStore)
                } else if versionCompare == .orderedAscending {
                    // will execute the code here
                    // print("ask user to update")
                    completion (true, current ,appStore)
                } else if versionCompare == .orderedDescending {
                    // execute if current > appStore
                   //  print("don't expect happen...")
                    completion (false, current ,appStore)
                }
            }
            
        } catch let error {
            completion(false,"","")
        }
       
    }
 
   
 public func openAppStore(AppURL: String) {

        if let url = URL(string: AppURL),
           UIApplication.shared.canOpenURL(url){
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
           
        } else {
            print("Can't Open URL on Simulator")
        }
    }

    

    
    
    public  func showAppUpdateAlert(vc: UIViewController, Version : String, Force: Bool, AppURL: String) {
    
        let appName = Bundle.appName()

         let alertTitle = "New Version"
         let alertMessage = "\(appName) Version \(Version) is available on AppStore."

         let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)

         if !Force {
             let notNowButton = UIAlertAction(title: "Not Now", style: .default)
             alertController.addAction(notNowButton)
         }

         let updateButton = UIAlertAction(title: "Update", style: .default) { (action:UIAlertAction) in
             guard let url = URL(string: AppURL) else {
                 return
             }
             if #available(iOS 10.0, *) {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             } else {
                 UIApplication.shared.openURL(url)
             }
         }

         alertController.addAction(updateButton)
         vc.present(alertController, animated: true, completion: nil)

       
     }
    
    
    
    
    
    
    
    
    
}
