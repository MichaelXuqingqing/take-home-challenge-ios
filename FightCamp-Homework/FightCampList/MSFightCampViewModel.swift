//
//  MSFightCampViewModel.swift
//  FightCamp-Homework
//
//  Created by Michael Xu on 2022/8/18.
//  Copyright © 2022 Alexandre Marcotte. All rights reserved.
//

import UIKit

class MSFightCampViewModel {
    //The local JSON string is read out and stored as an array of models
    lazy var data: [MSFightCampModel] = JsonTool.readJsonFile(type: MSFightCampModel.self)
    
    
    func getTitleAtIndex(_ pageIndex: Int) -> String {
        guard pageIndex < data.count else {
            return PROPERTY_DEFAULT_STRING
        }
        return data[pageIndex].title?.uppercased() ?? PROPERTY_DEFAULT_STRING
    }
    
    func getDescAtIndex(_ pageIndex: Int) -> String {
        guard pageIndex < data.count else {
            return PROPERTY_DEFAULT_STRING
        }
        return data[pageIndex].desc?.capitalized ?? PROPERTY_DEFAULT_STRING
    }
    
    func getMainThumbnailAtIndex(_ pageIndex: Int) -> String {
        if pageIndex < data.count {
            let index = data[pageIndex].thumbnailSelectIndex ?? 0
            if let thumbnailUrls = data[pageIndex].thumbnail_urls, index < thumbnailUrls.count {
                return thumbnailUrls[index] ?? PROPERTY_DEFAULT_STRING
            }
        }
        return PROPERTY_DEFAULT_STRING
    }
    
    func getThumbnailUrlCount(_ pageIndex: Int) -> Int {
        if pageIndex < data.count {
            if let thumbnailUrls = data[pageIndex].thumbnail_urls {
                return thumbnailUrls.count
            }
        }
        return 0
    }
    
    func getSelectThumbnailIndex(_ pageIndex: Int) -> Int {
        guard pageIndex < data.count else {
            return 0
        }
        return data[pageIndex].thumbnailSelectIndex ?? 0
    }
    
    func updateSelectedThumbnailIndex(_ pageIndex: Int, _ selectedIndex: Int) {
        if pageIndex < data.count {
            data[pageIndex].thumbnailSelectIndex = selectedIndex
        }
    }
    
    func getThumbnailUrlAtIndex(_ pageIndex: Int, _ thumbnailIndex: Int) -> String {
        if pageIndex < data.count {
            if let thumbnailUrls = data[pageIndex].thumbnail_urls, thumbnailIndex < thumbnailUrls.count {
                return thumbnailUrls[thumbnailIndex] ?? PROPERTY_DEFAULT_STRING
            }
        }
        return PROPERTY_DEFAULT_STRING
    }
    
    func getIncludedInfoAtIndex(_ pageIndex: Int) -> String {
        guard pageIndex < data.count else {
            return PROPERTY_DEFAULT_STRING
        }
        return data[pageIndex].included?.joined(separator: "\n").capitalized ?? PROPERTY_DEFAULT_STRING
    }
    
    func getExcludedInfosAtIndex(_ pageIndex: Int) -> String {
        guard pageIndex < data.count else {
            return PROPERTY_DEFAULT_STRING
        }
        return data[pageIndex].excluded?.joined(separator: "\n").capitalized ?? PROPERTY_DEFAULT_STRING
    }
    
    func getPaymentIndex(_ pageIndex: Int) -> String {
        guard pageIndex < data.count else {
            return PROPERTY_DEFAULT_STRING
        }
        return data[pageIndex].payment?.capitalized ?? PROPERTY_DEFAULT_STRING
    }
    
    func getPriceAtIndex(_ pageIndex: Int) -> String {
        var price = PROPERTY_DEFAULT_DOUBLE
        if pageIndex < data.count, let p = data[pageIndex].price {
            price = p
        }
        if price - Double(Int(price)) == 0 {
            return "\(Int(price))"
        }
        return "\(price)"
    }
    
    func getActionTitleAtIndex(_ pageIndex: Int) -> String {
        guard pageIndex < data.count else {
            return PROPERTY_DEFAULT_STRING
        }
        return data[pageIndex].action?.capitalized ?? PROPERTY_DEFAULT_STRING
    }
}
