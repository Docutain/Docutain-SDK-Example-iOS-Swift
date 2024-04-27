//
//  Setting.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 10.04.24.
//

import Foundation

public enum SettingType: String{
    case allowCaptureModeSetting
    case autoCapture
    case autoCrop
    case multiPage
    case defaultScanFilter
    case allowPageFilter
    case allowPageRotation
    case allowPageArrangement
    case allowPageCropping
    case pageArrangementShowDeleteButton
    case pageArrangementShowPageNumber
    case colorPrimary
    case colorSecondary
    case colorOnSecondary
    case colorScanButtonsLayoutBackground
    case colorScanButtonsForeground
    case colorScanPolygon
    case colorBottomBarBackground
    case colorBottomBarForeground
    case colorTopBarBackground
    case colorTopBarForeground
    
}

public protocol Setting: AnyObject {
    var settingType: SettingType { get }
    var title: String { get }
    var subtitle: String { get }
}

