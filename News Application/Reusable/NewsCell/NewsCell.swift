//
//  NewsCell.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.03.25.
//

import SwiftUI

struct NewsCell: View {
    
    // MARK: Properties
    
    @StateObject var vm: NewsCellViewModel
    @EnvironmentObject private var homeVM: HomeViewModel
    
    // MARK: Init
    
    init(vm: NewsCellViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    // MARK: Body
    
    var body: some View {
        VStack {
            switch vm.state {
            case .loading:
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .shimmering()
                    .padding()
                
            case .loaded(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(25)
                    .padding()
                
            case .failed:
                Color.clear
                    .onAppear {
                        homeVM.remove(vm.id)
                    }
            }
            
            Text(vm.title)
                .font(.headline)
                .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .onChange(of: vm.id) {
            vm.loadImage()
        }
    }
}
