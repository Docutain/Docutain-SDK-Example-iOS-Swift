//
//  TableViewCell.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 16.03.23.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
     }()
     
    let subtitle : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            lbl.textColor = .secondaryLabel
        }
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
     }()
    
    let icon : UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
     }()
    
    let padding = 16.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        
        icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 42).isActive = true
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: padding).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: padding).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
