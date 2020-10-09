//
//  ViewControllerBuilderWrapper.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 09/10/2020.
//

import SwiftUI
import UIKit

struct EmptyViewControllerDataContainer<D> : UIViewControllerRepresentable {
    
    /// The type of view controller to present.
    private let vc = UIViewController()
    let data: D
    
    init(_ createDataForViewController: (UIViewController) -> D) {
        data = createDataForViewController(vc)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<EmptyViewControllerDataContainer<D>>) -> UIViewController {
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<EmptyViewControllerDataContainer<D>>) {
        
    }
    
}
