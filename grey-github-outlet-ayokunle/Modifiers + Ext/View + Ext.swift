//
//  View + Ext.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/22/23.
//

import Foundation
import ProgressHUD
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    
    func showLoader() {
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorHUD = .black
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorAnimation = .white
        ProgressHUD.colorProgress = .clear
        ProgressHUD.show()
    }
    
    func hideLoader() {
        ProgressHUD.dismiss()
    }
}
