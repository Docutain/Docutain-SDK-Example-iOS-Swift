//
//  ColorSetting.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 11.04.24.
//

import Foundation
import UIKit

public class ColorSetting: Setting {
    
    public typealias Handler = (UIColor, UIColor, SettingType) -> Void

    public let settingType: SettingType
    public let title: String
    public let subtitle: String
    public internal(set) var colorLight: UIColor {
        didSet { self.onChangeHandler(self.colorLight,self.colorDark, self.settingType) }
    }
    public internal(set) var colorDark: UIColor {
        didSet { self.onChangeHandler(self.colorLight,self.colorDark, self.settingType) }
    }
    public let onChangeHandler: Handler

    public init(settingType: SettingType,
                initialValue: [String : String],
                onChangeHandler: @escaping Handler) {
        self.title = settingType.rawValue.localized()
        self.subtitle = "\(settingType.rawValue)_Description".localized()
        self.colorLight = UIColor(hexString: initialValue["light"]!)
        self.colorDark = UIColor(hexString: initialValue["dark"]!)
        self.settingType = settingType
        self.onChangeHandler = onChangeHandler
    }
}
