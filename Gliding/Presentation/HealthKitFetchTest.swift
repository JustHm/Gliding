//
//  HealthKitFetchTest.swift
//  Gliding
//
//  Created by 안정흠 on 8/5/25.
//

import SwiftUI

struct HealthKitFetchTest: View {
    @State private var tabBarSelection: Int = 1
    @State private var filterImage: String = "calendar"
    let usecase: SwimRecordUsecase = SwimRecordUsecaseImpl(repository: HealthKitRecordRepositoryImpl())
    var body: some View {
        VStack {
            Button("HealthKit", action: {
                Task {
                    do {
                        let start = Date.createDate(year: 2025, month: 6, day: 4)!
                        _ = try await usecase.fetchSwimRecordByMonthly(start: start.startOfMonth()!, end: start.endOfMonth()!)
                        let temp = try await usecase.fetchSwimRecordByDay(date: start)
                        print("TEMP: ", temp)
                    }
                    catch {
                        print("ERROR", error.localizedDescription)
                    }
                }
            })
            HStack {
                Spacer()
                Image(systemName: "calendar")
                    .onTapGesture {
                    }
            }
            .padding()
            TabView(selection: $tabBarSelection) {
                VStack {
                    CalendarHeaderView()
                    WeekHeaderView()
                }.tabItem {
                    Text("1")
                }
                VStack {
                    CalendarHeaderView()
                    WeekHeaderView()
                }.tabItem {
                    Text("2")
                }
                VStack {
                    CalendarHeaderView()
                    WeekHeaderView()
                }.tabItem {
                    Text("3")
                }
            }
            .scaledToFit()
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .task {
            do {
                try await usecase.requestAuthorization()
//                let start = Date.createDate(year: 2025, month: 6, day: 1)!
//                let temp = try await usecase.fetchSwimRecordByMonthly(start: start, end: start.endOfMonth()!)
//                print("TEMP: ", temp)
            }
            catch {
                print("ERROR", error.localizedDescription)
            }
            
        }
        .onAppear {
            
        }
    }
}

#Preview {
    HealthKitFetchTest()
}
