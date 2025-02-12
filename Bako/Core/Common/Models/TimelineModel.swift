//
//  TimelineModel.swift
//  Bako
//
//  Created by Muhammad Rezky on 13/02/25.
//

import Foundation

struct TimelineModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
}
