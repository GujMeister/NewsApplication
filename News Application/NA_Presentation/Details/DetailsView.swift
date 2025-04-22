//
//  DetailsView.swift
//  News Application
//
//  Created by Luka Gujejiani on 21.04.25.
//

import SwiftUI

struct DetailsView: View {
    
    // MARK: Properties
    
    @StateObject var vm: DetailsViewModel
    
    // MARK: Init
    
    init(vm: DetailsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    // MARK: Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(vm.article.title)
                    .font(.title).bold()
                
                Text("By \(vm.article.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                AsyncImage(url: vm.article.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().frame(height: 200)
                    case .success(let img):
                        img.resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    case .failure:
                        Color.gray.frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(vm.article.content)
            }
            .padding()
        }
        .navigationTitle("Article")
    }
}
