//
//  ColorSettingCell.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 11.04.24.
//

import Foundation
import UIKit

class ColorSettingCell: UITableViewCell, UIColorPickerViewControllerDelegate, SettingCell {
        
    var option: ColorSetting?
    var darkColorSelected = false
    
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
    
    let lightColorButton : UIButton = {
        let lightColorButton = UIButton()
        lightColorButton.translatesAutoresizingMaskIntoConstraints = false
        return lightColorButton
     }()
    
    let lightColorLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Light"
        lbl.font = UIFont.systemFont(ofSize: 14)
        if #available(iOS 13.0, *) {
            lbl.textColor = .secondaryLabel
        }
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
     }()
    
    let darkColorButton : UIButton = {
        let darkColorButton = UIButton()
        darkColorButton.translatesAutoresizingMaskIntoConstraints = false
        return darkColorButton
     }()
    
    let darkColorLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Dark"
        lbl.font = UIFont.systemFont(ofSize: 14)
        if #available(iOS 13.0, *) {
            lbl.textColor = .secondaryLabel
        }
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
     }()
    
    let padding = 12.0
    let colorSpacing = -24.0
    let colorTitleSpacing = -36.0
    let colorSubtitleSpacing = 8.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        darkColorButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        lightColorButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        let colorPickerView = UIView()
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false
        colorPickerView.addSubview(lightColorButton)
        colorPickerView.addSubview(darkColorButton)
        colorPickerView.addSubview(lightColorLabel)
        colorPickerView.addSubview(darkColorLabel)
        
        darkColorButton.topAnchor.constraint(equalTo: colorPickerView.topAnchor).isActive = true
        darkColorButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        darkColorButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        darkColorButton.trailingAnchor.constraint(equalTo: colorPickerView.trailingAnchor).isActive = true
        darkColorButton.layer.cornerRadius = 18
        darkColorButton.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            darkColorButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        } else{
            darkColorButton.layer.borderColor = UIColor.gray.cgColor
        }
        
        darkColorLabel.centerXAnchor.constraint(equalTo: darkColorButton.centerXAnchor).isActive = true
        darkColorLabel.topAnchor.constraint(equalTo: darkColorButton.bottomAnchor, constant: colorSubtitleSpacing).isActive = true
        
        lightColorButton.topAnchor.constraint(equalTo: colorPickerView.topAnchor).isActive = true
        lightColorButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        lightColorButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lightColorButton.trailingAnchor.constraint(equalTo: darkColorButton.leadingAnchor, constant: colorSpacing).isActive = true
        lightColorButton.layer.cornerRadius = 18
        lightColorButton.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            lightColorButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        } else{
            lightColorButton.layer.borderColor = UIColor.gray.cgColor
        }
        
        lightColorLabel.centerXAnchor.constraint(equalTo: lightColorButton.centerXAnchor).isActive = true
        lightColorLabel.topAnchor.constraint(equalTo: lightColorButton.bottomAnchor, constant: colorSubtitleSpacing).isActive = true
        
        contentView.addSubview(colorPickerView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        
        colorPickerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        colorPickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        colorPickerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        colorPickerView.widthAnchor.constraint(equalToConstant: 84).isActive = true
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        title.trailingAnchor.constraint(equalTo: colorPickerView.leadingAnchor, constant: colorTitleSpacing).isActive = true
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: colorPickerView.leadingAnchor, constant: colorTitleSpacing).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClicked(_ sender: UIButton){
        darkColorSelected = sender == darkColorButton
        if #available(iOS 14.0, *) {
            let colorPicker = UIColorPickerViewController()
            colorPicker.title = darkColorSelected ? "Pick Dark Color" : "Pick Light Color"
            colorPicker.supportsAlpha = false
            colorPicker.delegate = self
            colorPicker.modalPresentationStyle = .popover
            colorPicker.popoverPresentationController?.sourceView = sender
            UIApplication.shared.keyWindow?.rootViewController?.present(colorPicker, animated: true)
        } else {
            // Fallback on earlier versions
            let alert = UIAlertController(title: "Info", message: "UIColorPickerViewController is not supported for iOS versions below 14. If you want to present a color picker to your users using iOS versions below 14, you need to implement your own color picker.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
        }
    }

    public func configure(for option: Setting) {
        guard let colorOption = option as? ColorSetting
        else { fatalError("Wrong option was used for configuring the cell") }

        self.title.text = option.title
        self.subtitle.text = option.subtitle
        self.darkColorButton.backgroundColor = colorOption.colorDark
        self.lightColorButton.backgroundColor = colorOption.colorLight
        self.option = colorOption
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        viewController.dismiss(animated: true)
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        if(darkColorSelected){
            option?.colorDark = viewController.selectedColor
            darkColorButton.backgroundColor = viewController.selectedColor
        } else{
            option?.colorLight = viewController.selectedColor
            lightColorButton.backgroundColor = viewController.selectedColor
        }
    }
    
    @available(iOS 15.0, *)
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if(continuously){
            return
        }
        if(darkColorSelected){
            option?.colorDark = viewController.selectedColor
            darkColorButton.backgroundColor = viewController.selectedColor
        } else{
            option?.colorLight = viewController.selectedColor
            lightColorButton.backgroundColor = viewController.selectedColor
        }
    }
}
