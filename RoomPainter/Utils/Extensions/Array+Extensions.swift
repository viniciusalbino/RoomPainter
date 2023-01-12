//
//  Array+Extensions.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation

extension Array {
    public func object(index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
}
