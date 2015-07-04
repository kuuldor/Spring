// The MIT License (MIT)
//
// Copyright (c) 2015 James Tang (j@jamztang.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

public class AsyncButton: UIButton {

    private var imageURL = [UInt:NSURL]()
    private var placeholderImage = [UInt:UIImage]()


    public func setImageURL(url: NSURL?, placeholderImage placeholder:UIImage?, forState state:UIControlState) {

        imageURL[state.rawValue] = url
        placeholderImage[state.rawValue] = placeholder

        if let urlString = url?.absoluteString {
            ImageLoader.sharedLoader.imageForUrl(urlString) { [weak self] image, url in
                if image != nil {
                    if let strongSelf = self {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if strongSelf.imageURL[state.rawValue]?.absoluteString == url {
                                strongSelf.setImage(image, forState: state)
                            }
                        })
                    }
                }
            }
        }
    }

}
