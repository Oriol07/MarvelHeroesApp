//
//  MarvelAPI.swift
//  MarvelHeroesApp
//
//  Created by Oriol Comas Lluria on 19/5/23.
//

import Foundation
import CryptoKit

struct MarvelAPI
{
    private static let baseURL = "https://gateway.marvel.com/v1/public/"
    private static let publicKey = "3465f4b3208c876173af93cfd0d6e598"
    private static let privateKey = "5e5a87be38e51eaeb9a32bcfa737faa31aa986d1"
    
    static func fetchHeroes(completion: @escaping (Result<[MarvelHero], Error>) -> Void) {
        let endpoint = "characters"
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5
        
        let urlString = "\(baseURL)\(endpoint)?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
        
        guard let url = URL(string: urlString) else
        {
            completion(.failure(NSError(domain: "MarvelAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
        
        
            guard let data = data else
            {
                completion(.failure(NSError(domain: "MarvelAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //To do..
                let result = try decoder.decode(MarvelAPIResponse.self, from: data)
                let heroes = result.data.results
                //let heroNames = result.data.results.map {$0.name}
                completion(.success(heroes))
            }
            catch
            {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}


private extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.map{String(format: "%02hhx", $0)}.joined()
    }
}
