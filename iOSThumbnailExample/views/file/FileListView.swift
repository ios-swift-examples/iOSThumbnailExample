//
//  FileListView.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/18.
//

import SwiftUI

struct FileListView: View {
    @StateObject var viewModel: FileListViewModel = .init()
    
    var body: some View {
        List(viewModel.files) { file in
            FileListItemView(viewModel: file)
        }
        .onAppear {
            viewModel.loadFiles()
        }
        
    
//        List($viewModel.files) { $file in
//            FileListItemView(viewModel: file)
//        }.onAppear {
//            viewModel.loadFiles()
//        }
    }
}

#Preview {
    FileListView()
}
