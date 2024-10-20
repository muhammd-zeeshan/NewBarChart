//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-13
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI
import Charts

struct InOutBarChartView: View {
    var logEnteries: [LogEntry]
    @StateObject var vm = InOutViewModel()
    @State private var scrolWidth = 450.0
    
    var body: some View  {
        NavigationStack {
            List {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Chart(vm.allLogs) { log in
                            BarMark(
                                x: .value("Month", log.theMonth),
                                y: .value("Quantity", log.actual)
                            )
                            .annotation(position: log.action == .in ? .top : .bottom) {
                                Text("\(log.actual)")
                                    .font(.caption)
                            }
                            .foregroundStyle(log.action == .in ? .purple : .green)
                        }
                        .chartPlotStyle { plotArea in
                            plotArea
                                .frame(width: scrolWidth, height: 350)
                        }
                    }
                }
                
                Section {
                    Picker("Year", selection: $vm.year) {
                        ForEach(Year.allCases, id: \.self) { year in
                            Text(year.rawValue).tag(year)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    VStack(alignment: .leading) {
                        Text("ScrollVZiew width \(scrolWidth, specifier: "%.0f")")
                        Slider(value: $scrolWidth, in: 450 ... 1600) {
                            Text("ScrollView Width")
                        } minimumValueLabel: {
                            Text("450")
                        } maximumValueLabel: {
                            Text("!600")
                        }

                    }
                }
            }
            .navigationTitle("Wines In/Out")
        }
        .onAppear {
            vm.setup(logEnteries)
            vm.year = .year1
        }
    }
}

struct InOutBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        InOutBarChartView(logEnteries: DataStore().logEntries)
    }
}
