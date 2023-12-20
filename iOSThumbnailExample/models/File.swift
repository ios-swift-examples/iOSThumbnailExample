//
//  file.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/18.
//

import Foundation
import UIKit

struct File {
    var url: URL {
        didSet{
            self.name = self.url.lastPathComponent
        }
    }
    var name: String
    var image: UIImage?
    
    init(url: URL) {
        self.url = url
        self.name = self.url.lastPathComponent
    }
}
