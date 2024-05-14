//
//  SwimComponentView.swift
//  Gliding-watchapp Watch App
//
//  Created by 안정흠 on 3/4/24.
//

import SwiftUI

struct SwimComponentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("자유형")
                Spacer()
                Text("5 X 100M")
            }
            Text("속도 - 50%")
            Text("짧은 설명 부탁드립니다. 몇글자까지가 오버일까요?")
        }
    }
}

#Preview {
    SwimComponentView()
}
