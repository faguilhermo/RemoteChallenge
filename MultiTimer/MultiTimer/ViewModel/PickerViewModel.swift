//
//  PickerViewModel.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 19/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct TimeViewModel {
    func totaInlSeconds(hour: Int, minute: Int, second: Int) -> Int {
        return (hour*3600) + (minute*60) + second
    }

    func secondsInHours(seconds:Int) -> Int {
        return seconds/3600
    }

    func secondsInMinutes(seconds: Int) -> Int {
        return (seconds%3600)/60
    }

    func seconds(_ seconds: Int) -> Int {
        return (seconds%3600)%60
    }

    func formatTime(hours: Int, minutes: Int, seconds: Int) -> String {
        return String(format: "%d:%02d:%02d", hours, minutes, seconds)
    }
}
