import UIKit
import SwiftUI
import Combine

class MyModel: ObservableObject {
    @Published var value: Int = 0
}

class MyViewController: UIViewController {
    var model = MyModel()
    var cancellables = Set<AnyCancellable>()
    
    // Binding stored as a member variable
    private var bindingText: Binding<String>?
    
    // Hosting controller for SwiftUI view
    private var hostingController: UIHostingController<MySwiftUIView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Embed SwiftUI View in UIViewController
        let swiftUIView = MySwiftUIView(model: model)
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Add the SwiftUI view to the ViewController's view hierarchy
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // Set constraints or frame
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
        
        self.hostingController = hostingController
        
        // Add a button to change the text
        let changeTextButton = UIButton(type: .system)
        changeTextButton.setTitle("Change Text \(model.value)", for: .normal)
        changeTextButton.addTarget(self, action: #selector(changeTextButtonTapped), for: .touchUpInside)
        changeTextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeTextButton)
        
        // Position the button
        NSLayoutConstraint.activate([
            changeTextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeTextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        model.$value.sink { v in
            print(v)
            changeTextButton.setTitle("Change Text: \(v)", for: .normal)
        }.store(in: &cancellables)
    }
    
    // Action to change the text on button tap
    @objc private func changeTextButtonTapped() {
        model.value = model.value + 1
    }
}
