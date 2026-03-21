//
//  URL+Extensions.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 11/10/23.
//

import Foundation

extension URL {
    func extractVideoID() -> String? {
        if let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems {
            for queryItem in queryItems {
                if queryItem.name == "v" {
                    return queryItem.value
                }
            }
        }
        return nil
    }

}
