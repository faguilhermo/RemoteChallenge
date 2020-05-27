//
//  ListCell.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 19/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI
import UserNotifications

struct ListCell: View {
    
    
    let isExpended: Bool
    var timer: TimerModel
    var runTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var didDelete: (TimerModel) -> ()
    let calendar = Calendar.current
    
    @State var timeBeforeEnterBackground = 0
    @State var timeComeInForeground = 0
    
    let center = UNUserNotificationCenter.current()
    
    @State var totalTime: Int
    @State var timerFinished = false
    @State var start = true
    let repeatTimer: Bool
    
    func notify(tempoTotal: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Chegamos a estaca zero!"
        content.body = "A contagem do timer \(timer.subtitle) chegou a zero"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "timerOverSound"))
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: tempoTotal, repeats: false)
        let req = UNNotificationRequest(identifier: String(timer.id), content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack (alignment: .leading) {
                HStack {
                    Text(timer.title)
                        .modifier(TextCustomModifier(fontType: .titleCell))
                    
                    Spacer()
                    
                    Text(TimeViewModel().formatTime(hours: TimeViewModel().secondsInHours(seconds: timer.totalTime), minutes: TimeViewModel().secondsInMinutes(seconds: timer.totalTime), seconds: TimeViewModel().seconds(timer.totalTime)))
                        .modifier(TextCustomModifier(fontType: .totalTimerCell))
                }
                HStack {
                    Text(timer.subtitle)
                        .modifier(TextCustomModifier(fontType: .subtitleCell))
                }
                HStack {
                    Text(TimeViewModel().formatTime(hours: TimeViewModel().secondsInHours(seconds: totalTime), minutes: TimeViewModel().secondsInMinutes(seconds: totalTime), seconds: TimeViewModel().seconds(totalTime)))
                        .modifier(TextCustomModifier(fontType: .stepTimerCell))
                }
            }
            HStack {
                if isExpended {
                    Button(action: {}) {
                        if self.timerFinished {
                            Image(uiImage: #imageLiteral(resourceName: "play")).foregroundColor(Color("Secondary-Color")).disabled(true).opacity(0.5)
                        } else {
                            self.start ? Image(uiImage: #imageLiteral(resourceName: "pause")).foregroundColor(Color("Secondary-Color")) :
                                Image(uiImage: #imageLiteral(resourceName: "play")).foregroundColor(Color("Secondary-Color"))
                        }
                    }
                    .onTapGesture {
                        if !self.timerFinished {
                            if self.start == true {
                                self.center.removePendingNotificationRequests(withIdentifiers: [String(self.timer.id)])
                            } else {
                                self.notify(tempoTotal: Double(self.totalTime))
                            }
                            self.start.toggle()
                        }
                    }
                    
                    Spacer()
                    
                    //botao de reload timer
                    Button(action: {}) {
                        if self.timerFinished{
                            Image(uiImage: #imageLiteral(resourceName: "restart")).foregroundColor(Color("Secondary-Color"))
                        } else {
                            Image(uiImage: #imageLiteral(resourceName: "restart")).foregroundColor(Color("Secondary-Color")).disabled(true).opacity(0.5)
                        }
                        
                    }
                    .padding(.trailing)
                    .onTapGesture {
                        if self.timerFinished {
                            self.notify(tempoTotal: Double(self.timer.totalTime))
                            self.totalTime = self.timer.totalTime
                            self.start = true
                            self.timerFinished = false
                        }
                    }
                    
                    //botao de delete cell eu sabia q ia precisar!
                    Button(action: {}) {
                        Image(uiImage: #imageLiteral(resourceName: "garbage")).foregroundColor(Color("Secondary-Color"))
                    }
                    .onTapGesture {
                        self.center.removePendingNotificationRequests(withIdentifiers: [String(self.timer.id)])
                        self.start = false
                        self.didDelete(self.timer)
                    }
                }
            }
            .onAppear(perform: {
                self.notify(tempoTotal: Double(self.timer.totalTime))
                self.totalTime = self.timer.totalTime
                self.start = true
            })
                
                //quando o app vai pra background
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    self.timeBeforeEnterBackground = 0
                    let hourInSeconds = self.calendar.component(.hour, from: Date()) * 3600
                    let minuteInSeconds = self.calendar.component(.minute, from: Date()) * 60
                    let second =  self.calendar.component(.second, from: Date())
                    self.timeBeforeEnterBackground = hourInSeconds + minuteInSeconds + second
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.timeComeInForeground = 0
                let currentHourInSeconds = self.calendar.component(.hour, from: Date()) * 3600
                let currentMinuteInSeconds = self.calendar.component(.minute, from: Date()) * 60
                let currentSecond = self.calendar.component(.second, from: Date())
                self.timeComeInForeground = currentHourInSeconds + currentMinuteInSeconds + currentSecond
                let timeAway = self.timeComeInForeground - self.timeBeforeEnterBackground // Guilherme Enes
                self.totalTime -= timeAway
                
                //TRATAR AQUI!
                if self.repeatTimer {
                    let repeatedIn = timeAway%self.totalTime
                    self.totalTime = self.totalTime - (self.totalTime - repeatedIn)
                } else {
                    if self.totalTime < 0 {
                        self.totalTime = 0
                        self.start = false
                        self.timerFinished = true
                    }
                }
            }
            .onReceive(runTimer) { (_) in
                if self.start {
                    if self.totalTime > 0 {
                        self.totalTime -= 1
                    } else {
                        if !self.repeatTimer {    //Trata o repeatTimer
                            self.timerFinished = true
                        } else {
                            self.totalTime = self.timer.totalTime
                            self.start = true
                            self.notify(tempoTotal: Double(self.timer.totalTime))
                        }
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .listRowBackground(Color("Main-Color"))
        .padding(.bottom, 24)
    }
}
