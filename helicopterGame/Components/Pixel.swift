//
//  Pixel.swift
//  helicopterGame
//
//  Created by mvitoriapereirac on 08/10/22.
//

import SwiftUI

struct Pixel: View {
    let size: CGFloat
    let color: Color
    
    var body: some View {
        Rectangle()
            .frame(width: size, height: size)
            .foregroundColor(color)
    }
}
