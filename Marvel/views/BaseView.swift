//
//  BaseView.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import UIKit

/// force view to emplement onDataRecieved to capture the returned data from viewModel
protocol BaseView {
    func onDataRecieved(data: AnyObject)
}

extension UINavigationController {
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
