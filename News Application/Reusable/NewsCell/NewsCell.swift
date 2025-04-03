//
//  NewsCell.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.03.25.
//

import SwiftUI

struct NewsCell: View {
    
    // MARK: - Properties
    
    private let state: LoadingState
    
    // MARK: - Init
    
    public init(state: LoadingState) {
        self.state = state
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Group {
                switch state {
                case .loading:
                    loadingContent
                case .loaded(let parameters):
                    loadedContent(parameters: parameters)
                }
            }
            .animation(.default, value: state)
        }
    }
    
    // MARK: - View States
    
    private var loadingContent: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 200)
                .shimmering()
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 16)
                .padding(.horizontal)
                .shimmering()
        }
        .padding()
    }
    
    private func loadedContent(parameters: Parameters) -> some View {
        VStack {
            parameters.image
                .resizable()
                .scaledToFit()
                .cornerRadius(25)
                .padding()
            
            Text(parameters.title)
                .padding(.horizontal)
        }
    }
}
