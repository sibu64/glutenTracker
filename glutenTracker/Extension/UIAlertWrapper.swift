//
//  UIAlertWrapper.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 23/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import UIKit

private enum PresententionStyle {
    case rect (CGRect)
    case barButton (UIBarButtonItem)
}

private var clickedButtonAtIndexBlock:((Int) -> ())?


/**
 UIAlertWrapper is a wrapper around UIAlertView/UIActionSheet and UIAlertController in order to simplify supporting both iOS 7 and iOS 8. It is not meant to be an exhaustive wrapper, it merely covers the common use cases around Alert Views and Action Sheets.
 */
class UIAlertWrapper : NSObject {
    fileprivate class func topViewController () -> UIViewController {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        //http://stackoverflow.com/questions/12418177/how-to-get-root-view-controller
        assert(rootViewController != nil, "App has no keyWindow, cannot present Alert/Action Sheet.")
        return UIAlertWrapper.topVisibleViewController(rootViewController!)
    }
    
    fileprivate class func topVisibleViewController(_ viewController: UIViewController) -> UIViewController {
        if viewController is UITabBarController {
            return UIAlertWrapper.topVisibleViewController((viewController as! UITabBarController).selectedViewController!)
        } else if viewController is UINavigationController {
            return UIAlertWrapper.topVisibleViewController((viewController as! UINavigationController).visibleViewController!)
        } else if viewController.presentedViewController != nil {
            return UIAlertWrapper.topVisibleViewController(viewController.presentedViewController!)
        } else if viewController.children.count > 0 {
            return UIAlertWrapper.topVisibleViewController(viewController.children.last! as UIViewController)
        }
        return viewController
    }
    
    /**
     Initializes and presents a new Action Sheet from a Bar Button Item on iPad or modally on iPhone
     
     :param: title The title of the Action Sheet
     :param: cancelButtonTitle The cancel button title
     :param: destructiveButtonTitle The destructive button title
     :param: otherButtonTitles An array of other button titles
     :param: barButtonItem The Bar Button Item to present from
     :param: clickedButtonAtIndex A closure that returns the buttonIndex of the button that was pressed. An index of 0 is always the cancel button or tapping outside of the popover on iPad.
     */
    class func presentActionSheet(title: String?,
                                  cancelButtonTitle: String,
                                  destructiveButtonTitle: String?,
                                  otherButtonTitles: [String],
                                  barButtonItem:UIBarButtonItem,
                                  clickedButtonAtIndex:((_ buttonIndex:Int) -> ())? = nil) {
        
        self.presentActionSheet(title,
                                cancelButtonTitle: cancelButtonTitle,
                                destructiveButtonTitle: destructiveButtonTitle,
                                otherButtonTitles: otherButtonTitles,
                                presententionStyle: .barButton(barButtonItem),
                                clickedButtonAtIndex: clickedButtonAtIndex)
    }
    
    /**
     Initializes and presents a new Action Sheet from a Frame on iPad or modally on iPhone
     
     :param: title The title of the Action Sheet
     :param: cancelButtonTitle The cancel button title
     :param: destructiveButtonTitle The destructive button title
     :param: otherButtonTitles An array of other button titles
     :param: frame The Frame to present from
     :param: clickedButtonAtIndex A closure that returns the buttonIndex of the button that was pressed. An index of 0 is always the cancel button or tapping outside of the popover on iPad.
     */
    class func presentActionSheet(title: String?,
                                  cancelButtonTitle: String,
                                  destructiveButtonTitle:String?,
                                  otherButtonTitles: [String],
                                  frame:CGRect,
                                  clickedButtonAtIndex:((_ buttonIndex:Int) -> ())? = nil) {
        
        self.presentActionSheet(title,
                                cancelButtonTitle: cancelButtonTitle,
                                destructiveButtonTitle: destructiveButtonTitle,
                                otherButtonTitles: otherButtonTitles,
                                presententionStyle: .rect(frame),
                                clickedButtonAtIndex: clickedButtonAtIndex)
    }
    
    fileprivate class func presentActionSheet(_ title: String?,
                                              cancelButtonTitle: String,
                                              destructiveButtonTitle:String?,
                                              otherButtonTitles: [String],
                                              presententionStyle:PresententionStyle,
                                              clickedButtonAtIndex:((_ buttonIndex:Int) -> ())? = nil) {
        
        let currentViewController = UIAlertWrapper.topViewController()
        var buttonOffset = 1
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler:
            {(alert: UIAlertAction!) in
                if let _clickedButtonAtIndex = clickedButtonAtIndex {
                    _clickedButtonAtIndex(0)
                }
        }))
        
        if let _destructiveButtonTitle = destructiveButtonTitle {
            alert.addAction(UIAlertAction(title: _destructiveButtonTitle, style: .destructive, handler:
                {(alert: UIAlertAction!) in
                    if let _clickedButtonAtIndex = clickedButtonAtIndex {
                        _clickedButtonAtIndex(1)
                    }
            }))
            buttonOffset += 1
        }
        
        for (index, string) in otherButtonTitles.enumerated() {
            alert.addAction(UIAlertAction(title: string, style: .default, handler:
                {(alert: UIAlertAction!) in
                    if let _clickedButtonAtIndex = clickedButtonAtIndex {
                        _clickedButtonAtIndex(index + buttonOffset)
                    }
            }))
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            switch presententionStyle {
            case let .rect(rect):
                alert.popoverPresentationController?.sourceView = currentViewController.view
                alert.popoverPresentationController?.sourceRect = rect
            case let .barButton(barButton):
                alert.popoverPresentationController?.barButtonItem = barButton
            }
        }
        
        currentViewController.present(alert, animated: true, completion: nil)
    }
    
    /**
     Initializes and presents a new Alert
     
     :param: title The title of the Alert
     :param: message The message of the Alert
     :param: cancelButtonTitle The cancel button title
     :param: otherButtonTitles An array of other button titles
     :param: clickedButtonAtIndex A closure that returns the buttonIndex of the button that was pressed. An index of 0 is always the cancel button.
     */
    class func presentAlert(title: String,
                            message: String,
                            cancelButtonTitle: String,
                            otherButtonTitles: [String]? = nil,
                            clickedButtonAtIndex:((_ buttonIndex:Int) -> ())? = nil) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler:
            {(alert: UIAlertAction!) in
                if let _clickedButtonAtIndex = clickedButtonAtIndex {
                    _clickedButtonAtIndex(0)
                }
        }))
        
        if let _otherButtonTitles = otherButtonTitles {
            for (index, string) in _otherButtonTitles.enumerated() {
                alert.addAction(UIAlertAction(title: string, style: .default, handler:
                    {(alert: UIAlertAction!) in
                        if let _clickedButtonAtIndex = clickedButtonAtIndex {
                            _clickedButtonAtIndex(index + 1)
                        }
                }))
            }
        }
        
        let currentViewController = UIAlertWrapper.topViewController()
        OperationQueue.main.addOperation {
            currentViewController.present(alert, animated: true, completion: nil)
        }
    }
}

