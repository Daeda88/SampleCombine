//
//  SampleCombineApp.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 25/09/2020.
//

import SwiftUI
import Combine

@main
struct SampleCombineApp: App {
    init() {
        viewRouter = ViewRouter()
    }
    
    @ObservedObject var viewRouter: ViewRouter
    var body: some Scene {
        WindowGroup {
            ContainerView().environmentObject(viewRouter)
        }
    }
}
