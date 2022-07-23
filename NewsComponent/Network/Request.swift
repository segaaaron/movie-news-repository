//
//  Request.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import UIKit
import Foundation

final class Request: NSObject {
    var url: String?
    var params: [String: Any]? = nil
    var timeout: TimeInterval?
    var method: HTTPMETHOD = .GET
    var endPointPath: String?
}

final class ApiRequest: NSObject {
    static func getRequest(with requestModel: Request) -> URLRequest? {
        guard let pathUrl = requestModel.url,
              let endPoint = requestModel.endPointPath,
              let timeOut = requestModel.timeout,
              var component = URLComponents(string: pathUrl + endPoint) else { return nil }
        
        let paramString: [String: String] = requestModel.params?.compactMapValues { $0 as? String } ?? [:]
        
        if requestModel.method == .GET {
            component.queryItems = paramString.map {(key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        guard let currentUrl = component.url else { return nil }
        var request = URLRequest(url: currentUrl)
        
        if requestModel.method != .GET {
            if let paramsData = requestModel.params {
                let jsonData = try? JSONSerialization.data(withJSONObject: paramsData)
                request.httpBody = jsonData
            }
        }
        
        request.httpMethod = requestModel.method.rawValue
        request.timeoutInterval = timeOut
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
}
