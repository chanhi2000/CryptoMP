//
//  LineGraph.swift
//  MenubarApp (iOS)
//
//  Created by chlee on 2022/04/27.
//

import SwiftUI

struct LineGraph: View {
    var data: [Double]
    var profit: Bool = false
    
//    @State var currentPlot = ""
//    @State var offset: CGSize = .zero
//    @State var showPlot = false
//    @State var transition: CGFloat = 0
    
    @State var graphProgress: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0)
            let minPoint = (data.min() ?? 0)
            
            let points = data.enumerated().compactMap { item -> CGPoint in
                
                // getting progress and multiplying with height ...
                // It's showing from 0
                // Making to show from minimum amount
                let progress = (item.element - minPoint) / (maxPoint - minPoint)
//                let pathHeight = progress * (height - 50)
                let pathHeight = progress * (height)
                
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            ZStack {
                AnimatedGraphPath(progress: graphProgress, points: points)
                .fill(
                    // Gradient ...
                    LinearGradient(colors: [
                        profit ? Color("Profit") : Color("Loss"),
                        profit ? Color("Profit") : Color("Loss")
                    ], startPoint: .leading, endPoint: .trailing)
                )
                FillBG()
                // Clipping the shape ...
                .clipShape(
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLines(points)
                        path.addLine(to: CGPoint(x: proxy.size
                            .width, y: height))
                        path.addLine(to: CGPoint(x: 0, y: height))
                    }
                )
                .opacity(graphProgress)
            }
        }
        .padding(.horizontal, 10)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 1.2)) {
                    graphProgress = 1
                }
            }
        }
    }
    
    @ViewBuilder
    func FillBG() -> some View {
        let color = profit ? Color("Profit") : Color("Loss")
        LinearGradient(colors: [
            color
                .opacity(0.3),
            color
                .opacity(0.2),
            color
                .opacity(0.1)
        ]
        + Array(repeating: color.opacity(0.1), count: 4)
        + Array(repeating: Color.clear, count: 2), startPoint: .trailing, endPoint: .leading)
    }
}

struct AnimatedGraphPath: Shape {
    var progress: CGFloat
    var points: [CGPoint]
    var animatableData: CGFloat {
        get{return progress}
        set{progress = newValue}
    }
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLines(points)
        }
        .trimmedPath(from: 0, to: progress)
        .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
