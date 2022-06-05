//
//  Theme.swift
//  Memorize
//
//  Created by Ben Essex on 04 Jun 22.
//

import Foundation

public struct Theme<ContentType> where ContentType: Equatable {
    private(set) var name: String
    private(set) var elements: Array<ContentType>
    private(set) var numberOfPairs: Int
    private(set) var color: String
}
