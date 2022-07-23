//
//  LocatePath.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import Foundation

final class ServicePath: NSObject {
    class func pathMainUrl(_ key: String) -> String? {
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "UrlService", ofType: "plist"),
              let url = NSDictionary(contentsOfFile: path) else { return nil }
        return url[key] as? String
    }
}
