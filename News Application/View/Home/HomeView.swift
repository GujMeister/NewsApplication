//
//  HomeView.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties
    @EnvironmentObject var homeViewModel: HomeViewModel

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Top Story")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)

                if let posterParams = homeViewModel.posterParameters {
                    Poster(parameters: posterParams)
                } else {
                    Text("Loading poster...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: geometry.size.width * 0.9, height: 2)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                if !homeViewModel.newsCellParameters.isEmpty {
                    VStack {
                        ForEach(homeViewModel.newsCellParameters, id: \.self) { param in
                            NewsCell(parameters: param)
                        }
                    }
                } else {
                    Text("Loading articles...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
        }
        .onAppear {
            homeViewModel.fetchArticles()
        }
    }
}
