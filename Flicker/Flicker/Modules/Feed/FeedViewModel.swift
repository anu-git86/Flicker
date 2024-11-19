//
//  FeedViewModel.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import Foundation
import Combine

final class FeedViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var posts: [Item] = []
    @Published var searchText: String = ""
    private var cancellables: Set<AnyCancellable> = []
    private let debounceTime = 0.5
    
    init() {
        setupSearch()
    }
    
}

// MARK: - Helpers

extension FeedViewModel {
    
    func getPosts() async {
        let postQuery = PostQuery(format: "json",
                                  nojsoncallback: "1",
                                  tags: searchText)
        do {
            let post:Post = try await APIClient.sendRequest(endPoint: .posts(postQuery))
            DispatchQueue.main.async { [weak self] in
                self?.posts = post.items ?? []
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func setupSearch() {
        $searchText
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard !query.isEmpty else {
                    self?.posts = []
                    return
                }
                Task {
                    await self?.getPosts()
                }
            }
            .store(in: &cancellables)
    }
}
