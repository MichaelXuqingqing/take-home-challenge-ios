//
//  MSSubThumbnailCollectionCell.swift
//  FightCamp-Homework
//
//  Created by Michael Xu on 2022/8/18.
//  Copyright © 2022 Alexandre Marcotte. All rights reserved.
//

import UIKit

class MSSubThumbnailCollectionCell: UICollectionViewCell {
    static let identifier = NSStringFromClass(MSSubThumbnailCollectionCell.self)
    
    //Define to display up to 4 small thumbnails per page, and calculate the small thumbnail size automatically based on this
    static let MaxThumbnailCount = 4

    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.secondaryBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CGFloat.thumbnailRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        innerInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        innerInit()
    }
    
    func innerInit() {
        thumbnail.frame = CGRect(x: 0, y: 0, width: Self.getCellWidth(), height: Self.getCellWidth())
        contentView.addSubview(thumbnail)
        
        updateThumbnailState(isSelected: false)
    }
    
    func updateContent(url: String) {
        thumbnail.setWebImage(urlStr: url)
    }
    
    func updateThumbnailState(isSelected: Bool) {
        thumbnail.layer.borderColor = UIColor.thumbnailBorder(selected: isSelected).cgColor
        thumbnail.layer.borderWidth = CGFloat.thumbnailBorderWidth
    }
        
    //Calculate the size of the small thumbnail based on the set value
    class func getCellWidth() -> CGFloat {
        let value: CGFloat = CGFloat(MaxThumbnailCount)
        return (MSFightCampTableViewCell.getCellWidth() - CGFloat.packageSpacing * 2 - CGFloat.thumbnailSpacing * (value - 1)) / value
    }
}
