//
//  MSFightCampModel.swift
//  FightCamp-Homework
//
//  Created by Michael Xu on 2022/8/19.
//  Copyright © 2022 Alexandre Marcotte. All rights reserved.
//

struct MSFightCampModel: Codable {
    var title: String?
    var desc: String?
    var thumbnail_urls: [String?]?
    var included: [String]?
    var excluded: [String]?
    var payment: String?
    var price: Double?
    var action: String?
    var thumbnailSelectIndex: Int?
}
