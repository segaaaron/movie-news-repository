//
//  Network.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import Foundation
import UIKit

let cacheDownload = NSCache<NSString, UIImage>()
final class Network {
    static func callService<T: Decodable>(with
                                          method: HTTPMETHOD,
                                          model: T.Type,
                                          endPoint: ENDPOINT,
                                          parameters: [String: Any] = [:],
                                          completion: @escaping (Result<T, Error>?) -> Void ){
        
        let request = Request()
        request.url = Network.getMainURL()
        request.method = method
        request.params = parameters
        request.endPointPath = endPoint.path
        request.timeout = 30
        
        guard let respRequest = ApiRequest.getRequest(with: request) else { return }
        
        let session: URLSession = URLSession.shared
        
        session.dataTask(with: respRequest) { data, response, error in
            if error != nil {
                if let err = error as NSError? {
                    completion(.failure(err))
                    return
                }
            }
            
            if let data = data {
                do {
                    let resp = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(resp))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func downloadImageCache(_ urlString: String, nameKey: String, completion: @escaping(_ image: UIImage) -> Void) {
        
        if let cacheImg = cacheDownload.object(forKey: nameKey as NSString) {
            completion(cacheImg)
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let recieveImg: UIImage = UIImage(data: data),
                    let image = recieveImg.resizeImage(200, 200)
                else { return }
                DispatchQueue.main.async() {
                    cacheDownload.setObject(image, forKey: nameKey as NSString)
                    completion(image)
                }
            }.resume()
        }
    }
    
    static func getMainURL() -> String {
        guard let url: String = ServicePath.pathMainUrl("movieUrl") else { return "" }
        return url
    }
}
