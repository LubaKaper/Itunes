//
//  APIClient.swift
//  ITunes
//
//  Created by Liubov Kaper  on 11/24/20.
//

import Foundation


struct APIClient {
    // need a fuction to search for podcast
    // input is query String, output is a result type
    
    func fetchPodcasts(for query: String, completion: @escaping(Result<[Podcast], Error>) -> ()) {
        
        let endpoint = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(query)"
        guard let url = URL(string: endpoint) else {
            print("bad url")
            return
        }
        
        // why do we need a request?
        // what is a default http method when making a request?
        // GET
        // you need request when posting. Or if you using header or something complex to get data
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, resonse, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let jsonData = data {
                do {
                    let podcasts =  try JSONDecoder().decode(ResultWrapper.self, from: jsonData).results
                    completion(.success(podcasts))
                } catch {
                    completion(.failure(error))
                }
            }
    
        }
        dataTask.resume()
        
    }
    
}
