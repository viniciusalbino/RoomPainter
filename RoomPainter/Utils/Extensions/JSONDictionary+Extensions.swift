//
//  JSONDictionary+Extensions.swift
//  RoomPainter
//
//  Created by Vinicius Albino on 11/01/23.
//

import Foundation
final class JSONParser {
    /**
         Call this function to access a JSONDictionary with ```[String: Any]``` or ```[jsonArray: [[String: Any]]]```
         - Parameters:
            - path : name of the local json to be parsed
         
         ### Usage Example: ###
         ````
         Data().jsonDataForPath("test")
         ````
    */
    public func jsonDataFor(fileName: String, bundle: Bundle) -> Data? {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        do {
            let safeData = try Data(contentsOf: URL(fileURLWithPath: path))
            return safeData
        } catch {
            return nil
        }
    }
    
    public func jsonDictionaryFor(fileName: String) -> JSONDictionary? {
        let defautArrayKey: String = "jsonArray"
        let bundle = Bundle(for: type(of: self))
        
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        do {
            let safeData = try Data(contentsOf: URL(fileURLWithPath: path))
            
            if let deserealizedJson = try? JSONSerialization.jsonObject(with: safeData, options: []) {
                if let jsonArray = deserealizedJson as? [JSONDictionary] {
                    return [defautArrayKey: jsonArray]
                } else if let json = deserealizedJson as? JSONDictionary {
                    return json
                }
            }
            return nil
        } catch {
            return nil
        }
    }
}

extension Dictionary {
    // swiftlint:disable syntactic_sugar
    public func merge(dict: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        // swiftlint:enable syntactic_sugar
        var copy = self
        dict.forEach { copy.updateValue($1, forKey: $0) }
        return copy
    }
    
    @discardableResult public mutating func addDictionary(dictionaryToAppend: Dictionary) -> Dictionary {
        if dictionaryToAppend.keys.isEmpty {
            return self
        }
        for (k, v) in dictionaryToAppend {
            self.updateValue(v, forKey: k)
        }
        return self
    }
}

extension Dictionary {
    /**
          Add dictionary to self in-place.
          
          - parameter dictionary: The dictionary to add to self
          */
    public mutating func formUnion(_ dictionary: Dictionary) {
        dictionary.forEach { updateValue($0.1, forKey: $0.0) }
    }
    /**
          Return a dictionary containing the union of two dictionaries
          
          - parameter dictionary: The dictionary to add
          - returns: The combination of self and dictionary
          */
    public func union(_ dictionary: Dictionary) -> Dictionary {
        var completeDictionary = self
        completeDictionary.formUnion(dictionary)
        return completeDictionary
    }
}

/**
 Combine the contents of dictionaries into a single dictionary. Equivalent to `lhs.union(rhs)`.
 
 - parameter lhs: The first dictionary.
 - parameter rhs: The second dictionary.
 - returns: The combination of the two input dictionaries
 */

// swiftlint:disable syntactic_sugar
public func +<Key, Value>(lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
    return lhs.union(rhs)
}
// swiftlint:enable syntactic_sugarr

/**
 Add the contents of one dictionary to another dictionary. Equivalent to `lhs.unionInPlace(rhs)`.
 
 - parameter lhs: The dictionary in which to add key-values.
 - parameter rhs: The dictionary from which to add key-values.
 */

public func +=<Key, Value>(lhs: inout Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) {
    lhs.formUnion(rhs)
}
