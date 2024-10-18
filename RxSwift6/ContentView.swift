//
//  ContentView.swift
//  RxSwift6
//
//  Created by chenzhizs on 2024/10/18.
//

import SwiftUI
import RxSwift
import RxCocoa

struct ContentView: View {
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
            CitySearchView()
        }
        .padding()
    }
}


//#Preview {
//    ContentView()
//}
