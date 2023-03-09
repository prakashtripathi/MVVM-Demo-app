//
//  ProductListingVC.swift
//  Youtube MVVM Products
//
//  Created by Prakash Tripathi on 02/03/23.
//

import UIKit

class ProductListingVC: UIViewController {
    private var viewModel = ProductViewModel()
    @IBOutlet weak var tableview : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
       }
    
    
    @IBAction func addProductTapped(_ sender: UIBarButtonItem) {
        
        viewModel.addProduct(parameter: AddProduct(title: "iphone"))
        
    }
    

}

extension ProductListingVC {
    
    func configuration(){
        initViewModel()
        obserEvent()
    }
    
    func initViewModel(){
        viewModel.getProductListing()
        self.tableview.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier:"ProductCell" )
    }
    
    func obserEvent(){
        
        viewModel.EventHandler = {[weak self] event in
            
            guard let self else {return}
            
            switch event {
            case .loading :  break
            case .stopLoading :  break
            case .dataLoaded :
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                print(self.viewModel.products)
                break
            case .error(let error) :
                print(error?.localizedDescription ?? "")
                break
                
            case .productAdded(product: let product):
                print("product added \(product.title)-----\(product.id ?? 0)")
                
            }
            
        }
    }
    
    
}


extension ProductListingVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
             return UITableViewCell()
        }
        let product =  self.viewModel.products[indexPath.row]
        cell.product = product
        
        return cell
    }
    
    
    
}
