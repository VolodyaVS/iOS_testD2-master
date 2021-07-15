//
//  CacheWithTimeInterval.swift
//  TestAppD1
//
//  Created by  on 24/01/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class CacheWithTimeInterval {

    class func objectForKey(_ key: String) -> Data? {
        var arrayOfCachedData: [Data] = []

        if UserDefaults.standard.array(forKey: "cache") != nil {
            arrayOfCachedData = UserDefaults.standard.array(forKey: "cache") as! [Data]
        } else {
            arrayOfCachedData = []
        }

        var mutableArrayOfCachedData = arrayOfCachedData
        var deletedCount = 0
        var objectFromCachedData: Data?

        for (index, data) in arrayOfCachedData.enumerated() {
            let storedData = try! PropertyListDecoder().decode(StoredData.self, from: data)
            if abs(storedData.date.timeIntervalSinceNow) < 5 * 60 {
                if storedData.key == key {
                    objectFromCachedData = storedData.data
                }
            } else {
                mutableArrayOfCachedData.remove(at: index - deletedCount)
                deletedCount += 1
                UserDefaults.standard.set(mutableArrayOfCachedData, forKey: "cache")
            }
        }
        return objectFromCachedData
    }
    
    class func set(data: Data?, for key: String) {
        var arrayOfCachedData: [Data] = []

        if UserDefaults.standard.array(forKey: "cache") != nil {
            arrayOfCachedData = UserDefaults.standard.array(forKey: "cache") as! [Data]
        }

        if data != nil {
            if CacheWithTimeInterval.objectForKey(key) == nil {
                let storedData = StoredData(key: key, date: Date(), data: data!)
                let data = try? PropertyListEncoder().encode(storedData)
                arrayOfCachedData.append(data!)
            }
        }
        UserDefaults.standard.set(arrayOfCachedData, forKey: "cache")
    }
}
