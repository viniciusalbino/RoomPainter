//
//  User.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation

struct User: Mappable {
    var user: String
    var password: String?
    var email: String?
    var fullName: String?
}
