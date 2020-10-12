//
//  DetailView.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 12/10/2020.
//

import SwiftUI
import Combine
import SampleCombineShared

struct DetailView : View {
    private let viewModelViewWrapper: ViewModelViewWrapper<DetailsViewModel>
    
    private let navigator = SwiftUIDetailsNavigatorImpl()
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var detailsLabelText: StringCombineObservable
    
    init(text: String) {
        viewModelViewWrapper = ViewModelViewWrapper(viewModel: DetailsViewModel(text: text, navigator: DetailsNavigator(swiftUINavigator: navigator)))
        detailsLabelText = StringCombineObservable(architectureObservable: viewModelViewWrapper.viewModel.detailsLabelText)
    }
    
    var body: some View {
        viewModelViewWrapper.wrapView {
            return Text(self.detailsLabelText.value)
                .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading:
                                    Button(action: goBack) {
                                        HStack {
                                            Image(systemName: "arrow.left.circle")
                                            Text("Details")
                                        }
                                    }
                                )
                .onAppear() {
                navigator.viewRouter = viewRouter
            }
        }
    }
    
    func goBack() {
        viewModelViewWrapper.viewModel.close()
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(text: "Test")
    }
}

class SwiftUIDetailsNavigatorImpl : SwiftUIDetailsNavigator {

    var viewRouter: ViewRouter!
    
    func close() {
        switch viewRouter.currentPage {
        case .detail(_, let parent): viewRouter.currentPage = parent
        default: ()
        }
    }
    
}
