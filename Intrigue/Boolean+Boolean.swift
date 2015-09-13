//
//  Boolean+Boolean.swift
//  Intrigue
//
//  Created by Jonathan Kingsley on 12/09/2015.
//  Copyright (c) 2015 Jacob Banks. All rights reserved.
//

import UIKit

extension Boolean : BooleanLiteralConvertible {
    public init(booleanLiteral value: Bool) {
        self = value ? 1 : 0
    }
}
extension Boolean : BooleanType {
    public var boolValue : Bool {
        return self != 0
    }
}