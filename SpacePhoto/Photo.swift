//
//  File.swift
//  SpacePhoto
//
//  Created by Simon Italia on 6/4/19.
//  Copyright © 2019 Magical Tomato. All rights reserved.
//

import Foundation

//Custom Data Model to create, store object from JSON data
struct Photo: Codable {
    var title: String
    var description: String
    var url: URL
        // property uses url extension
    var copyright: String?
    
    //Map non-matching keys to custom data model properties with enum, inside custom model definiton. If keys match, they don't need an associated value (eg: title)
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    //Create custom init method to discard unneeded key/value pairs
    init(from decoder: Decoder) throws {
        
        //Return only key/value pairs that match those declared in CodingKeys enum
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}
