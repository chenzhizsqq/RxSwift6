//
//  CitySearchViewModel.swift
//  RxSwift6
//
//  Created by chenzhizs on 2024/10/18.
//

import Foundation
import RxSwift
import RxCocoa

class CitySearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredCities: [String] = []
    
    private let disposeBag = DisposeBag()
    private let cities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"]

    init() {
        setupBindings()
    }

    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [unowned self] query in
                self.cities.filter { $0.lowercased().contains(query.lowercased()) }
            }
            .assign(to: &$filteredCities)
    }
}
