//
//  UiimageView + Extensions.swift
//  Youtube MVVM Products
//
//  Created by Prakash Tripathi on 03/03/23.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    
    func setImageFromURl(urlString : String){
        guard let url = URL(string: urlString) else{return}
        let resource =  ImageResource.init(downloadURL: url , cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
        
    }
    
}
