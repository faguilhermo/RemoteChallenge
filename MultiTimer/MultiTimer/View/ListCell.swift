import SwiftUI
import UserNotifications

struct ListCell: View {


//    let isExpended: Bool
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
    @State var repeated = 0


    func notify(tempoTotal: Double, id: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(timer.title)"
        content.body = "A contagem do timer '\(timer.title)' chegou a zero"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "timerOverSound"))
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: tempoTotal, repeats: false)
        let req = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
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
                HStack (alignment: .bottom) {
                    if timerFinished {
                        Text(TimeViewModel().formatTime(hours: TimeViewModel().secondsInHours(seconds: totalTime), minutes: TimeViewModel().secondsInMinutes(seconds: totalTime), seconds: TimeViewModel().seconds(totalTime)))
                            .modifier(TextCustomModifier(fontType: .stepTimerCell))
                            .opacity(0.5)
                    } else {
                        Text(TimeViewModel().formatTime(hours: TimeViewModel().secondsInHours(seconds: totalTime), minutes: TimeViewModel().secondsInMinutes(seconds: totalTime), seconds: TimeViewModel().seconds(totalTime)))
                        .modifier(TextCustomModifier(fontType: .stepTimerCell))
                    }
                    Spacer()
                    if timer.repetitionNumber >= 2 && timer.repeatTimer {
                    Text("(\(repeated+1)/\(timer.repetitionNumber))")
                        .modifier(TextCustomModifier(fontType: .subtitleCell))
                        .padding(.bottom)
                    }
                }
            }
            HStack {
//                if isExpended {
                    Button(action: {}) {
                        if self.timerFinished || self.totalTime == 0 {
                            Image(uiImage: #imageLiteral(resourceName: "play")).foregroundColor(Color("Secondary-Color")).disabled(true).opacity(0.5)
                        } else {
                            self.start ? Image(uiImage: #imageLiteral(resourceName: "pause")).foregroundColor(Color("Secondary-Color")) :
                                Image(uiImage: #imageLiteral(resourceName: "play")).foregroundColor(Color("Secondary-Color"))
                        }
                        if self.repeatTimer && self.totalTime == 0 {

                        }
                    }
                    .onTapGesture {
                        if !self.timerFinished {
                            if self.start  {
                                if self.timer.repetitionNumber > 0 {
                                    for i in 1...(self.timer.repetitionNumber) {
                                        self.center.removePendingNotificationRequests(withIdentifiers: [String(self.timer.id*1000+i)])
                                    }
                                } else {
                                    self.center.removePendingNotificationRequests(withIdentifiers: [String(self.timer.id)])
                                }

                            } else if self.timerFinished || self.totalTime != 0 {

                                if self.timer.repeatTimer {
                                    var repetition: Double = -1
                                    if self.repeated <= self.timer.repetitionNumber {
                                        for i in 1...(self.timer.repetitionNumber-self.repeated) {
                                            self.notify(tempoTotal: Double(self.totalTime+i)+repetition, id: String(self.timer.id*1000+i))
                                            repetition += Double(self.timer.totalTime)
                                        }
                                    }
                                } else {
                                    self.notify(tempoTotal: Double(self.timer.totalTime), id: String(self.timer.id))
                                }
                            }

                            if self.totalTime != 0 {
                                self.start.toggle()
                            }
                        }
                    }

                    Spacer()

                    //botao de reload timer
                    Button(action: {}) {
                        if self.timerFinished {
                            Image(uiImage: #imageLiteral(resourceName: "restart")).foregroundColor(Color("Secondary-Color"))
                        } else {
                            Image(uiImage: #imageLiteral(resourceName: "restart")).foregroundColor(Color("Secondary-Color")).disabled(true).opacity(0.5)
                        }

                    }
                    .padding(.trailing)
                    .onTapGesture {
                        if self.timerFinished {
                            self.repeated = 0
                            self.totalTime = self.timer.totalTime
                            if self.timer.repetitionNumber > 0 {
                                var repetition: Double = -1
                                for i in 1...(self.timer.repetitionNumber-self.repeated) {
                                    self.notify(tempoTotal: Double(self.totalTime+i)+repetition, id: String(self.timer.id*1000+i))
                                    repetition += Double(self.timer.totalTime)
                                }
                            } else {
                                self.notify(tempoTotal: Double(self.timer.totalTime), id: String(self.timer.id))
                            }
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
                        if self.timer.repetitionNumber > 0 {
                            for i in 1...self.timer.repetitionNumber {
                                self.center.removePendingNotificationRequests(withIdentifiers: [String(self.timer.id*1000+i)])
                            }
                        }
                    }
                }
            Divider()
                .padding(.top, 40)
            }
            .onAppear(perform: {

                self.totalTime = self.timer.totalTime
                self.start = false
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
                if self.start {
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
            }
            .onReceive(runTimer) { (_) in
                if self.start {
                    if self.totalTime > 0 {
                        self.totalTime -= 1
                    } else {
                        if !self.repeatTimer || self.repeated == self.timer.repetitionNumber-1 {
                            self.timerFinished = true
                        } else {
                            self.repeated += 1
                            self.totalTime = self.timer.totalTime
                            self.start = true
                        }
                    }
            }
        }
        .contentShape(Rectangle())
        .listRowBackground(Color("Main-Color"))
        .padding(.bottom, 24)

    }

}
