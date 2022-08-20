//
//  JsonTool.swift
//  FightCamp-Homework
//
//  Created by Michael Xu on 2022/8/19.
//  Copyright © 2022 Alexandre Marcotte. All rights reserved.
//

import Foundation
let PROPERTY_DEFAULT_STRING: String = ""
let PROPERTY_DEFAULT_DOUBLE: Double = 0.0
let PROPERTY_DEFAULT_INT: Int = 0

/**
 An easy way to read out the local JSON file and convert it to the specified model
 The conversion type can be specified at read time
 */
class JsonTool {
    class func readJsonFile<T: Codable>(type: T.Type) -> [T] {
        let path = Bundle.main.path(forResource: "packages", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        var retArr = [T]()
        do {
            let data = try Data.init(contentsOf: url)
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonArr = jsonData as! Array<Any>
            for dict in jsonArr {
                if let info = self.jsonToModel(type, dict) {
                    retArr.append(info)
                }
            }
        } catch let error as Error? {
            print("Reading local data error: \(error.debugDescription)")
        }
        return retArr
    }
    
    private class func jsonToModel<T: Codable>(_ modelType: T.Type, _ response: Any) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: response), let info = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return info
    }
}
