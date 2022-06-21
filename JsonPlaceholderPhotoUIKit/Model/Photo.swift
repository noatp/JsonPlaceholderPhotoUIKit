//
//  Photo.swift
//  JsonPlaceholderPhotoUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import Foundation

struct Photo: Decodable, Identifiable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
}
