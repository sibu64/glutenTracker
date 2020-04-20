//
//  NetworkRequestProtocol.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 27/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

typealias ProductResults = (Product)->Void

// Protocol for the API call
protocol NetworkRequestProtocol {
    func searchProduct(
        with barCode: String,
        success: ((Product?)->Void)?,
        failure: ((Error)->Void)?
    )
}

