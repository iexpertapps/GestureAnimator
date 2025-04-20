//
//  MorphDemoView.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import SwiftUI
import os.signpost

@available(iOS 17.0, *)
struct MorphDemoView: View {
    @State private var morphProgress: CGFloat = 0.0
    @State private var selectedStyle: MorphStyle = .roundedToCircle
    @State private var frameTimes: [Date] = []
    @State private var fps: Int = 0

    private let log = OSLog(subsystem: "com.gestureanimator.demo", category: .pointsOfInterest)
    private let fpsSignpostID = OSSignpostID(log: OSLog(subsystem: "com.gestureanimator.demo", category: .pointsOfInterest))

    var body: some View {
        TimelineView(.animation(minimumInterval: 1/60, paused: false)) { context in
            let now = context.date

            VStack(spacing: 24) {
                Text("Morphing Demo")
                    .font(.title.bold())

                Spacer()

                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.purple)
                        .frame(width: 200, height: 200)
                        .gestureMorph(progress: $morphProgress, style: selectedStyle)
                        .animation(.easeInOut, value: morphProgress)
                        .onAppear {
                            os_signpost(.begin, log: log, name: "MorphEffectFPS", signpostID: fpsSignpostID)
                        }
                        .onDisappear {
                            os_signpost(.end, log: log, name: "MorphEffectFPS", signpostID: fpsSignpostID)
                        }
                }
                .frame(height: 200)

                Picker("Shape Style", selection: $selectedStyle) {
                    Text("Rounded → Circle").tag(MorphStyle.roundedToCircle)
                    Text("Capsule → Star").tag(MorphStyle.capsuleToStar)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 4) {
                    Text(String(format: "Progress: %.2f", morphProgress))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("FPS: \(fps)")
                        .font(.caption2)
                        .foregroundColor(fps >= 55 ? .green : .red)
                }
            }
            .padding()
            .onChange(of: now) { (timestamp: Date) in
                frameTimes.append(timestamp)
                frameTimes = frameTimes.filter { timestamp.timeIntervalSince($0) < 1 }
                fps = frameTimes.count
            }

        }
    }
}

@available(iOS 17.0, *)
struct MorphDemoView_Previews: PreviewProvider {
    static var previews: some View {
        MorphDemoView()
    }
}
