//
//  File.swift
//  Common
//
//  Created by Ha Jong Myeong on 11/9/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import UIKit
import LinkPresentation

public class ImageMetadataProvider: UIActivityItemProvider {
  var image: UIImage

  public override var item: Any {
      return self.image
  }

  public override init(placeholderItem: Any) {
    guard let image = placeholderItem as? UIImage else {
      fatalError("DEBUG ::: Couldn't create image from provided item")
    }

    self.image = image
    super.init(placeholderItem: placeholderItem)
  }

  @available(iOS 13.0, *)
  public override func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {

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
