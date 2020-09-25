//
//  ViewModelViewWrapper.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 25/09/2020.
//

import SwiftUI
import shared

class ViewModelViewWrapper<VM : ArchitectureBaseViewModel> {
    
    let viewModel: VM
    
    init(viewModel: VM) {
        self.viewModel = viewModel
    }
    
    deinit {
        viewModel.clear()
    }
    
    func wrapView<V : View>(view: () -> V) -> some View {
        return view().onAppear(perform: { [unowned self] in
            self.viewModel.didResume()
        }).onDisappear(perform: { [unowned self] in
            self.viewModel.didPause()
        })
    }
    
}
