//
//  BoolSetting.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 10.04.24.
//

import Foundation

public class BoolSetting: Setting {
    
    public typealias Handler = (Bool, SettingType) -> Void

    public let settingType: SettingType
    public let title: String
    public let subtitle: String
    public internal(set) var value: Bool {
        didSet { self.onChangeHandler(self.value, self.settingType) }
    }
    public let onChangeHandler: Handler

    public init(settingType: SettingType,
                initialValue: Bool,
                onChangeHandler: @escaping Handler) {
        self.title = settingType.rawValue.localized()
        self.subtitle = "\(settingType.rawValue)_Description".localized()
        self.value = initialValue
        self.settingType = settingType
        self.onChangeHandler = onChangeHandler
    }
}
