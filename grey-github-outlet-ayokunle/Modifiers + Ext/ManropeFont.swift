//
//  ManropeFont.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/21/23.
//

import Foundation
import SwiftUI

enum FName: String {
    case regular = "Manrope-Regular"
    case extralight = "Manrope-ExtraLight"
    case light = "Manrope-Light"
    case medium = "Manrope-Medium"
    case semibold = "Manrope-SemiBold"
    case bold = "Manrope-Bold"
    case extrabold = "Manrope-ExtraBold"
    
    var name: String {
        self.rawValue
    }
}

struct ManropeFont: ViewModifier {
    
    var fName: FName
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content.font(.custom(fName.name, size: size))
    }
}
