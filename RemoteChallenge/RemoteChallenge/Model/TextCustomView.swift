//
//  TextCustomView.swift
//  RemoteChallenge
//
//  Created by Guilherme Enes on 13/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

enum FontType {
    case warningMessage
    case titleCell
    case subtitleCell
    case stepTimerCell
    case totalTimerCell
}

struct TextCustomView: ViewModifier {

    @State var defaultFont: FontType = .warningMessage

    func body(content: Content) -> some View {

        var fontSize: CGFloat = 24
        var fontStyle: String = "SFProDisplay-Light"

        switch defaultFont {
        case .warningMessage:
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
        }

        return content
            .foregroundColor(Color("secondColor"))
            .font(.custom(fontStyle, size: fontSize))
    }
}
