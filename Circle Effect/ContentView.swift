//
// ContentView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct ContentView: View {
    @State private var position: CGPoint = .zero
    @State private var circleColor: Color = .red
    @State private var circleSize: CGFloat = 120.0

    var body: some View {
        VStack {
            GeometryReader { proxy in
                let proxyWidth = proxy.size.width * 0.5
                let proxyHeight = proxy.size.height * 0.5

                Canvas { context, size in
                    context.addFilter(.alphaThreshold(min: 0.8, color: circleColor))
                    context.addFilter(.blur(radius: 22))

                    // Created by @AlbertMoral
                    context.drawLayer { ctx in
                        ctx.fill(Path(ellipseIn: CGRect(x: proxyWidth + position.x - circleSize / 2,
                                                        y: proxyHeight + position.y - 200,
                                                        width: circleSize, height: circleSize)), with: .color(circleColor))

                        ctx.fill(Path(ellipseIn: CGRect(x: proxyWidth - 150,
                                                        y: proxyHeight - 300,
                                                        width: 300, height: 300)), with: .color(circleColor))
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            position = .init(x: gesture.translation.width, y: gesture.translation.height)
                        }
                )
            }
            
            // Circle Color Picker
            ColorPicker("Circle Color", selection: $circleColor)
                .padding()
            
            // Circle Size Slider
            VStack {
                Text("Circle Size: \(Int(circleSize))")
                Slider(value: $circleSize, in: 50...200, step: 1)
                    .padding()
            }
        }
    }
}

