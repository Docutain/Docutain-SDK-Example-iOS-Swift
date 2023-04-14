//
//  Extensions.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 15.03.23.
//

import Foundation

internal extension String{
    func localized() -> Self{
        return NSLocalizedString(self, comment: "")
    }
}
