//
//  Utils.swift
//  Netflix-Clone
//
//  Created by Hue Pham on 06/09/2022.
//

import Foundation

class Utils{
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}
