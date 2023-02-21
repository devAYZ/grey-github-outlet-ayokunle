//
//  AppDelegate.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/21/23.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
         
    static var orientationLock = UIInterfaceOrientationMask.portrait //By default you want all your views to rotate freely
 
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
