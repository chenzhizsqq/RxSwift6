//
//  CitySearchView.swift
//  RxSwift6
//
//  Created by chenzhizs on 2024/10/18.
//

import SwiftUI

struct CitySearchView: View {
    @StateObject private var viewModel = CitySearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(viewModel.filteredCities, id: \.self) { city in
                    NavigationLink(destination: Text(city)) {
                        Text(city)
                    }
                }
            }
            .navigationTitle("City Search")
        }
    }
}

//struct CitySearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        CitySearchView()
//    }
//}
