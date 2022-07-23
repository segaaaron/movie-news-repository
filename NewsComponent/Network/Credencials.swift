//
//  Credencials.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/7/22.
//

import Foundation

final class Credencials {
    public static let apikey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    public static let language = Credencials.languageKey
    public static let regionCode = Locale.current.regionCode ?? ""
    public static let defaultPage = "1"
    public static let imagePath = "https://image.tmdb.org/t/p/w500"
    
    static var languageKey: String {
        let preferredLanguage = Locale.preferredLanguages[0] as String
        let index: String.Index = preferredLanguage.index(preferredLanguage.startIndex, offsetBy: 2)
        let currentLanguage = String(preferredLanguage[..<index])
        return currentLanguage
    }
}
