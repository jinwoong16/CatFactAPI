//
//  ContentView.swift
//  CatAPI
//
//  Created by jinwoong Kim on 2023/09/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        Button("Click") {
            self.viewModel.tapButton()
        }
        .alert(
            isPresented: $viewModel.showingAlert
        ) {
            Alert(
                title: Text("Daily Cats"),
                message: Text(viewModel.text),
                dismissButton: .default(Text("Dismiss"))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
