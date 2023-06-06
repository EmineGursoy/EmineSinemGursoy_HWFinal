//
//  MusicService.swift
//  
//
//  Created by Emine Sinem on 6.06.2023.
//

import Foundation
import Alamofire

public protocol MusicServiceProtocol: AnyObject {
    func fetchMusics(completion: @escaping (Result<[Music], Error>) -> Void)
}

public class MusicService: MusicServiceProtocol {
    
    public init() {}
    
    public func fetchMusics(completion: @escaping (Result<[Music], Error>) -> Void) {
       
        let urlString = "https://itunes.apple.com/search?entity=song&term=tarkan"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = Decoders.dateDecoder
                
                do {
                    let response = try decoder.decode(MusicResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("JSON Decode Error")
                }
            case .failure(let error):
                print("Gecici bir hata olustu \(error.localizedDescription)")
            }
        }
    }
}
