//
//  PhotoController.swift
//  SpacePhoto
//
//  Created by Simon Italia on 6/4/19.
//  Copyright © 2019 Magical Tomato. All rights reserved.
//

import Foundation

class PhotoController {

    //Fetch photo from web source
    func fetchPhoto(completion: @escaping (Photo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        //Additional query components when requesting the data from the server
        let query: [String: String] = [
            "api_key": "4hv6w6nW0oxcsDB6XRSe3JxVCJ4P3l9LMphd46Ll"
        ]
        
        //Construct URL to fetch with Query components attached
        let url = baseURL.withQueries(query)!
        
        //Create data task
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            //Create JSONDecoder and execute completion handler on returned / created, decoded JSON object
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let photo = try? jsonDecoder.decode(Photo.self, from: data) {
                completion(photo)
                
            } else  {
                print("Error with network request or decodiing data")
                completion(nil)
            }
        }
        
        //Execute network request via (data) task object
        task.resume()
    }
    
}
