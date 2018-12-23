//
//  Extensions.swift
//  CGVProject
//
//  Created by Wi on 05/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

//import Foundation
//
//let imageCache = NSCache<AnyObject, AnyObject>()
//
//class CustomImageView: UIImageView {
//    
//    var imageUrlString: String?
//    
//    func loadImageUsingUrlString(urlString: String){
//        let url = URL(string: urlString)
//        image = nil
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil{
//                print(error)
//                return
//            }
//            DispatchQueue.main.async {
//                let imageToCache = UIImage(data: data!)
//                if self.imageUrlString == urlString{
//                self.image = imageToCache
//                }
//                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
//            }
//        }.resume()
//    }
//}
