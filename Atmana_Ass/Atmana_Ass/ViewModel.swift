//
//  ViewModel.swift
//  Atmana_Ass
//
//  Created by Sai Naveen Katla on 23/03/21.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    private let networkService = NetworkService()
    
    @Published var categories: [String] = []
    @Published var joke: String = ""
    
    @Published var presentCategory = "music"
    
    private var cancellable: AnyCancellable?
    
    func fetchCategories() {
        self.networkService.getCategories { (value) in
            DispatchQueue.main.async {
                self.categories = value
            }
        }
    }
    
    func fetchJokes() {
        cancellable = self.networkService.getJokes(for: self.presentCategory).sink(receiveCompletion: { (_) in
            
        }, receiveValue: { (jokeModel) in
            self.joke = jokeModel.value
        })
    }
    
}


