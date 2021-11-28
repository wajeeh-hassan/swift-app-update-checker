
open class AppUpdateChecker {
    
    public static let shared = AppUpdateChecker()

   
    
    public func checkAppUpdate(completion:@escaping(Bool,String?,String?)->Void){
        
        do {
            guard let info = Bundle.main.infoDictionary,
                  let currentVersion = info["CFBundleShortVersionString"] as? String,
                  let identifier = info["CFBundleIdentifier"] as? String,
                  let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                      completion(false,nil,nil)
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
            completion(false,nil,nil)
        }
       
    }
 
   
//    static func openAppStore() {
//
//        if let url = URL(string: AppData.appUpdateUrl),
//           UIApplication.shared.canOpenURL(url){
//            UIApplication.shared.open(url, options: [:]) { (opened) in
//                if(opened){
//                    print("App Store Opened")
//                }
//            }
//        } else {
//            print("Can't Open URL on Simulator")
//        }
//    }
//
    

}
