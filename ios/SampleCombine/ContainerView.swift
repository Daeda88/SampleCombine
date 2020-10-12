//
//  ContainerView.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 12/10/2020.
//

import SwiftUI
import Combine

struct ContainerView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            switch viewRouter.currentPage {
            case Route.home: TestView()
            case Route.detail(let text): DetailView(text: text)
            }
        }
    }
    
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
