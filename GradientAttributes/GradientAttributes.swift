//
//  GradientAttributes.swift
//  GradientAttributes
//
//  Created by Zef Houssney on 10/7/14.
//  Copyright (c) 2014 Made by Kiwi. All rights reserved.
//

import Foundation
import UIKit

public struct GradientAttributes {
    public enum Direction {
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

    public struct Stop {
        var color: UIColor
        var location: Double?

        init (_ color: UIColor) {
            self.color = color
        }
        init (_ color: UIColor, location: Double) {
            self.init(color)
            self.location = location
        }
    }

    public var stops: [Stop]
    public var direction: Direction?

    public init () {
        stops = [
            GradientAttributes.Stop(UIColor.blackColor()),
            GradientAttributes.Stop(UIColor.whiteColor()),
        ]
    }

    public init (direction: Direction) {
        self.init()
        self.direction = direction
    }

    public func applyToLayer(inout layer: CAGradientLayer) {
        layer.colors = colors()
        layer.locations = locations()

        if let setDirection = direction? {
            layer.startPoint = setDirection.startPoint()
            layer.endPoint = setDirection.endPoint()
        }
    }

    public func colors() -> [AnyObject] {
        return stops.map { (var stop) -> AnyObject in
            return stop.color.CGColor
        }
    }

    public func locations() -> [AnyObject]? {
        var locations: [Double?] = stops.map { $0.location? as Double? }
        var noLocationsProvided: Bool = locations.filter { $0 == nil }.count == locations.count

        if noLocationsProvided {
            return nil
        } else {
            return interpolatedLocations(locations)
        }
    }

    private func interpolatedLocations(rawLocations: [Double?]) -> [AnyObject] {
        var locations = rawLocations
        
        locations[0] = locations[0] ?? 0
        let lastIndex = locations.count - 1
        locations[lastIndex] = locations[lastIndex] ?? 1

        var missingIndexes: [Bool] = locations.map { $0 == nil }

        while let missingIndex = find(missingIndexes, true) {
            var lastSetValue = locations[missingIndex - 1]!
            var nextSetValue: Double?

            var missingCount = 1
            while nextSetValue == nil {
                if let foundValue = locations[missingIndex + missingCount] {
                    nextSetValue = foundValue

                    let span = foundValue - lastSetValue
                    let increment = span / Double(missingCount + 1)

                    var nextMissing = missingIndex
                    while missingCount > 0 {
                        let replacementValue = lastSetValue + increment
                        locations[nextMissing] = replacementValue
                        missingIndexes[nextMissing] = false

                        lastSetValue = replacementValue
                        nextMissing += 1
                        missingCount -= 1
                    }
                } else {
                    missingCount += 1
                }
            }
        }

        return locations.filter { $0 != nil }.map { $0! as AnyObject }
    }
}
