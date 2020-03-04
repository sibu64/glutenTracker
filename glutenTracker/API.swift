//
//  API.swift
//  FoodTracker
//
//  Created by Darrieumerlou on 11/05/2018.
//  Copyright © 2018 jean-michel zaragoza. All rights reserved.
//

import Foundation
import Alamofire

class API {
    private var baseUrl: String = "https://fr.openfoodfacts.org/api/v0/produits/"
    
    //Fonction de requête AlamoFire et d'extraction de données JSON
    func searchProduct(with barCode: String, success: @escaping (Product?)->Void, failure: @escaping (Error)->Void) {
        
        //partie requête
        //test de validité de l'url sinon abandon
        let urlStringProduct: String = baseUrl + barCode + ".json"
        guard let url = URL(string: urlStringProduct)
            else {return}
        //si valide, creation de la requête type AlamoFire passant l'url urlStringProduct
        //et demandant un retout JSON
        AF.request(url).responseJSON
        {
        (response) in
            
            ////partie extraction de données JSON
            if response.error == nil {
                
                //l'objet REponse va récupérer l'objet RESponse
                if let response = response.value as? [String: AnyObject] {
                    let status_verbose = response["status_verbose"] as? String
                    if status_verbose == "product not found" {
                        success(nil)
                        return
                    } else {
                        //Affichage de l'objet REponse complet récupéré
                        //print ("reponse : \(reponse)")
                        
                        //ensuite pour parser le fichier JSON.
                        //on descend d'1 cran dans l'arborescence du dictionnaire à partir de la racine
                        //on trouve et stocke le noeud "product" parmi les "clefs".
                        if let product = response["product"] as? [String: AnyObject] {
                            let prod = Product(json: product)
                            success(prod)
                        } // end of :  if let product = reponse["product"] as? [String: AnyObject]
                    }
                }  // end of : if let reponse = response.value.
            }else{
                failure(response.error!)
            } // end of :  if response.error == nil
        } // end of : Alamofire.request(url).responseJSON { (response) in
        
        
        
        
    }
    
    
    
    
    
}
