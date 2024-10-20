//
//  ChartViewModel.swift
//  WineBarChart
//
//  Created by Muhammad Zeeshan on 19/10/2024.
//

import Foundation

class ChartViewModel: ObservableObject {
    
    @Published var wines: [Wine]?
    @Published var selectedType: WineType?
    @Published var chartType: Chattype = .types   //MARK: Second Example Modification
    
    func setup(_ wines: [Wine]) {
        self.wines = wines
    }
    
    struct BarEntry: Identifiable {
        var name: String
        var inStock: Int
        var id: String {
            name
        }
    }
    
    //MARK: Second Chart Example From same Video
    enum Chattype: String, CaseIterable, Identifiable {
        case wineries, varieties, types
        var id: String {
            self.rawValue
        }
    }
    
    var allEnteries: [BarEntry] {
        if let wines {
            switch chartType {   // MARK: Second Example Modification
            case .wineries:
                return wines.map {BarEntry(name: $0.winery.name, inStock: $0.inStock)}
            case .varieties:
                return wines.map {BarEntry(name: $0.variety.name, inStock: $0.inStock)}
            case .types:
                return wines.map {BarEntry(name: $0.variety.wineType.rawValue, inStock: $0.inStock)}
            }
//            return wines.map {BarEntry(name: $0.variety.wineType.rawValue, inStock: $0.inStock)}
        } else {
            return []
        }
    }
    
    var grouping: [String : [BarEntry]] {
        Dictionary(grouping: allEnteries, by: {$0.name})
    }
    
    var groupings: [BarEntry] {
        var groupings: [BarEntry] = []
        
        for (name, entries) in grouping {
            let tt1 = entries.reduce(0) {$0 + $1.inStock}
            groupings.append(BarEntry(name: name, inStock: tt1))
        }
        return groupings.filter {$0.inStock > 0}
            .sorted(using: KeyPathComparator(\.name))
    }
    
    var selectedTypeWines: [Wine] {
        if let wines, let selectedType {
            return wines.filter {$0.variety.wineType == selectedType && $0.inStock > 0}
                .sorted(using: KeyPathComparator(\.variety.name))
        } else {
            return []
        }
    }
    
}
