//
//  UIAplicationExtension.swift
//  MultiTimer
//
//  Created by Fabrício Guilhermo on 01/06/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

