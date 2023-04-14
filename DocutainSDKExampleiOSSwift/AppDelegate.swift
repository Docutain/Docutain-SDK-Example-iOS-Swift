//
//  AppDelegate.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 15.03.23.
//

import UIKit
import DocutainSdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let licenseKey = "YOUR_LICENSE_KEY_HERE"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initRootWindow()
        
        //the Docutain SDK needs to be initialized priot to using any functionality of it
        //a valid license key is required (contact us via [mailto:sdk@Docutain.com] to get a trial license
        if(!DocutainSDK.initSDK(licenseKey: licenseKey)){
            //init of Docutain SDK failed, get last error message
            print("InitSDK failed with error: \(DocutainSDK.getLastError())")
            if(licenseKey == "YOUR_LICENSE_KEY_HERE"){
                showLicenseEmptyInfo()
                return false
            }
        }
        
        if #available(iOS 13.0, *) {
            //If you want to use text recognition (OCR) and/or data extraction features, you need to set the AnalyzeConfiguration
            //in order to start all the necessary processes
            let analyzeConfig = AnalyzeConfiguration()
            analyzeConfig.readPaymentState = true
            analyzeConfig.readBIC = true
            if(!DocumentDataReader.setAnalyzeConfiguration(analyzeConfiguration: analyzeConfig)){
                print("setAnalyzeConfiguration failed with error: \(DocutainSDK.getLastError())")
            }
        }
        
        //Depending on your needs, you can set the Logger's levels
        Logger.setLogLevel(level: .verbose)
        
        //Depending on the log level that you have set, some temporary files get written on the filesystem
        //You can delete all temporary files by using the following method
        DocutainSDK.deleteTempFiles(deleteTraceFileContent: true)
        
        return true
    }
    
    private func initRootWindow(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        let navigationController = UINavigationController.init(rootViewController: viewController)
        setBarColors(navigationController: navigationController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    private func setBarColors(navigationController: UINavigationController){
        if #available(iOS 13.0, *) {
            let navbarAppearance = UINavigationBarAppearance()
            navbarAppearance.backgroundColor = UIColor(named: "TopBarsBackground")
            navbarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "TopBarsForeground")!]
            navigationController.navigationBar.standardAppearance = navbarAppearance
            navigationController.navigationBar.scrollEdgeAppearance = navbarAppearance
        } else {
            // Fallback on earlier versions
            navigationController.navigationBar.barTintColor = UIColor(named: "TopBarsBackground")
            navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "TopBarsForeground")!]
        }
        navigationController.navigationBar.tintColor = UIColor(named: "TopBarsForeground")
    }
    
    private func showLicenseEmptyInfo(){
        let alert = UIAlertController(title: "License empty", message: "A valid license key is required. Please contact us via sdk@Docutain.com to get a trial license.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Get license", style: .default, handler: {_ in
            let email = "sdk@Docutain.com"
            let subject = "Trial License Request"
            if let mailURLString = "mailto:\(email)?subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                   let mailURL = URL(string: mailURLString) {
                    if UIApplication.shared.canOpenURL(mailURL) {
                        UIApplication.shared.open(mailURL)
                    } else {
                        print("Mail can not be opened")
                    }
            } else{
                print("Mail can not be opened")
            }
            self.window?.isUserInteractionEnabled = false
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: {_ in
            exit(0)
        }))
        window?.rootViewController?.present(alert, animated: true)
    }
}

