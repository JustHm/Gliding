//
//  ContentView.swift
//  Gliding
//
//  Created by 안정흠 on 7/23/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel = RecordListViewModel(usecase: SwimRecordUsecaseImpl(repository: HealthKitRecordRepositoryImpl()))
    @State private var isListType: Bool = true
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "chevron.left") {
                }
                Spacer()
                Text(verbatim: "\(viewModel.currentYear).\(String(format: "%02d", viewModel.currentMonth))")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                Button("", systemImage: "chevron.right") {
                }
                
                Spacer()
                Button("", systemImage: viewModel.listType.rawValue) {
                    viewModel.listType.toggle()
                    isListType.toggle()
                }
            }
            .padding()
            listTypeView()
                .animation(.easeInOut, value: isListType)
        }
        .task {
            
        }
    }
    @ViewBuilder
    func listTypeView() -> some View {
        if isListType {
//            List(viewModel.swimRecrods.workoutDates, id: \.self) { item in
//                Text(item.dateToString(format: "YYYY-MM-dd"))
//            }
        }
        else {
            Text("Calendar")
            TabView {
                
            }
//            CustomCalendarView(months: <#T##Binding<[[Date]]>#>, selection: <#T##Binding<Int>#>)
        }
    }
}

struct RecordListCell: View {
    let text: String
    var body: some View {
        Text("")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
