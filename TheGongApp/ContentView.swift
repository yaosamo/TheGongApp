//
//  ContentView.swift
//  TheGongApp
//
//  Created by Yaroslav Samoylov on 6/21/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {

    var body: some View {
        GongView().background(Color.black)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GongStats.self, inMemory: true)
}
