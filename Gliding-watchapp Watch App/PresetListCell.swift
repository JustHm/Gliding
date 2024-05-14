//
//  PresetListCell.swift
//  Gliding-watchapp Watch App
//
//  Created by 안정흠 on 3/4/24.
//

import SwiftUI

struct PresetListCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Preset Name")
                .padding(.bottom, 8)
            HStack(alignment: .top) {
                Image(systemName: "figure.open.water.swim")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Spacer()
                Text("1000M")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    
            }
            
            
        }
    }
}

#Preview {
    PresetListCell()
}
