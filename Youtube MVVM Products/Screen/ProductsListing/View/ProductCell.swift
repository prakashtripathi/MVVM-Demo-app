//
//  ProductCell.swift
//  Youtube MVVM Products
//
//  Created by Prakash Tripathi on 03/03/23.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productBackgroundView : UIView!
    @IBOutlet weak var imageview : UIImageView!
    @IBOutlet weak var headlineLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var ratebutton : UIButton!
    @IBOutlet weak var priceLabel : UILabel!
  
    var product : Product? {
        didSet{
            productDetailsConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.productBackgroundView.clipsToBounds = false
        self.productBackgroundView.layer.cornerRadius = 15
        self.imageview.clipsToBounds = false
        self.imageview.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailsConfiguration(){
        guard let product else {return}
        
        self.headlineLabel.text = product.title
        self.categoryLabel.text = product.category
        self.descriptionLabel.text = product.description
        self.categoryLabel.text = product.category
        ratebutton.setTitle("\(product.rating.rate)", for: .normal)
        self.priceLabel.text = "$ \(product.price)"
        self.imageview.setImageFromURl(urlString: product.image)
        
    }
    
}
