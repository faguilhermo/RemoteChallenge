//
//  TimerModel.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 19/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct TimerModel: Identifiable, Hashable {
    var id: Int
    let title: String
    let subtitle: String
    let timer: String
    let totalTime: Int
    let repeatTimer: Bool
    let repetitionNumber: Int
}
