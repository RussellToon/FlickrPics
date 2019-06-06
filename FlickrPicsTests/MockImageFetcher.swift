import Foundation
@testable import FlickrPics

class MockImageFetcher: ImageFetcher {
    
    struct RecordedInvocations {
        var downloadImage: [(url: URL, completion: ImageResponseHandler)] = []
    }
    
    private(set) var recordedInvocations = RecordedInvocations()
    
    func downloadImage(from url: URL, withCompletion completionHandler: @escaping ImageResponseHandler) {
        recordedInvocations.downloadImage.append((url: url, completion: completionHandler))
    }
    
}
