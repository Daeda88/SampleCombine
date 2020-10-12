//
//  ViewModelViewWrapper.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 25/09/2020.
//

import SwiftUI
import SampleCombineShared

class ViewModelViewWrapper<VM : BaseViewModel> {
    
    let viewModel: VM
    
    init(viewModel: VM) {
        self.viewModel = viewModel
    }
    
    deinit {
        viewModel.clear()
    }
    
    func wrapView<V : View>(view: () -> V) -> some View {
        return view().onAppear(perform: {
            self.viewModel.didResume()
        }).onDisappear(perform: {
            self.viewModel.didPause()
        })
    }
    
}
