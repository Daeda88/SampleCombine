//
//  ContentView.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 25/09/2020.
//

import SwiftUI
import shared

struct ContentView: View {
    var viewModel: TestViewModel
    
    @ObservedObject var nameFieldText: StringCombineSubject
    @ObservedObject var nameLabelText: StringCombineObservable
    
    init() {
        viewModel = TestViewModel()
        nameFieldText = StringCombineSubject(architectureSubject: viewModel.nameFieldText)
        nameLabelText = StringCombineObservable(architectureObservable: viewModel.nameLabelText)
    }
    
//    deinit {
//        viewModel.clear()
//    }
    
    var body: some View {
        VStack {
            
            TextField("Name", text: $nameFieldText.value)
            .background(Color.gray)
            Text(nameLabelText.value)
            Button("Show result") {
                viewModel.printToLabel()
            }
        }
        .padding()
        .onAppear(perform: {
            viewModel.didResume()
        })
        .onDisappear(perform: {
            viewModel.didPause()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
