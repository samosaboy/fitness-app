//
//  FloatingPanelLayout.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import Foundation
import FloatingPanel

class CustomFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .tip
    }
    
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .tip]
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .full: return 0 // A top inset from safe area
            case .half: return 216.0 // A bottom inset from the safe area/
            case .tip: return 55 // A bottom inset from the safe area
            default: return nil // Or `case .hidden: return nil`
        }
    }
}
