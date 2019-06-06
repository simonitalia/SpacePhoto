//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Simon Italia on 6/4/19.
//  Copyright © 2019 Magical Tomato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let photoController = PhotoController()
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        //Enable network request activity indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        photoController.fetchPhoto {
            (photo) in
            if let photo = photo {
                self.updateUI(with: photo)
            }
        }
    }
    
    //Download image and display in UI
    func updateUI(with photo: Photo) {
        //Call the force Url method
        guard let url = photo.url.forceHTTPS() else { return }
        
        //Pass in photo image Url
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if let data = data,
            let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.title = photo.title
                    self.descriptionLabel.text = photo.description
                    self.photoImageView.image = image
                    
                    if let copyright = photo.copyright {
                        self.copyrightLabel.text = "Copyright: \(copyright)"
                        
                    } else {
                        self.copyrightLabel.isHidden = true
                    }
                    
                    //Disable network request activity indicator
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        })
        
        task.resume()
    }
}
