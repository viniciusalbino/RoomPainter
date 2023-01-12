//
//  Component.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation

public struct Component: Mappable {
    var type: TokenType?
    var category: TokenCategory?
    var name: String
    var value: String?
    var arrayValue: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case value
        case type
        case category
        case arrayValue
    }
}
