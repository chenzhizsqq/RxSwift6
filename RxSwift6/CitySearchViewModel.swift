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
    //当它的值发生变化时，视图会自动更新。它用于绑定搜索框中的用户输入。
    @Published var searchText: String = ""
    
    //用于保存过滤后的城市列表，基于用户输入动态更新。
    @Published var filteredCities: [String] = []
    
    //DisposeBag 用于管理 RxSwift 的订阅生命周期。在这个例子中，它可以确保订阅在CitySearchViewModel 实例被销毁时自动解除，避免内存泄漏。
    private let disposeBag = DisposeBag()
    
    //这是一个静态的城市列表，作为数据源供搜索使用。
    private let cities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"]

    init() {
        setupBindings()
    }

    //用于设置搜索输入与结果的绑定。通过 RxSwift 操作符处理 searchText 的变化，并生成过滤后的城市列表。
    private func setupBindings() {
        //这里的 $searchText 是 @Published 属性包装器的一个投影，它提供一个 Publisher，允许我们订阅它的变化。
        $searchText
        
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)//这是 RxSwift 中常见的操作符之一，用于处理快速输入。它会等待用户停止输入 300 毫秒后，再将变化传递下去。这可以避免每次键入一个字符都触发搜索请求，减少不必要的性能消耗。
            .removeDuplicates()//这个操作符用于防止在输入内容没有变化时重复发出事件。比如，如果用户多次输入相同的内容，它会过滤掉重复的输入。
            .map { [unowned self] query in
                self.cities.filter { $0.lowercased().contains(query.lowercased()) }
            }
            .assign(to: &$filteredCities)//这个语句将过滤后的城市列表赋值给 @Published 属性 filteredCities，从而触发 UI 的更新。assign 是 Combine 框架中用于数据绑定的操作符，它将流中的值直接赋给指定的属性。
    }
}
