//
//  misc.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


extension Bool {
    func toInt() -> Int {
        return self ? 1 : 0
    }
}

extension Int {
    func toBool() -> Bool {
        return (self <= 0) ? false : true
    }
}

extension Int {
    func toTaskSpan() -> TaskSpan {
        switch self {
        case 1:
            return .day
        case 2:
            return .week
        case 3:
            return .month
        case 4:
            return .year
        default:
            return .year
        }
    }
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
