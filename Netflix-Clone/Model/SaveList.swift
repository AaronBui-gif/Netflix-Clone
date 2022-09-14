//
//  SaveList.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 13/09/2022.
//

import Foundation

// MARK: - SaveListElement
struct SaveList: Decodable, Hashable, Identifiable {
    let saveListID: Int
    var id: Int {saveListID}
    let movie: Movie

    enum CodingKeys: String, CodingKey {
        case saveListID = "saveListId"
        case movie
    }
}
