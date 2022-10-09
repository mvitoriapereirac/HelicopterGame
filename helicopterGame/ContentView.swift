//
//  contentView.swift
//  helicopterGame
//
//  Created by mvitoriapereirac on 08/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var heliPosition = CGPoint(x: 100, y: 100)
    @State private var obstaclePosition = CGPoint(x: 1000, y: 300)
    @State var  timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var isPaused = false
    @State private var score = 0
    
    var body: some View {
        
        
        GeometryReader { geo in
            ZStack{
                Helicopter()
                    .position(self.heliPosition)
                    .onReceive(self.timer) {_ in
                        self.gravity()
                    }
                
                Obstacle()
                    .position(self.obstaclePosition)
                    .onReceive(self.timer) { _ in
                        
                        obstMove()
                    }
                
                Text("\(self.score)")
                    .position(x: geo.size.width - 100, y: geo.size.height / 10 )
                    .foregroundColor(Color.white)
                //                VStack {
                //                    Button("Pause") {self.timer.upstream.connect().cancel()}
                //                    Button("Resume") {self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()}
                //                }
                
                self.isPaused ? Button("Restart") {self.resume()} : nil
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.black)
            .gesture(
                TapGesture()
                    .onEnded{
                        withAnimation{
                            self.heliPosition.y -= 150
                            
                        }
                    })
            
            .onReceive(self.timer) { _ in
                self.didHeliFellOffScreen(geo)
                self.collisionDetection()
                self.score += 1
                
                
            }
        }
        
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func gravity () {
        withAnimation{
            self.heliPosition.y += 50
            
        }
    }
    
    func didHeliFellOffScreen(_ geo: GeometryProxy) {
        if abs(heliPosition.y) > geo.size.height {
            pause()
            
        }
    }
    
    func obstMove () {
        if obstaclePosition.x > 0
        {
            withAnimation {
                self.obstaclePosition.x -= 20
                
            }
            
        }
        else
        { self.obstaclePosition.x = 1000
            self.obstaclePosition.y = CGFloat.random(in: 0...500)
        }
        
        
    }
    
    func pause() {
        self.timer.upstream.connect().cancel()
        self.isPaused = true
    }
    
    func resume() {
        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
        self.obstaclePosition.x = 1000
        self.heliPosition = CGPoint (x: 100, y: 100)
        self.isPaused = false
        self.score = 0
    }
    
    func collisionDetection() {
        // Se a posicao do eixo x do helicoptero subtraida da posicao do eixo x do obstaculo for menor do que a soma entre os centros do eixo x de cada um
        
        if abs(heliPosition.x - obstaclePosition.x) < (25 + 10) && abs(heliPosition.y - obstaclePosition.y) < (25 + 100){
            pause()
            
        }
    }
}
