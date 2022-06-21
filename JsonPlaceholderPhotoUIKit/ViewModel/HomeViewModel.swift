//
//  HomeViewModel.swift
//  JsonPlaceholderPhotoUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var error: Error? = nil
    
    private var photoSubscription: AnyCancellable?
        
    init(){
        photoSubscription = APIHandler.shared.getData()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion{
                case .failure(let error):
                    self?.error = error
                case .finished:
                    print("finished")
                }
            }, receiveValue: { [weak self] receivedPhotos in
                self?.photos = receivedPhotos
            })
    }
}
