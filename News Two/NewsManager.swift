//
//  NewsManager.swift
//  News Two
//
//  Created by MacBook on 18.10.2021.
//

import Foundation

final class NewsManager {
    
    static let shared = NewsManager()
    
    struct Constants {
        
        // set url from string
        static let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2021-10-17&sortBy=popularity&apiKey=5da05c606b6846f7b5dbf3bd05653340")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result <[Articles], Error>) -> Void) {
        
        guard let url = Constants.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let data = data else { return }
            
            do {
                
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                
                print(result.articles.count)
                completion(.success(result.articles))
                
            } catch { print(error) }
        }
        
        task.resume()
                                
    }
}

struct APIResponse: Codable {
    
    let articles: [Articles]
}

struct Articles: Codable {
    
    let source: Source
    
    let title: String
    let urlToImage: String?
    let description: String?
    let url: String?
    let publishedAt: String
}

struct Source: Codable {
    
    let name: String
    
}
