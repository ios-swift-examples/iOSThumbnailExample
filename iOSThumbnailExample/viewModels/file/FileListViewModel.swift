//
//  FileListViewModel.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/18.
//

import Foundation

class FileListViewModel: ObservableObject {
    @Published var files: [FileListItemViewModel] = []
    
    func loadFiles() {
        guard files.isEmpty else {
            return
        }
        
        if let imageUrl = Bundle.main.url(forResource: "sample", withExtension: "png") {
            files.append(.init(file: .init(url: imageUrl)))
        }
        
        if let audioUrl = Bundle.main.url(forResource: "sample", withExtension: "mp3") {
            files.append(.init(file: .init(url: audioUrl)))
        }
        
        if let videoUrl = Bundle.main.url(forResource: "sample", withExtension: "mp4") {
            files.append(.init(file: .init(url: videoUrl)))
        }
        
        if let pdfUrl = Bundle.main.url(forResource: "sample", withExtension: "pdf") {
            files.append(.init(file: .init(url: pdfUrl)))
        }
    }
    
    func itemViewModel(for file: File) -> FileListItemViewModel {
        return .init(file: file)
    }
}
