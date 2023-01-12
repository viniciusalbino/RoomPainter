//
//  String+Localized.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation

extension String {
    public func localized(Withcomment comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    public func localized() -> String {
        return localized(Withcomment: "")
    }
}
