//
//  MySwiftUIView.swift
//  UIKitWrapSwiftUI
//
//  Created by Rex Chen on 2024/9/18.
//

import SwiftUI

struct MySwiftUIView: View {
    @ObservedObject var model: MyModel
    var body: some View {
        HStack {
            Text("\(model.value)")
            Button(action: {
                model.value += 1
            }) {
                Text("Increment")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    MySwiftUIView(model: MyModel())
}
