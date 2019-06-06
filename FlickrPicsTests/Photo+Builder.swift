@testable import FlickrPics

extension Photo {
    
    struct Builder {
        
        private var id: String = ""
        private var title: String = "Some Title"
        private var thumbnailUrl: String = "http://www.example.com/thumbnailUrl.png"
        private var fullSizeUrl: String = "http://www.example.com/fullSizeUrl.png"
        
        mutating func with(title: String) {
            self.title = title
        }
        
        func build() -> Photo {
            return Photo(
                id: id,
                title: title,
                thumbnailUrl: thumbnailUrl,
                fullSizeUrl: fullSizeUrl
            )
        }
        
    }
    
}
