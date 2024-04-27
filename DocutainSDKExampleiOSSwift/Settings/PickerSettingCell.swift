//
//  PickerSettingCell.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 11.04.24.
//

import Foundation

import Foundation
import UIKit

class PickerSettingCell: UITableViewCell, SettingCell, UIPickerViewDataSource, UIPickerViewDelegate {
    var option: PickerSetting?
    
    var pickerItems : [PickerSetting.Filter] = []
    
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
    
    let picker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
     }()
    
    let padding = 12.0
    let pickerSpacing = -8.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(picker)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        
        picker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        picker.widthAnchor.constraint(equalToConstant: 184).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 84).isActive = true
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        title.trailingAnchor.constraint(equalTo: picker.leadingAnchor, constant: pickerSpacing).isActive = true
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: picker.leadingAnchor, constant: pickerSpacing).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = pickerItems[row]
        return item.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.option?.value = pickerItems[row].value
    }

    public func configure(for option: Setting) {
        guard let pickerOption = option as? PickerSetting
        else { fatalError("Wrong option was used for configuring the cell") }

        self.title.text = pickerOption.title
        self.subtitle.text = pickerOption.subtitle
        //self.toggle.isOn = boolOption.value
        self.option = pickerOption
        self.pickerItems = pickerOption.items
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.selectRow(pickerItems.firstIndex(where: {$0.value == pickerOption.value})!, inComponent: 0, animated: false)
    }
}
