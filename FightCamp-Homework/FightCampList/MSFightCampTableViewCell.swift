//
//  MSFightCampTableViewCell.swift
//  FightCamp-Homework
//
//  Created by Michael Xu on 2022/8/18.
//  Copyright © 2022 Alexandre Marcotte. All rights reserved.
//

import UIKit
let DollarIdentification: String = "$"

//Custom tableViewCell to display package contents
class MSFightCampTableViewCell: UITableViewCell {
    static let identifier = NSStringFromClass(MSFightCampTableViewCell.self)

    //Add this attribute to the cell to mark the indexPath information
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    //Define the corresponding property to bind the viewModel
    var viewModel: MSFightCampViewModel?
    
    //Define each element in the Package page, attribute names make it easy to map controls to elements
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = CGFloat.packageRadius
        view.backgroundColor = UIColor.primaryBackground
        return view
    }()
    
    lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.brandRed
        label.font = UIFont.title
        return label
    }()

    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.label
        label.font = UIFont.body
        return label
    }()

    lazy var mainThumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.secondaryBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CGFloat.thumbnailRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    /**
     Use collectionView to display a collection of small horizontal thumbnails
     Calculate the size of the small thumbnail by displaying up to 4 at a time
     When there are more than 4 small thumbnails, we can slide the table horizontally to show more
     */
    lazy var subThumbnailColletionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = UIColor.primaryBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let width = MSSubThumbnailCollectionCell.getCellWidth()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: width, height: width)
            layout.minimumLineSpacing = CGFloat.thumbnailSpacing
            layout.scrollDirection = .horizontal
        }
        
        collectionView.register(MSSubThumbnailCollectionCell.self, forCellWithReuseIdentifier: MSSubThumbnailCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var includedInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.label
        label.font = UIFont.body
        return label
    }()
    
    lazy var excludedInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.disabledLabel
        label.font = UIFont.body
        return label
    }()
    
    lazy var paymentTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.label
        label.font = UIFont.body
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.label
        label.font = UIFont.price
        return label
    }()
    
    lazy var actionBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.buttonBackground
        button.setTitleColor(UIColor.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.button
        button.layer.cornerRadius = CGFloat.buttonRadius
        button.addTarget(self, action: #selector(actionTriggered), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.secondaryBackground
        contentView.backgroundColor = backgroundColor
        //Adds the element to the main page
        self.configContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(_ viewModel: MSFightCampViewModel) {
        self.viewModel = viewModel
    }
    
    func configContentView() {
        contentView.addSubview(mainView)
        mainView.addSubview(brandLabel)
        mainView.addSubview(descLabel)
        mainView.addSubview(mainThumbnail)
        mainView.addSubview(subThumbnailColletionView)
        mainView.addSubview(includedInfoLabel)
        mainView.addSubview(excludedInfoLabel)
        mainView.addSubview(paymentTitleLabel)
        mainView.addSubview(priceLabel)
        mainView.addSubview(actionBtn)
    }
    
    func updateContent() {
        guard let viewModel = viewModel else {
            return
        }
        
        /**
         Define a variable to flexibly assign a vertical position to each control
         For labels, use sizeToFit to automatically calculate the height
         */
        var originY = CGFloat.packageSpacing
        let width = Self.getCellWidth() - CGFloat.packageSpacing * 2
        let height = self.contentView.frame.height - CGFloat.packageSpacing

        mainView.frame = CGRect(x: CGFloat.packageSpacing, y: 0, width: Self.getCellWidth() , height: height)
        
        brandLabel.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: 0)
        brandLabel.text = viewModel.getTitleAtIndex(indexPath.item)
        brandLabel.sizeToFit()
        
        originY = brandLabel.frame.maxY + CGFloat.packageSpacing
        descLabel.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: 0)
        descLabel.text = viewModel.getDescAtIndex(indexPath.item)
        descLabel.setLineHeightMultiple(CGFloat.lineHeightMultiple)
        descLabel.sizeToFit()
        
        originY = descLabel.frame.maxY + CGFloat.packageSpacing
        mainThumbnail.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: CGFloat.thumbnailHeight)
        mainThumbnail.setWebImage(urlStr:viewModel.getMainThumbnailAtIndex(indexPath.item))
        
        originY = mainThumbnail.frame.maxY + CGFloat.thumbnailSpacing
        subThumbnailColletionView.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: MSSubThumbnailCollectionCell.getCellWidth())
        
        originY = subThumbnailColletionView.frame.maxY + CGFloat.packageSpacing
        includedInfoLabel.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: 0)
        includedInfoLabel.text = viewModel.getIncludedInfoAtIndex(indexPath.item)
        includedInfoLabel.setLineHeightMultiple(CGFloat.lineHeightMultiple)
        includedInfoLabel.sizeToFit()
        
        originY = includedInfoLabel.frame.maxY
        excludedInfoLabel.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: 0)
        excludedInfoLabel.text = viewModel.getExcludedInfosAtIndex(indexPath.item)
        excludedInfoLabel.setLineHeightMultiple(CGFloat.lineHeightMultiple)
        excludedInfoLabel.setStrikethrough()
        excludedInfoLabel.sizeToFit()
        
        originY = excludedInfoLabel.frame.maxY + CGFloat.packageSpacing
        paymentTitleLabel.text = viewModel.getPaymentIndex(indexPath.item)
        paymentTitleLabel.setLineHeightMultiple(CGFloat.lineHeightMultiple)
        paymentTitleLabel.sizeToFit()
        paymentTitleLabel.textAlignment = .center
        paymentTitleLabel.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: paymentTitleLabel.frame.size.height)

        originY = paymentTitleLabel.frame.maxY
        priceLabel.text = (DollarIdentification + "\(viewModel.getPriceAtIndex(indexPath.item))")
        priceLabel.setLineHeightMultiple(CGFloat.lineHeightMultiple)
        priceLabel.sizeToFit()
        priceLabel.textAlignment = .center
        priceLabel.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: priceLabel.frame.size.height)
        
        originY = priceLabel.frame.maxY + CGFloat.packageSpacing
        actionBtn.frame = CGRect(x: CGFloat.packageSpacing, y: originY, width: width, height: 40)
        actionBtn.setTitle(viewModel.getActionTitleAtIndex(indexPath.item), for: .normal)
    }

    class func getCellHeight(indexPath: IndexPath, viewModel: MSFightCampViewModel?) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0.0
        }
        
        let width = getCellWidth() - CGFloat.packageSpacing * 2
        
        //The line spacing of the label affects the height of the control and needs to be calculated
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = CGFloat.lineHeightMultiple
        let dic = [NSAttributedString.Key.paragraphStyle: style]
        
        //Dynamically calculates the height of all Label controls. It controls the height of the entire cell
        let brandLabelH = viewModel.getTitleAtIndex(indexPath.item).getLabelHeight(font: UIFont.title, width: width, attributes: nil)
        let descLabelH = viewModel.getDescAtIndex(indexPath.item).getLabelHeight(font: UIFont.body, width: width, attributes: dic)
        let includedInfoLabelH = viewModel.getIncludedInfoAtIndex(indexPath.item).getLabelHeight(font: UIFont.body, width: width, attributes: dic)
        let excludedInfoLabelH = viewModel.getExcludedInfosAtIndex(indexPath.item).getLabelHeight(font: UIFont.body, width: width, attributes: dic)
        let paymentTitleLabelH = viewModel.getPaymentIndex(indexPath.item).getLabelHeight(font: UIFont.body, width: width, attributes: dic)
        let priceLabelH = (DollarIdentification + "\(viewModel.getPriceAtIndex(indexPath.item))").getLabelHeight(font: UIFont.price, width: width, attributes: dic)
        
        let totalLabelH = brandLabelH + descLabelH + includedInfoLabelH + excludedInfoLabelH + paymentTitleLabelH + priceLabelH
        
        //Calculate the height of the cell based on the individual controls and the vertical spacing
        let cellHeight = CGFloat.packageSpacing * 8 + CGFloat.thumbnailSpacing + CGFloat.thumbnailHeight + MSSubThumbnailCollectionCell.getCellWidth() + CGFloat.buttonHeight + totalLabelH
        return cellHeight
    }
    
    class func getCellWidth() -> CGFloat {
        return UIScreen.main.bounds.width - CGFloat.packageSpacing * 2
    }

    //Click the View Package button on the cell to trigger the action, Only log is printed
    @objc func actionTriggered() {
        print("action Triggered~")
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegate
extension MSFightCampTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getThumbnailUrlCount(indexPath.item) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MSSubThumbnailCollectionCell.identifier, for: indexPath) as! MSSubThumbnailCollectionCell
        if let viewModel = viewModel {
            let isSelected = indexPath.item == viewModel.getSelectThumbnailIndex(self.indexPath.item)
            //Change the border display for each small thumbnail
            cell.updateThumbnailState(isSelected: isSelected)
            //Update the image display of small thumbnails
            cell.updateContent(url: viewModel.getThumbnailUrlAtIndex(self.indexPath.item, indexPath.item))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curCell = collectionView.cellForItem(at: indexPath)
        let cells = collectionView.visibleCells
        for cell in cells {
            //Clicking a cell will make it selected, change the border color, and restore the unselected state of other cells
            (cell as? MSSubThumbnailCollectionCell)?.updateThumbnailState(isSelected: cell == curCell)
        }
        
        if let viewModel = viewModel {
            //The selected location is updated to the Model through the viewModel
            viewModel.updateSelectedThumbnailIndex(self.indexPath.item, indexPath.item)
            //Update the main image based on the small selected thumbnail
            mainThumbnail.setWebImage(urlStr: viewModel.getMainThumbnailAtIndex(self.indexPath.item))
        }
    }
}
