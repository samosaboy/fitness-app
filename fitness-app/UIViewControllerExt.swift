//
//  UIViewControllerExt.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-28.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
