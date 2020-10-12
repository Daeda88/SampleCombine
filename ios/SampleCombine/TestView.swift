//
//  ContentView.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 25/09/2020.
//

import SwiftUI
import SampleCombineShared

struct SharedBuilder {
    let alertsInterfaceBuilder: AlertsAlertInterface.Builder
    let hudBuilder: HudHUD.Builder
}

struct TestView: View {
    let viewModelViewWrapper: ViewModelViewWrapper<TestViewModel>
    let dataContainer = EmptyViewControllerDataContainer<SharedBuilder>.init { (vc) -> SharedBuilder in
        return SharedBuilder.init(alertsInterfaceBuilder: AlertsAlertInterface.Builder(viewController: vc), hudBuilder: HudHUD.Builder(viewController: vc))
    }
    
    private let navigator: SwiftUITestNavigatorImpl = SwiftUITestNavigatorImpl()
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var nameFieldText: StringCombineSubject
    @ObservedObject var nameLabelText: StringCombineObservable
    
    init() {
        viewModelViewWrapper = ViewModelViewWrapper(viewModel: TestViewModel(alertBuilder: dataContainer.data.alertsInterfaceBuilder, hudBuilder: dataContainer.data.hudBuilder, navigator: TestNavigator(swiftUINavigator: navigator)))
        nameFieldText = StringCombineSubject(architectureSubject: viewModelViewWrapper.viewModel.nameFieldText)
        nameLabelText = StringCombineObservable(architectureObservable: viewModelViewWrapper.viewModel.nameLabelText)
    }

    var body: some View {
        viewModelViewWrapper.wrapView {
            return ZStack {
                dataContainer
                VStack {
                    TextField("Name", text: self.$nameFieldText.value)
                    .background(Color.gray)
                    Text(nameLabelText.value)
                    Button("Show result") {
                        self.viewModelViewWrapper.viewModel.printToLabel()
                    }
                    Button("Show alert") {
                        self.viewModelViewWrapper.viewModel.showAlert()
                    }
                    Button("Show Details") {
                        viewModelViewWrapper.viewModel.showDetails()
                    }
                }
                .padding()
                .onAppear() {
                    self.navigator.viewRouter = viewRouter
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

class SwiftUITestNavigatorImpl : SwiftUITestNavigator {
    
    var viewRouter: ViewRouter!
    
    func showDetails(string: String) {
        viewRouter.currentPage = Route.detail(text: string)
    }
}
