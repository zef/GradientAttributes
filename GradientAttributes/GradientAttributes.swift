//
//  GradientAttributes.swift
//  GradientAttributes
//
//  Created by Zef Houssney on 10/7/14.
//  Copyright (c) 2014 Made by Kiwi. All rights reserved.
//

import Foundation
import UIKit

struct GradientAttributes {
    enum Direction {
        case Vertical, Horizontal

        func startPoint() -> CGPoint {
            switch self {
            case .Vertical:
                return CGPointMake(0.5, 0)
            case .Horizontal:
                return CGPointMake(0, 0.5)
            }
        }

        func endPoint() -> CGPoint {
            switch self {
            case .Vertical:
                return CGPointMake(0.5, 1)
            case .Horizontal:
                return CGPointMake(1, 0.5)
            }
        }
    }

    struct Stop {
        var color: UIColor
        var location: Float?

        init (_ color: UIColor) {
            self.color = color
        }
        init (_ color: UIColor, location: Float) {
            self.init(color)
            self.location = location
        }
    }

    var stops: [Stop]
    var direction: Direction?

    init () {
        stops = [
            GradientAttributes.Stop(UIColor.blackColor()),
            GradientAttributes.Stop(UIColor.whiteColor()),
        ]
    }

    init (direction: Direction) {
        self.init()
        self.direction = direction
    }

    func applyToLayer(inout layer: CAGradientLayer) {
        layer.colors = colors()
        layer.locations = locations()

        if let setDirection = direction? {
            layer.startPoint = setDirection.startPoint()
            layer.endPoint = setDirection.endPoint()
        }
    }

    func colors() -> [AnyObject] {
        return stops.map { (var stop) -> AnyObject in
            return stop.color.CGColor
        }
    }

    func locations() -> [AnyObject]? {
        var locations: [AnyObject]? = stops.filter { $0.location? != nil }.map { Float($0.location!) }

        if locations?.count != stops.count {
            println("Ignoring locations due to missing values... I'd like to add support for missing values soon...")
            locations = nil
        }

        return locations

        //        var locations = stops.map { (var stop) -> AnyObject? in
        ////            if let location = stop.location {
        ////                return location
        ////            }
        //            return stop.location
        //        }
        //
        //        locations = locations.reduce([]) {
        //            if let location = stop.location {
        //                return location
        //            }
        //        }
    }
}
