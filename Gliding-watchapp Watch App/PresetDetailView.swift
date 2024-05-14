//
//  PresetDetailView.swift
//  Gliding-watchapp Watch App
//
//  Created by 안정흠 on 3/4/24.
//

import SwiftUI

struct PresetDetailView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Warm up") {
                    SwimComponentView()
                }
                Section("Main") {
                    SwimComponentView()
                }
                Section("Cool Down") {
                    Text("자유형 100M")
                }
            }
        }
        .navigationTitle("PresetName")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        PresetDetailView()
    }
    
        
}
