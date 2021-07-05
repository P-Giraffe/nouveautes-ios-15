//
//  ContentView.swift
//  canvas_demo
//
//  Created by Maxime Britto on 05/07/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TimelineView(.animation) { timelineContext in
            Canvas { canvasContext, size in
                canvasContext.stroke(
                    Path(ellipseIn: CGRect(origin: .zero, size: size)),
                    with: .color(.green),
                    lineWidth: 4)
                canvasContext.draw(Text(timelineContext.date.formatted(.dateTime.minute().second())), at: CGPoint(x: size.width/2, y: size.height/2))
            }
        }
        
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
