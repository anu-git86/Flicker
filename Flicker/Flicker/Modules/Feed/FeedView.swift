//
//  FeedView.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import SwiftUI

struct FeedView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = FeedViewModel()
    let gridItems:[GridItem] = Array(repeating: GridItem(), count: 3)
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                contentView
            }
        }
        .searchable(text: $viewModel.searchText) 
        .task {
            await viewModel.getPosts()
        }
    }
}

extension FeedView {
    
    private var contentView: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, alignment: .center, spacing: 10) {
                ForEach(viewModel.posts, id: \.id) { item in
                    gridItem(item)
                }
            }
            .padding(.all, 10)
        }
    }
    
    private func gridItem(_ item: Item) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
            let url = URL(string: item.media?.m ?? "")
            AsyncImage(url: url) { image  in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .shadow(color: Color.primary.opacity(0.3), radius: 1)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    FeedView()
}
