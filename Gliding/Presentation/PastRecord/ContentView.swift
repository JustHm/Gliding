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
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button("", systemImage: "chevron.left") {
                        viewModel.prevMonth()
                        Task {
                            do {
                                try await viewModel.fetchMonthlyRecords()
                            }
                            catch {
                                print("fetchMonthlyRecords error: \(error)")
                            }
                        }
                    }
                    Spacer()
                    Text(viewModel.selectedMonth.dateToString(format: "yyyy.MM"))
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                    Button("", systemImage: "chevron.right") {
                        viewModel.nextMonth()
                        Task {
                            do {
                                try await viewModel.fetchMonthlyRecords()
                            }
                            catch {
                                print("fetchMonthlyRecords error: \(error)")
                            }
                        }
                    }
                    
                    Spacer()
                    Button("", systemImage: viewModel.listType.rawValue) {
                        viewModel.listType.toggle()
                    }
                }
                .padding([.leading, .trailing, .top], 16.0)
                listTypeView()
                    .animation(.easeInOut, value: viewModel.listType)
            }
        }
        .task {
            do {
                try await viewModel.fetchMonthlyRecords()
            }
            catch {
                print("fetchMonthlyRecords error: \(error)")
            }
        }
    }
    
    @ViewBuilder
    func listTypeView() -> some View {
        if viewModel.listType == .list {
            List(viewModel.recordList, id: \.self) { item in
                NavigationLink(
                    destination: RecordDetailView(selected: item, viewModel: viewModel)
                ) {
                    PastRecordListCell(record: item)
                }
            }
        }
        else if viewModel.listType == .calendar {
            Text("Calendar")
            TabView {
                
            }
        }
        else { Text("잘못된 보기 방식") }
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
