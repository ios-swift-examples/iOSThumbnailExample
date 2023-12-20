//
//  ThumbnailService.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/19.
//

import Foundation
import UIKit

protocol ThumbnailService {
    func getThumbnail(_ url: URL) async -> UIImage?
}
