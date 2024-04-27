//
//  PickerSetting.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 11.04.24.
//

import Foundation
import DocutainSdk

public class PickerSetting: Setting {
        
    public enum Filter {
        case auto
        case gray
        case blackWhite
        case original
        case text
        case auto2
        case illustration
        
        var description: String {
            switch self {
            case .auto:
                return "Auto"
            case .gray:
                return "Gray"
            case .blackWhite:
                return "Black & White"
            case .original:
                return "Original"
            case .text:
                return "Text"
            case .auto2:
                return "Auto 2"
            case .illustration:
                return "Illustration"
            }
        }
        
        var value: ScanFilter {
            switch self {
            case .auto:
                return ScanFilter.auto
            case .gray:
                return ScanFilter.gray
            case .blackWhite:
                return ScanFilter.blackWhite
            case .original:
                return ScanFilter.original
            case .text:
                return ScanFilter.text
            case .auto2:
                return ScanFilter.auto2
            case .illustration:
                return ScanFilter.illustration
            }
        }
    }
    
    public typealias Handler = (ScanFilter, SettingType) -> Void

    public let settingType: SettingType
    public let title: String
    public let subtitle: String
    public let items: [Filter]
    public internal(set) var value: ScanFilter {
        didSet { self.onChangeHandler(self.value, self.settingType) }
    }
    public let onChangeHandler: Handler

    public init(settingType: SettingType,
                initialValue: ScanFilter,
                items: [Filter],
                onChangeHandler: @escaping Handler) {
        self.title = settingType.rawValue.localized()
        self.subtitle = "\(settingType.rawValue)_Description".localized()
        self.value = initialValue
        self.settingType = settingType
        self.items = items
        self.onChangeHandler = onChangeHandler
    }
}
