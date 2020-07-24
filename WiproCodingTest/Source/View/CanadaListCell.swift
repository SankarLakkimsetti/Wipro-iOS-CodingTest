//
//  CanadaListCell.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 22/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit

class CanadaListCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: (UIDevice.current.userInterfaceIdiom == .pad) ? 25 : 16)
        label.textColor = UIColor(red: 7/255, green: 71/255, blue: 89/255, alpha: 1)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.numberOfLines = 0
        descriptionLbl.lineBreakMode = .byWordWrapping
        descriptionLbl.font =  UIFont.systemFont(ofSize: (UIDevice.current.userInterfaceIdiom == .pad) ? 20 : 14)
        descriptionLbl.textColor = .darkGray
        return descriptionLbl
    }()
    
    lazy var profileImageView: UIImageView = {
        let canadaImageVw = UIImageView()
        canadaImageVw.translatesAutoresizingMaskIntoConstraints = false
        canadaImageVw.contentMode = .scaleAspectFill
        canadaImageVw.layer.cornerRadius = 25
        canadaImageVw.image = UIImage.init(named: "placeholder")
        canadaImageVw.clipsToBounds = true
        return canadaImageVw
    }()
    
    var canadaEachRowData: Rows! {
        didSet {
            titleLabel.text = (canadaEachRowData.title != nil) ? canadaEachRowData.title : "No Title"
            descriptionLabel.text = (canadaEachRowData.description != nil) ? canadaEachRowData.description : "No Description"
            if let imageURL = canadaEachRowData.imageHref {
                profileImageView.loadImageUsingCache(withUrl: imageURL, placeHolder: UIImage.init(named: "placeholder"))
            }
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(profileImageView)
        
        // Set up constraints for cell items
        
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -15).isActive = true
        
        descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
         
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
