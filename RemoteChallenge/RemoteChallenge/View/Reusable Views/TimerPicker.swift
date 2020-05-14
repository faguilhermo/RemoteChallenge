////
////  TimerPicker.swift
////  RemoteChallenge
////
////  Created by Amaury A V A Souza on 14/05/20.
////  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
////
//
//import SwiftUI
//
//struct TimerPicker: View {
//
//    @State private var hourSelection = 0
//    @State private var minuteSelection = 0
//    @State private var secondSelection = 0
//
//    private let hours = [Int](0...24)
//    private let minutes = [Int](0...60)
//    private let seconds = [Int](0...60)
//
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Tempo do timer")
//                    .modifier(TextCustomView(defaultFont: .titleCell))
//                Spacer()
//            }
//            .padding(.top, 16)
//
//            HStack {
//
//                doPicker(selection: $hourSelection, array: hours, tempo: "horas")
//                    .modifier(PickerCustomView())
//
//                doPicker(selection: $minuteSelection, array: minutes, tempo: "min")
//                    .modifier(PickerCustomView())
//
//                doPicker(selection: $secondSelection, array: seconds, tempo: "seg")
//                    .modifier(PickerCustomView())
//
//            }
//        }
//
//    }
//}
//
//struct TimerPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerPicker()
//    }
//}
