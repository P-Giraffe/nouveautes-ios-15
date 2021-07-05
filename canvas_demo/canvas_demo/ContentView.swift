//
//  ContentView.swift
//  canvas_demo
//
//  Created by Maxime Britto on 05/07/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Canvas { canvasContext, size in
            canvasContext.stroke(
                Path(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 200, height: 300))),
                with: .color(.green),
                lineWidth: 4)
        }
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
