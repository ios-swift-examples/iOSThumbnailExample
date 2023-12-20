//
//  FileListItemViewModel.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/18.
//

import Foundation
import SwiftUI

class FileListItemViewModel: ObservableObject, Identifiable {
    let id =  UUID()
    
    private(set) var file: File
    private(set) var thumbnail: UIImage?
    private(set) var name: String
    
    private(set) var thumbnailService: ThumbnailService
    
    init(file: File, thumbnailService: ThumbnailService = LocalFileThumbnailService.shared) {
        self.file = file
        self.thumbnailService = thumbnailService
        self.name = file.name
    }
    
    func updateThumbnail() async {
        if let _ = file.image{
            return
        }
        
        thumbnail = await thumbnailService.getThumbnail(file.url)
    }
}
