//
//  HelperExtensions.swift
//  MovieTime
//
//  Created by Mike Conner on 3/3/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
