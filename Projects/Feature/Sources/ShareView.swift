//
//  ShareView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI
import LinkPresentation

public struct ShareView: View {

    public init() {}

    public var body: some View {
        ShareImage()
    }
}

struct ShareImage: View {

    var body: some View {
        Color.red
            .frame(width: 200, height: 200)
    }
}

class ImageMetadataProvider: UIActivityItemProvider {
  var image: UIImage

  override var item: Any {
    get {
      return self.image
    }
  }

  override init(placeholderItem: Any) {
    guard let image = placeholderItem as? UIImage else {
      fatalError("DEBUG ::: Couldn't create image from provided item")
    }

    self.image = image
    super.init(placeholderItem: placeholderItem)
  }

  @available(iOS 13.0, *)
  override func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {

    let metadata = LPLinkMetadata()
    metadata.title = "Result Image"

    var thumbnail: NSSecureCoding = NSNull()
    if let imageData = self.image.pngData() {
      thumbnail = NSData(data: imageData)
    }

    metadata.imageProvider = NSItemProvider(item: thumbnail, typeIdentifier: "public.png")

    return metadata
  }

}
