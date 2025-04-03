//
//  Poster.swift
//  News Application
//
//  Created by Luka Gujejiani on 13.03.25.
//

import SwiftUI

struct Poster: View {
    
    // MARK: - Properties
    private let title: String
    private let image: Image
    private let date: String
    
    // MARK: - Init
    public init(parameters: Parameters) {
        self.title = parameters.title
        self.image = parameters.image
        self.date = parameters.date
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(25)
                .padding(.horizontal)
            
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text(date)
                .font(.footnote)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 5)
        }
    }
}
