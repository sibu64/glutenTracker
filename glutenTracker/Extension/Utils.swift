//
//  Utils.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import AudioToolbox

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

public struct Segue {
    static var scannerSegue = "scannerSegue"
    static var segueToDetails = "segueToDetails"
    static var showMyTabBarController = "show"
}

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
