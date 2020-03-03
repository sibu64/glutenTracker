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
        //Bip sonore lorsque la capture scan est réalisée
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
}
