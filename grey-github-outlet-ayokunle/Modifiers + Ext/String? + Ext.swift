//
//  String? + Ext.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/26/23.
//

import Foundation

extension String?: Identifiable {
    public var id: UUID {
        UUID()
    }
}
