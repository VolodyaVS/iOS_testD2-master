//
//  FabricRequest.swift
//  TestAppD1
//
//  Created by  on 24/01/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class FabricRequest {

    private static let protocolHostPath = "https://api.stackexchange.com/2.2/questions"
    private static let parameter = "order=desc&sort=activity&site=stackoverflow&key=G*0DJzE8SfBrKn4tMej85Q(("
    
    class func request(tagged stringTagged: String?,
                       numberOfPageToLoad: Int,
                       withBlock completionHandler: @escaping (_ data: Data?) -> Void) {

        guard let stringTag = stringTagged else { return }
        let stringURL = protocolHostPath + "?" + parameter + "&pagesize=50&tagged=" + stringTag + String(format: "&page=%ld", numberOfPageToLoad)

        if CacheWithTimeInterval.objectForKey(stringURL) == nil {
            guard let url = URL(string: stringURL) else { return }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error { print(error); return }
                if let response = response { print(response) }
                guard let data = data else { return }
                completionHandler(data)
                CacheWithTimeInterval.set(data: data, for: stringURL)
            }.resume()
        } else {
            completionHandler(CacheWithTimeInterval.objectForKey(stringURL))
        }
    }
    
    class func request(withQuestionID questionID: Int,
                       withBlock completionHandler: @escaping (_ data: Data?) -> Void) {
        let stringURL = String(format: "%@/%li/answers?%@&filter=!9YdnSMKKT",
                               protocolHostPath,
                               questionID,
                               parameter)

        guard let url = URL(string: stringURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            if let response = response { print(response) }
            guard let data = data else { return }
            completionHandler(data)
        }.resume()
    }
}
