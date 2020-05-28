//
//  TextCustomModifier.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 19/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

enum FontType {
    case addNewTimerMessage
    case titleCell
    case subtitleCell
    case stepTimerCell
    case totalTimerCell
    case textField
    case saveButton
}

struct TextCustomModifier: ViewModifier {

    @State var fontType: FontType = .addNewTimerMessage

    func body(content: Content) -> some View {

        var fontSize: CGFloat = 24
        var fontStyle: String = "SFProDisplay-Light"

        switch fontType {
        case .addNewTimerMessage:
            fontSize = 48
            fontStyle = "SFProDisplay-Light"
        case .titleCell:
            fontSize = 24
            fontStyle = "SFProDisplay-Light"
        case .subtitleCell:
            fontSize = 24
            fontStyle = "SFProDisplay-Semibold"
        case .stepTimerCell:
            fontSize = 72
            fontStyle = "SFProDisplay-Bold"
        case .totalTimerCell:
            fontSize = 24
            fontStyle = "SFProDisplay-Light"
        case .textField:
            fontSize = 24
            fontStyle = "SFProDisplay-Ultralight"
        case .saveButton:
            fontSize = 24
            fontStyle = "SFProDisplay-Regular"
        }

        return content
            .foregroundColor(fontType != .saveButton ? Color("Secondary-Color") : Color("Save-Button-Font-Color"))
            .font(.custom(fontStyle, size: fontSize))
    }
}
