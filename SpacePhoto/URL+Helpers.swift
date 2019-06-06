//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Simon Italia on 6/4/19.
//  Copyright © 2019 Magical Tomato. All rights reserved.
//

import Foundation

//This helper file provides support for URL Components. (Modify Url requests with additonal query parameters - of data type Dictionary).

//URL extension to enable Url euqury components for Photo.url property
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            { URLQueryItem(name: $0.0, value: $0.1)  }
        return components?.url
    }
    
    //Force https protocol for referencing image item in API
    func forceHTTPS() -> URL? {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        
        return urlComponents?.url
    }
    
}
