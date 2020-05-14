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
    var totalHours: Int = 0
    var totalMinutes: Int = 0
    var totalSeconds: Int = 0
    var steps: [StepModel] = []
    var currentStep: Int = 0
    var totalSteps: Int = 1
    var isStepped: Bool = false
    var pauseBetweenSteps: Bool = false
    var isFavorite: Bool = false
    var repeatTimer: Bool = false
    
}

struct StepModel {
    var stepTitle: String
    var stepHours: Int
    var stepMinutes: Int
    var stepSeconds: Int
}

