//
//  TimerModel.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct TimerModel {
    var title: String = "Timer"
    var stepTitle: String = "Passo único"
    var totalTime: Timer
    var currentTime: Timer
    var steps: [StepModel]
    var currentStep: Int
}

struct StepModel {
    var stepTitle: String
    var stepTime: Timer
}

