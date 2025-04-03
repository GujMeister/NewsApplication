//
//  Poster.swift
//  News Application
//
//  Created by Luka Gujejiani on 13.03.25.
//

import SwiftUI

struct Poster: View {
    
    // MARK: - Properties
    
    private let state: LoadingState
    
    // MARK: - Initilizer
    
    public init(state: LoadingState = .loading) {
        self.state = state
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Group {
                switch state {
                case .loading:
                    loadingContent
                case .loaded:
                    loadedContent
                case .error:
                    errorContent
                }
            }
            .animation(.default, value: state)
        }
    }
    
    // MARK: - State Views
    
    /// Loading
    
    private var loadingContent: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 200)
                .padding(.horizontal)
                .shimmering()
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal)
            .shimmering()
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .shimmering()
        }
    }
    
    ///Loaded
    
    private var loadedContent: some View {
        Group {
            if case .loaded(let parameters) = state {
                parameters.image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(25)
                    .padding(.horizontal)
                
                Text(parameters.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text(parameters.date)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
            }
        }
    }
    
    /// Error
    
    private var errorContent: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .padding()
            
            Text("Failed to load content")
                .font(.headline)
        }
        .foregroundColor(.red)
        .padding()
    }
}
