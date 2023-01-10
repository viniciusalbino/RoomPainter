//
//  Mappable.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 09/01/23.
//

import Foundation

public typealias JSONDictionary = [String: Any]
public typealias Mappable = Codable & Equatable

infix operator <-->

public func <--> <T: Mappable>(jsonData: Data?, type: T.Type) -> T? {
    guard let data = jsonData, !data.isEmpty else {
        return nil
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        let string = String(data: data, encoding: .utf8)
        return nil
    }
}

public func <--> <T:Mappable>(jsonData: Data?, type: [T.Type]) -> [T]? {
    guard let data = jsonData, !data.isEmpty else {
        return nil
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        return try decoder.decode([T].self, from: data)
    } catch {
        let string = String(data: data, encoding: .utf8)
        return nil
    }
}
