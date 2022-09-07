//
//  Utils.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 07/09/2022.
//

import Foundation

class Utils{
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}
