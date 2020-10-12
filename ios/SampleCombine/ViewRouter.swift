//
//  ViewRouter.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 12/10/2020.
//

import SwiftUI
import Combine

enum Route {
    case home
    case detail(text: String)
}

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: Route = .home {
        didSet {
            objectWillChange.send(self)
        }
    }
}
