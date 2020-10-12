//
//  ViewRouter.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 12/10/2020.
//

import SwiftUI
import Combine

enum Route {
    case home(view: TestView)
    indirect case detail(view: DetailView, parent: Route)
}

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: Route = .home(view: TestView()) {
        didSet {
            objectWillChange.send(self)
        }
    }
}
