//
//  PickerCustomView.swift
//  RemoteChallenge
//
//  Created by Fabrício Guilhermo on 14/05/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

struct PickerCustomView: ViewModifier {

    private let pickerWidth = UIScreen.main.bounds.width/3 - 20
    private let pickerHeight: CGFloat = 90

    func body(content: Content) -> some View {
        return content
            .labelsHidden()
            .frame(width: pickerWidth, height: pickerHeight)
            .clipped()
    }
}
