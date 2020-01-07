//
//  FloatingPanelBehavior.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-06.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import UIKit
import FloatingPanel

class FloatingPanelStocksBehavior: FloatingPanelBehavior {
    func allowsRubberBanding(for edge: UIRectEdge) -> Bool {
        return true
    }
}
