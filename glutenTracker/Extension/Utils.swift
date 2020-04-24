//
//  Utils.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import AudioToolbox

// Function to play a bip when a product is scanned
extension UIViewController {
    func playSound(sound: String) {
        if let customSoundUrl = Bundle.main.url(forResource: sound, withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
                AudioServicesDisposeSystemSoundID(customSoundId)
            }, nil)
            AudioServicesPlaySystemSound(customSoundId)
        }
    }
}

// Segues
extension String {
    static var scannerSegue = "scannerSegue"
    static var segueToDetails = "segueToDetails"
    static var showMyTabBarController = "show"
    static var productSegue = "productSegue"
    static var popUpSegue = "popUpSegue"
    static var showOnboardingSegue = "showOnboardingSegue"
}

// Identifier
public struct Identifier{
    static var favoriteCellIdentifier = "FavoriteCell"
    static var ingredientsCellIdentifier = "ingredientsCell"
}

// Functions to clean the string, remove tags and joined strings by coma (from the API)
extension String {
    public var cleanString: String? {
        let value = self.components(separatedBy: CharacterSet.decimalDigits)
            .joined()
            .replacingOccurrences(of: "%", with: "")
            .replacingOccurrences(of: ".", with: "")
        let array = value.split(separator: ",").map {
            String($0).replacingOccurrences(of: " ", with: "")
        }
        return array.joined(separator: ",")
    }

    public var removeTags: String? {
        let value = self.replacingOccurrences(of: "en:", with: "")
        return value
    }

    public var joinedByComma: [String]? {
        let value = self.split(separator: ",")
                        .map { String($0) }
        return value
    }
}
