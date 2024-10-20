//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-16
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct WineLog {
    var variety: String
    var quantity: Int
    var country: String
    var entryDate: Date
}

func date(year: Int, month: Int, day: Int) -> Date {
    Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
}

struct NominalChartExample: View {
         let wine1 = WineLog(variety: "Chardonnay",
                         quantity: 15,
                         country: "Canada",
                         entryDate: date(year: 2022, month: 7, day: 22))
        let wine2 = WineLog(variety: "Merlot",
                         quantity: 20,
                         country: "United States",
                         entryDate: date(year: 2022, month: 7, day: 23))

    var body: some View {
        NavigationStack {
            VStack {
                // Replace this VStack with a chart
            }
          .padding()
            .navigationTitle("Nominal Bar Chart")
        }
    }
}

struct NominalChartExample_Previews: PreviewProvider {
    static var previews: some View {
        NominalChartExample()
    }
}
