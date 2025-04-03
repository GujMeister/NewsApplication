//
//  NewsCell.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.03.25.
//

import SwiftUI

struct NewsCell: View {
    
    // MARK: - Properties
    private let title: String
    private let image: Image
    
    // MARK: - Init
    
    public init(parameters: Parameters) {
        self.title = parameters.title
        self.image = parameters.image
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(25)
                .padding()
            
            Text(title)
                .padding(.horizontal)
        }
    }
}
