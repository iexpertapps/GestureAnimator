//
//  GestureGalleryView.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import SwiftUI

struct GestureGalleryView: View {
    @State private var zoom: CGFloat = 1.0
    @State private var dragOffset: CGSize = .zero
    @State private var angle: Angle = Angle(degrees: 0)
    @State private var morphProgress: CGFloat = 0
    @State private var pathProgress: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Text("GestureAnimator Gallery")
                    .font(.largeTitle.bold())

                demoCard(title: "Zoom") {
                    if #available(iOS 16.0, *) {
                        Rectangle()
                            .fill(Color.blue.gradient)
                            .frame(width: 100, height: 100)
                            .gestureZoom(scale: $zoom)
                    } else {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 100, height: 100)
                            .gestureZoom(scale: $zoom)
                    }
                }

                demoCard(title: "Drag") {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 100, height: 100)
                        .gestureDrag(offset: $dragOffset)
                }

                demoCard(title: "Rotate") {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.orange)
                        .frame(width: 100, height: 100)
                        .gestureRotate(angle: $angle)
                }

                demoCard(title: "Morph") {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.purple)
                        .gestureMorph(progress: $morphProgress)
                }

                demoCard(title: "Custom Path") {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.indigo)
                        .gestureCustomPath(progress: $pathProgress) { t in
                            let clamped = min(max(t, 0), 1)
                            let x = 150 * sin(clamped * .pi * 2)
                            let y = 80 * cos(clamped * .pi * 2)
                            return CGPoint(x: x, y: y)
                        }
                }
            }
            .padding()
        }
    }

    @ViewBuilder
    func demoCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 12) {
            Text(title).font(.title2.bold())
            content()
                .frame(width: 200, height: 200)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 4)
        }
        .padding(.horizontal)
    }
}
