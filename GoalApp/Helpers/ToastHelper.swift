        //
//  ToastHelper.swift
//  GoalApp
//
//  Created by Lane Faison on 8/3/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import Foundation
import Toast

struct ToastHelper {
    
    enum ToastType {
        case missingName
        case missingTime
        case genericError
    }
    
    private func imageForToastType(_ type: ToastType) -> UIImage? {
        switch type {
        case .missingName, .missingTime:
            return UIImage(named: "error")
        case .genericError:
            return UIImage(named: "attention")
        }
    }
    
    private func titleForToastType(_ type: ToastType) -> String? {
        switch type {
        case .missingName, .missingTime:
            return "Missing field!"
        case .genericError:
            return "Oops!"
        }
    }
    
    private func messageForToastType(_ type: ToastType) -> String? {
        switch type {
        case .missingName:
            return "Please enter a name for your goal."
        case .missingTime:
            return "Please select a time for your goal to be completed in."
        case .genericError:
            return "There was an error processing your request. Please try again."
        }
    }
    
    private func styleForToastType(_ type: ToastType) -> CSToastStyle? {
        let style = CSToastStyle.init(defaultStyle: ())
        
        // Toast font colors
        style?.titleColor = UIColor.primaryTextColor
        style?.messageColor = UIColor.primaryTextColor
        
        // Toast fonts
        style?.titleFont = UIFont.font16b
        style?.messageFont = UIFont.font14sb
        
        // Toast image size
        style?.imageSize = CGSize(width: 50.0, height: 50.0)
        
        // Toast layout
        style?.cornerRadius = 5.0
        style?.shadowColor = UIColor.primaryDarkGray
        style?.displayShadow = true
        
        // Toast properties specific to ToastType
        switch type {
        case .missingName, .missingTime:
            style?.backgroundColor = UIColor.primaryYellow
        case .genericError:
            style?.backgroundColor = UIColor.primaryRed
        }
        
        return style
    }
    
    func presentToast(from viewController: UIViewController, type: ToastType) {
        guard let view = viewController.view else { return }
        
        let title = titleForToastType(type)
        let message = messageForToastType(type)
        let image = imageForToastType(type)
        let style = styleForToastType(type)
        let size = CGSize(width: view.frame.size.width * 0.9, height: 80.0)
        
        guard let toast = view.toastView(forMessage: message, title: title, image: image, style: style) else { return }
        
        toast.frame.size = size
        view.showToast(toast)
    }
}
