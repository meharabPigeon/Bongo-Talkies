//
//  Dictionary.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import UIKit

extension Encodable {
    
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self), let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
