//
//  APIHandler.swift
//  JsonPlaceholderPhotoUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import Foundation
import Combine

class APIHandler {
    static let shared: APIHandler = .init()
        
    private init(){}
    
    func getData() -> AnyPublisher<[Photo], Error> {
        let url = URL(string: Constant.urlString)
        return URLSession.shared.dataTaskPublisher(for: url!)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                              httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
