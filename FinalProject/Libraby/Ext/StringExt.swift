//
//  StringExt.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

extension String { }

extension Optional {
    var content: String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case .none:
            return ""
        }
    }
}
