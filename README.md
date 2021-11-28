# swift-app-update-checker

A very simple solution check new version of your application is available on store or not.  

![](https://github.com/wajeeh-hassan/swift-app-update-checker/blob/master/media/demo.gif)



[![CI Status](https://img.shields.io/travis/wajeehulhassan/swift-app-update-checker.svg?style=flat)](https://travis-ci.org/wajeehulhassan/swift-app-update-checker)
[![Version](https://img.shields.io/cocoapods/v/swift-app-update-checker.svg?style=flat)](https://cocoapods.org/pods/swift-app-update-checker)
[![License](https://img.shields.io/cocoapods/l/swift-app-update-checker.svg?style=flat)](https://cocoapods.org/pods/swift-app-update-checker)
[![Platform](https://img.shields.io/cocoapods/p/swift-app-update-checker.svg?style=flat)](https://cocoapods.org/pods/swift-app-update-checker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

swift-app-update-checker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'swift-app-update-checker'
```

## Usage
```swift
import swift_app_update_checker
```

```swift
   
   // A simple and easy method to check vew version is available or not on app store 
   
    
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
   
```

```swift
   
   // if you want to use your custom dialouge ,  you can call this method to open app store
   
     AppUpdateChecker.shared.openAppStore(AppURL: "Your app url on store")

```





## Author

wajeehulhassan, wajeeh661@gmail.com

## License

swift-app-update-checker is available under the MIT license. See the LICENSE file for more info.
