//
//  NewsCell.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.03.25.
//

import SwiftUI
import Resolver
import Combine

struct NewsCell: View {
    
    // MARK: Properties
    
    let parameters: Parameters
    @Injected private var imageService: ImageFetching
    @State private var image: Image? = nil
    @State private var cancellable: AnyCancellable? = nil
    
    // MARK: Init
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
    
    // MARK: Body
    
    var body: some View {
        Group {
            if let imageToShow = image {
                post(imageToShow: imageToShow)
            } else {
                shimmering()
            }
        }
        .padding()
        .onAppear(perform: loadImage)
    }
    
    // MARK: Image Loading
    
    private func loadImage() {
        guard image == nil else { return }
        cancellable = imageService
            .fetchImage(from: parameters.image)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    
                },
                receiveValue: { fetched in
                    image = fetched
                }
            )
    }
}

// MARK: - ViewBuilders

private extension NewsCell {
    
    @ViewBuilder
    func shimmering() -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.gray.opacity(0.3))
            .frame(height: 200)
            .shimmering()
    }
    
    @ViewBuilder
    func post(imageToShow: Image) -> some View {
        VStack {
            if imageToShow != Image(systemName: "exclamationmark.triangle.fill") {
                imageToShow
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(25)
            }
            
            Text(parameters.title)
                .font(.headline)
                .bold()
        }
    }
}
