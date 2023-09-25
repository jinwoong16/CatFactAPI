//
//  ContentViewModel.swift
//  CatAPI
//
//  Created by jinwoong Kim on 2023/09/21.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    private let networkManager: NetworkManager = DefaultNetworkManager()
    
    @Published var text: String = ""
    @Published var showingAlert = false
    
    func tapButton() {
        Task { [weak self] in
            do {
                let facts = try await self?.networkManager.parseText(
                    animal: "cat",
                    amount: 2,
                    method: .GET
                ) ?? []
                
                self?.text = facts
                    .map { $0.text }
                    .joined(separator: "\n")
                
                self?.showingAlert = true
            } catch {
                print(error)
            }
        }
    }
}
