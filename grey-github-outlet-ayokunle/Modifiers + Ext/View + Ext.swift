//
//  View + Ext.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/22/23.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
}
