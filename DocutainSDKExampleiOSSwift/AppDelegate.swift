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
        //a valid license key is required, you can generate one on our website https://sdk.docutain.com/TrialLicense?Source=721410
        if(!DocutainSDK.initSDK(licenseKey: licenseKey)){
            //init of Docutain SDK failed, get last error message
            print("InitSDK failed with error: \(DocutainSDK.getLastError())")
            if(licenseKey == "YOUR_LICENSE_KEY_HERE"){
                showLicenseEmptyInfo()
                return false
            } else{
                showLicenseErrorInfo()
                return false
            }
        }
        
        if #available(iOS 13.0, *) {
            //Reading payment state and BIC when getting the analyzed data is disabled by default
            //If you want to analyze these 2 fields as well, you need to set the AnalyzeConfig accordingly
            //A good place to do this, is right after initializing the Docutain SDK
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
        let alert = UIAlertController(title: "License empty", message: "A valid license key is required. Please click \"Get License\" in order to create a free trial license key on our website.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Get License", style: .default, handler: {_ in
            if let url = URL(string: "https://sdk.docutain.com/TrialLicense?Source=721410") {
                UIApplication.shared.open(url, completionHandler: {_ in
                    exit(0)
                })
            }
            self.window?.isUserInteractionEnabled = false
        }))
        window?.rootViewController?.present(alert, animated: true)
    }
    
    private func showLicenseErrorInfo(){
        let alert = UIAlertController(title: "License error", message: "A valid license key is required. Please contact our support to get an extended trial license.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Contact Support", style: .default, handler: {_ in
            self.sendEmailToSupport(completion: {
                exit(0)
            })
        }))
        window?.rootViewController?.present(alert, animated: true)
    }
    
    func sendEmailToSupport(completion: @escaping () -> Void) {
        let mailtoString = "mailto:support.sdk@Docutain.com?subject=Trial License Error&body=Please keep your following trial license key in this e-mail: \(licenseKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let mailtoUrl = URL(string: mailtoString!)!
        if UIApplication.shared.canOpenURL(mailtoUrl) {
            UIApplication.shared.open(mailtoUrl) { success in
                completion()
            }
        }
    }
}

