//
//  TimerPicker.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 19/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct TimerPicker: View {

    @Binding var hour: Int 
    @Binding var minute: Int
    @Binding var second: Int

    private let hours = [Int](0...24)
    private let minutes = [Int](0...59)
    private let seconds = [Int](0...59)

    var body: some View {
        HStack {
             doPicker(selection: $hour, array: hours, tempo: "horas")
             doPicker(selection: $minute, array: minutes, tempo: "min")
             doPicker(selection: $second, array: seconds, tempo: "seg")
        }
    }

    private func doPicker(selection: Binding<Int>, array: [Int], tempo: String) -> some View {
        let pickerWidth = UIScreen.main.bounds.width/3 - 20
        let pickerHeight: CGFloat = 90
        let picker = Picker(selection: selection, label: Text("")) {
            ForEach(0..<array.count) { index in
                Text("\(array[index]) \(tempo)").tag(index)
            }
        }
        return picker
            .labelsHidden()
            .modifier(TextCustomModifier(fontType: .textField))
            .frame(width: pickerWidth, height: pickerHeight)
            .clipped()
    }
}


