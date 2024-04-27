//
//  ViewControllerSettings.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 10.04.24.
//

import Foundation
import UIKit
import DocutainSdk

class ViewControllerSettings : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var headers : [String] = ["Color Settings", "Scan Settings", "Edit Settings"]
    var settingsItems : [[Setting]] = [[]]
    let tableView = UITableView()
    let resetButton = UIButton()
    
    
    
    override func viewDidLoad() {
        
        navigationItem.backButtonTitle = ""
        title = "Settings".localized()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        
        loadItems()
        
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        if #available(iOS 13.0, *) {
            resetButton.backgroundColor = UIColor.systemFill
        } else {
            // Fallback on earlier versions
            resetButton.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        }
        resetButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        resetButton.layer.cornerRadius = 8
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0 ? 0 : -12).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -12).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.tableView.registerCell(cell: BoolSettingCell.self)
        self.tableView.registerCell(cell: PickerSettingCell.self)
        self.tableView.registerCell(cell: ColorSettingCell.self)

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadItems(){
        settingsItems = [
            [
                ColorSetting(settingType: .colorPrimary, initialValue: DocutainPreferences.ColorPrimary) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorSecondary, initialValue: DocutainPreferences.ColorSecondary) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorOnSecondary, initialValue: DocutainPreferences.ColorOnSecondary) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorScanButtonsLayoutBackground, initialValue: DocutainPreferences.ColorScanButtonsLayoutBackground) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorScanButtonsForeground, initialValue: DocutainPreferences.ColorScanButtonsForeground) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorScanPolygon, initialValue: DocutainPreferences.ColorScanPolygon) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorBottomBarBackground, initialValue: DocutainPreferences.ColorBottomBarBackground) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorBottomBarForeground, initialValue: DocutainPreferences.ColorBottomBarForeground) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorTopBarBackground, initialValue: DocutainPreferences.ColorTopBarBackground) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
                ColorSetting(settingType: .colorTopBarForeground, initialValue: DocutainPreferences.ColorTopBarForeground) { colorLight, colorDark, type in self.colorHandler(colorLight: colorLight, colorDark: colorDark, settingsType: type)},
            ],
            [
                BoolSetting(settingType: .allowCaptureModeSetting, initialValue: DocutainPreferences.AllowCaptureModeSetting) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .autoCapture, initialValue: DocutainPreferences.AutoCapture) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .autoCrop, initialValue: DocutainPreferences.AutoCrop) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .multiPage, initialValue: DocutainPreferences.MultiPage) { value, type in self.boolHandler(value: value, settingsType: type)},
                PickerSetting(settingType: .defaultScanFilter, initialValue: DocutainPreferences.DefaultScanFilter, items: [.auto, .gray, .blackWhite, .original, .text, .auto2, .illustration]) { filter, type in self.filterHandler(filter: filter)}
            ],
            [
                BoolSetting(settingType: .allowPageFilter, initialValue: DocutainPreferences.AllowPageFilter) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .allowPageRotation, initialValue: DocutainPreferences.AllowPageRotation) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .allowPageArrangement, initialValue: DocutainPreferences.AllowPageArrangement) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .allowPageCropping, initialValue: DocutainPreferences.AllowPageCropping) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .pageArrangementShowDeleteButton, initialValue: DocutainPreferences.PageArrangementShowDeleteButton) { value, type in self.boolHandler(value: value, settingsType: type)},
                BoolSetting(settingType: .pageArrangementShowPageNumber, initialValue: DocutainPreferences.PageArrangementShowPageNumber) { value, type in self.boolHandler(value: value, settingsType: type)}
            ]
        ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsItems[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentOption = self.settingsItems[indexPath.section][indexPath.row]

        guard let cellType = Self.cellType(for: type(of: currentOption)) as? UITableViewCell.Type,
              let cell = self.tableView.dequeueCell(cell: cellType)
        else { return .init() }

        (cell as? SettingCell)?.configure(for: currentOption)

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(named: "AccentColor")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsItems.count
    }
    
    @objc private func resetButtonTapped(sender: UIButton!){
        DocutainPreferences.reset()
        loadItems()
        tableView.reloadData()
    }
    
    private func boolHandler(value: Bool, settingsType: SettingType){
        DocutainPreferences.setBoolValue(value: value, settingType: settingsType)
    }
    
    private func filterHandler(filter: ScanFilter){
        DocutainPreferences.setFilterValue(filter: filter)
    }
    
    private func colorHandler(colorLight: UIColor, colorDark: UIColor, settingsType: SettingType){
        DocutainPreferences.setColorValues(colorLight: colorLight, colorDark: colorDark, settingType: settingsType)
    }
    
    private static var registeredTypes: [ObjectIdentifier: SettingCell.Type] = [
            ObjectIdentifier(BoolSetting.self): BoolSettingCell.self,
            ObjectIdentifier(PickerSetting.self): PickerSettingCell.self,
            ObjectIdentifier(ColorSetting.self): ColorSettingCell.self
        ]
    
    private static func cellType(for modelType: Setting.Type) -> SettingCell.Type? {
        let typeId = ObjectIdentifier(modelType)
        return Self.registeredTypes[typeId]
    }
}
