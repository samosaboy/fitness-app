//
//  Colors.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2019-12-30.
//  Copyright © 2019 sam0sab0y. All rights reserved.
//

import UIKit

enum ActivityColorsEnum {
    case common
    case yellow
    case purple
    case green
    case blue
}

extension UIColor {
    struct ActivityColors: CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(color)"
        }
        
        var color: [UIColor]
        
        init(color: ActivityColorsEnum) {
            switch color {
            case ActivityColorsEnum.blue:
                self.color = [UIColor(named: "appBlue")!, UIColor(named: "appBlueLight")!]
            case ActivityColorsEnum.green:
                self.color = [UIColor(named: "appGreen")!, UIColor(named: "appGreenLight")!]
            case ActivityColorsEnum.common:
                self.color =  [UIColor(named: "appOrange")!, UIColor(named: "appYellow")!]
            case ActivityColorsEnum.purple:
                self.color =  [UIColor(named: "appPurple")!, UIColor(named: "appPurpleBlue")!]
            case ActivityColorsEnum.yellow:
                self.color = [UIColor(named: "appOrange")!, UIColor(named: "appYellow")!]
            }
        }
    }
}
