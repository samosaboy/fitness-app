//
//  Reusable.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-29.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

// https://github.com/phillfarrugia/appstore-clone/blob/master/AppStoreClone/Utility/Reusable.swift
internal protocol Reusable: class {
    
    /// Identifier used to dequeue this view for reuse.
    static var reuseIdentifier: String { get }
    
    /// UINib containing the Interface Builder representation.
    static var nib: UINib? { get }
}

/// Provides default implementations of the necessary variables
/// to reuse a generic view.
internal extension Reusable {
    
    /// Uses the object's Type name as the ReuseIdentifier.
    static var reuseIdentifier: String { return String(describing: self) }
    
    /// Uses the UINib named after the object's type name.
    static var nib: UINib? { return UINib(nibName: String(describing: self), bundle: nil) }
}
