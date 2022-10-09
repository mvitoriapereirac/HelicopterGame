//
//  Obstacle.swift
//  helicopterGame
//
//  Created by mvitoriapereirac on 08/10/22.
//

import SwiftUI
struct Obstacle: View {
    
    let width: CGFloat = 20
    let height: CGFloat = 200
    var body: some View {
        Rectangle()
            .frame(width: self.width, height: self.height)
            .foregroundColor(Color.green)
    }
}
