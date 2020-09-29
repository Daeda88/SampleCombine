//
//  ContentView.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 25/09/2020.
//

import SwiftUI
import SampleCombineShared

struct ContentView: View {
    let viewModelViewWrapper: ViewModelViewWrapper<TestViewModel>
    
    @ObservedObject var nameFieldText: StringCombineSubject
    @ObservedObject var nameLabelText: StringCombineObservable
    
    init() {
        viewModelViewWrapper = ViewModelViewWrapper(viewModel: TestViewModel())
        nameFieldText = StringCombineSubject(architectureSubject: viewModelViewWrapper.viewModel.nameFieldText)
        nameLabelText = StringCombineObservable(architectureObservable: viewModelViewWrapper.viewModel.nameLabelText)
    }

    var body: some View {
        viewModelViewWrapper.wrapView {
            return VStack {
                
                TextField("Name", text: self.$nameFieldText.value)
                .background(Color.gray)
                Text(nameLabelText.value)
                Button("Show result") {
                    self.viewModelViewWrapper.viewModel.printToLabel()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
