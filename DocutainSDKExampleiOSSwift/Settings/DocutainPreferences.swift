//
//  DocutainPreferences.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 10.04.24.
//

import Foundation
import DocutainSdk
import UIKit

class DocutainPreferences{
    
    static var AllowCaptureModeSetting: Bool {
        get { return UserDefaults.standard.object(forKey: "AllowCaptureModeSetting") as? Bool ?? false }
        set { UserDefaults.standard.set(newValue, forKey: "AllowCaptureModeSetting") }
    }
    
    static var AutoCapture: Bool {
        get { return UserDefaults.standard.object(forKey: "AutoCapture") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "AutoCapture") }
    }
    
    static var AutoCrop: Bool {
        get { return UserDefaults.standard.object(forKey: "AutoCrop") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "AutoCrop") }
    }
    
    static var MultiPage: Bool {
        get { return UserDefaults.standard.object(forKey: "MultiPage") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "MultiPage") }
    }
    
    static var DefaultScanFilter: ScanFilter {
        get 
        {
            if let savedFilter = UserDefaults.standard.object(forKey: "DefaultScanFilter") as? Int{
                if let scanFilter = ScanFilter(rawValue: savedFilter){
                    return scanFilter
                } else{
                    return ScanFilter.illustration
                }
            }else{
                return ScanFilter.illustration
            }
        }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: "DefaultScanFilter") }
    }
    
    static var AllowPageFilter: Bool {
        get { return UserDefaults.standard.object(forKey: "AllowPageFilter") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "AllowPageFilter") }
    }
    
    static var AllowPageRotation: Bool {
        get { return UserDefaults.standard.object(forKey: "AllowPageRotation") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "AllowPageRotation") }
    }
    
    static var AllowPageArrangement: Bool {
        get { return UserDefaults.standard.object(forKey: "AllowPageArrangement") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "AllowPageArrangement") }
    }
    
    static var AllowPageCropping: Bool {
        get { return UserDefaults.standard.object(forKey: "AllowPageCropping") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "AllowPageCropping") }
    }
    
    static var PageArrangementShowDeleteButton: Bool {
        get { return UserDefaults.standard.object(forKey: "PageArrangementShowDeleteButton") as? Bool ?? false }
        set { UserDefaults.standard.set(newValue, forKey: "PageArrangementShowDeleteButton") }
    }
    
    static var PageArrangementShowPageNumber: Bool {
        get { return UserDefaults.standard.object(forKey: "PageArrangementShowPageNumber") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "PageArrangementShowPageNumber") }
    }
    
    static var ColorPrimary: [String: String] {
        get { return UserDefaults.standard.dictionary(forKey: "ColorPrimary") as? [String: String] ?? ["light": "#4caf50",
                                                                                                       "dark":  "#4caf50"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorPrimary") }
    }
    
    static var ColorSecondary: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorSecondary") as? [String: String] ?? ["light": "#4caf50",
                                                                                                     "dark":  "#4caf50"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorSecondary") }
    }
    
    static var ColorOnSecondary: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorOnSecondary") as? [String: String] ?? ["light": "#ffffff",
                                                                                                      "dark":  "#000000"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorOnSecondary") }
    }
    
    static var ColorScanButtonsLayoutBackground: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorScanButtonsLayoutBackground") as? [String: String] ?? ["light": "#121212",
                                                                                                                       "dark":  "#121212"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorScanButtonsLayoutBackground") }
    }
    
    static var ColorScanButtonsForeground: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorScanButtonsForeground") as? [String: String] ?? ["light": "#ffffff",
                                                                                                                 "dark":  "#ffffff"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorScanButtonsForeground") }
    }
    
    static var ColorScanPolygon: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorScanPolygon") as? [String: String] ?? ["light": "#4caf50",
                                                                                                       "dark":  "#4caf50"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorScanPolygon") }
    }
    
    static var ColorBottomBarBackground: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorBottomBarBackground") as? [String: String] ?? ["light": "#ffffff",
                                                                                                               "dark":  "#212121"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorBottomBarBackground") }
    }
    
    static var ColorBottomBarForeground: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorBottomBarForeground") as? [String: String] ?? ["light": "#323232",
                                                                                                               "dark":  "#bebebe"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorBottomBarForeground") }
    }
    
    static var ColorTopBarBackground: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorTopBarBackground") as? [String: String] ?? ["light": "#4caf50",
                                                                                                            "dark":  "#2a2a2a"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorTopBarBackground") }
    }
    
    static var ColorTopBarForeground: [String: String] {
        get { return UserDefaults.standard.object(forKey: "ColorTopBarForeground") as? [String: String] ?? ["light": "#ffffff",
                                                                                                            "dark":  "#ffffff"] }
        set { UserDefaults.standard.set(newValue, forKey: "ColorTopBarForeground") }
    }
    
    static func setBoolValue(value: Bool, settingType: SettingType){
        switch settingType{
        case .allowCaptureModeSetting:
            AllowCaptureModeSetting = value
        case .autoCapture:
            AutoCapture = value
        case .autoCrop:
            AutoCrop = value
        case .multiPage:
            MultiPage = value
        case .allowPageFilter:
            AllowPageFilter = value
        case .allowPageRotation:
            AllowPageRotation = value
        case .allowPageArrangement:
            AllowPageArrangement = value
        case .allowPageCropping:
            AllowPageCropping = value
        case .pageArrangementShowDeleteButton:
            PageArrangementShowDeleteButton = value
        case .pageArrangementShowPageNumber:
            PageArrangementShowPageNumber = value
        default:
            print("Invalid value")
        }
    }
    
    static func setFilterValue(filter: ScanFilter){
        DefaultScanFilter = filter
    }
    
    static func setColorValues(colorLight: UIColor, colorDark: UIColor, settingType: SettingType){
        switch settingType{
        case .colorPrimary:
            ColorPrimary = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorSecondary:
            ColorSecondary = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorOnSecondary:
            ColorOnSecondary = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorScanButtonsLayoutBackground:
            ColorScanButtonsLayoutBackground = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorScanButtonsForeground:
            ColorScanButtonsForeground = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorScanPolygon:
            ColorScanPolygon = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorBottomBarBackground:
            ColorBottomBarBackground = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorBottomBarForeground:
            ColorBottomBarForeground = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorTopBarBackground:
            ColorTopBarBackground = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        case .colorTopBarForeground:
            ColorTopBarForeground = ["light": colorLight.hexString,
                            "dark": colorDark.hexString]
        default:
            print("Invalid value")
        }
    }
    
    static func reset(){
        //for the sake of simplicity, we reset all of the UserDefaults
        //if you want to use this in your own app, be aware that this deletes ALL of the userdefaults, not just the Docutain keys
        //it also causes the onboarding dialog to reappear when opening the camera
        //if you don't want that, you need to reset each single key manually
        UserDefaults.standard.dictionaryRepresentation().keys.forEach(UserDefaults.standard.removeObject(forKey:))
    }
}
