//
//  ProductViewModel.swift
//  Youtube MVVM Products
//
//  Created by Prakash Tripathi on 03/03/23.
//

import Foundation

class ProductViewModel{
    
    var products : [Product] = []
    var EventHandler : ((_ event : Event) -> Void)?
    
    
   /* func getProductListing(){
        self.EventHandler?(.loading)
         
        ApiManager.shared.getProducts { response in
            
            self.EventHandler?(.stopLoading)
            switch response {
                
            case .success(let productArray) :
                
                    print(productArray)
                    self.EventHandler?(.dataLoaded)
                    self.products = productArray
                
                break
                
            case .failure(let error) :
                self.EventHandler?(.error(error))
                    print(error.localizedDescription)
                
                break
            }
        }
        
    }*/
    
    func getProductListing(){
        self.EventHandler?(.loading)
        
        ApiManager.shared.request(modelType: [Product].self,
                                         type: EndPointItems.ProductListing) { response in
            
            self.EventHandler?(.stopLoading)
            switch response {
                
            case .success(let productArray) :
                
                    print(productArray)
                    self.EventHandler?(.dataLoaded)
                    self.products = productArray
                
                break
                
            case .failure(let error) :
                self.EventHandler?(.error(error))
                    print(error.localizedDescription)
                
                break
            }
        }
        
        
    }
    
    func addProduct(parameter : AddProduct){
        
      
        ApiManager.shared.request(modelType: AddProduct.self, type: EndPointItems.AddProduct(Product: parameter)) { response in
            switch response{
            case .success(let product):
                self.EventHandler?(.productAdded(product: product))
            case .failure(let error):
                self.EventHandler?(.error(error))
            }
        }
        
    }
    
    
    
}

extension ProductViewModel{
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case productAdded(product : AddProduct)
    }
    
}
