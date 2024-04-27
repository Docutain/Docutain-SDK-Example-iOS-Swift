//
//  SettingsSwiftCell.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 10.04.24.
//

import Foundation
import UIKit

class BoolSettingCell: UITableViewCell, SettingCell {
        
    var option: BoolSetting?
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
     }()
     
    let subtitle : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        if #available(iOS 13.0, *) {
            lbl.textColor = .secondaryLabel
        }
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
     }()
    
    let toggle : UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
     }()
    
    let padding = 12.0
    let switchSpacing = -24.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.toggle.addTarget(self, action: #selector(self.valueChanged(_:)), for: .valueChanged)
        
        contentView.addSubview(toggle)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        
        toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        toggle.widthAnchor.constraint(equalToConstant: 58).isActive = true
        toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        title.trailingAnchor.constraint(equalTo: toggle.leadingAnchor, constant: switchSpacing).isActive = true
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: toggle.leadingAnchor, constant: switchSpacing).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func valueChanged(_ sender: UISwitch) {
        self.option?.value = sender.isOn
    }

    public func configure(for option: Setting) {
        guard let boolOption = option as? BoolSetting
        else { fatalError("Wrong option was used for configuring the cell") }

        self.title.text = option.title
        self.subtitle.text = option.subtitle
        self.toggle.isOn = boolOption.value
        self.option = boolOption
    }
}
