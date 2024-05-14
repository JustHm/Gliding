//
//  ContentView.swift
//  Gliding-watchapp Watch App
//
//  Created by 안정흠 on 3/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List{
                Button {
                    print("Click")
                } label: {
                    PresetListCell()
                }
                
                NavigationLink(destination: PresetDetailView()
                    .navigationTitle("PresetName")) {
                        PresetListCell()
                    }
                
                PresetListCell()
                PresetListCell()
            }
            .navigationTitle("Gliding")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle({
//                Text("Gliding").foregroundStyle(.green.opacity(0.8))
//            })
//            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

#Preview {
    ContentView()
}
