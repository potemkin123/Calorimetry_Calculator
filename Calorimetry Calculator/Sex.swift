//
//  Sex.swift
//  Calorimetry Calculator
//
//  Created by Владислав Юрченко on 02.03.2023.
//

import Foundation
enum Sex: Int, CaseIterable {
    case male = 0
    case female = 1
    var title: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
            
        }
    }
}
