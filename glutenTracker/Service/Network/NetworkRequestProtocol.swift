//
//  NetworkRequestProtocol.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 27/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

typealias ProductResults = (Product)->Void

protocol NetworkRequestProtocol {
    func searchProduct(with barCode: String, success: @escaping (Product?)->Void, failure: @escaping (Error)->Void)
}

