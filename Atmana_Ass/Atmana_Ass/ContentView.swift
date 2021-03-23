//
//  ContentView.swift
//  Atmana_Ass
//
//  Created by Sai Naveen Katla on 23/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 0, content: {
                ForEach(viewModel.categories, id:\.self) { element in
                    
                    Button(action: {
                        self.viewModel.presentCategory = element
                        self.viewModel.fetchJokes()
                    }, label: {
                        Text(element.capitalized)
                            .foregroundColor(.black)
                    })
                    .frame(width: 75)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(6)
                    .shadow(radius: 3)
                    .padding(.vertical)
                }
            })
            .background(Color.gray.opacity(0.6))
            .cornerRadius(12)
            
            Spacer()
                .frame(height: 45)
            
            Text("Selected Category: \(self.viewModel.presentCategory.capitalized)")
            
            HStack {
                Text(self.viewModel.joke)
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .padding(.horizontal, 15)
            }
            .frame(height: 300)
            .background(Color.blue.opacity(0.9))
            .cornerRadius(12)
            
            Button(action: {
                self.viewModel.fetchJokes()
            }, label: {
                Text("New Joke")
            })
            
            .navigationTitle("Chuck Norries")
        }.onAppear(perform: {
            self.viewModel.fetchCategories()
            self.viewModel.fetchJokes()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
