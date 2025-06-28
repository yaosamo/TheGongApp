//
//  GongView.swift
//  TheGongApp
//
//  Created by Yaroslav Samoylov on 6/22/25.
//

import Foundation
import SwiftUI
import SwiftData
import SceneKit
import AVFoundation

struct GongView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var stats: [GongStats]
    @State private var isPressed = false
    @State var hitCount = 0
    @State private var message: String = ""
    
    let messages = [
        "Boom!",
        "That was epic!",
        "🎉 Congratulations!",
        "Strike of greatness!",
        "Another one for the books!",
        "Keep it coming!",
        "Immaculate 🔔",
        "Glorious!",
        "Legendary!",
        "Pure excellence."
    ]

class GongSound {
            static var player: AVAudioPlayer?

            static func play() {
                if let url = Bundle.main.url(forResource: "gongHit", withExtension: "mp3") {
                    player = try? AVAudioPlayer(contentsOf: url)
                    player?.volume = 0.5
                    player?.play()
                }
            }
        }

    var body: some View {
        ZStack {
                VStack {
                    HStack {
                        Text("\(stats.first?.hitCount ?? 0)")
                            .font(.custom("Xanh Mono", size: 50))
                            .foregroundColor(.white)
                            .padding(.top, 64)
                            .padding(.leading, 64)
                        Spacer()
                    }
                    Spacer()
                }
            VStack {
                Image("gong")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .padding(48)
                    .scaleEffect(isPressed ? 0.85 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.4), value: isPressed)
                    .onTapGesture {
                        isPressed = true
                        
                        // Delay triggering unpress long enough to allow animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                isPressed = false
                            }
                        }
                        
                        // 🎯 Do something here like play sound or increment count
                        print("Gong tapped!")
                        GongSound.play()
                        if let statsModel = stats.first {
                            statsModel.hitCount += 1
                        }
                        message = messages.randomElement() ?? ""
                        
                    }
                Text(message)
                    .font(.custom("Xanh Mono", size: 40))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 48)
            }
            }
        .onAppear {
            if stats.isEmpty {
                modelContext.insert(GongStats(hitCount: 0)) // Create a default record if none exists
            }
        }
        }
    }



#Preview {
    ContentView()
        .modelContainer(for: GongStats.self, inMemory: true)
}

