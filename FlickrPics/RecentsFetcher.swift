//
//  Copyright © 2019 NewsUK. All rights reserved.
//

import Foundation



public enum RecentsResponse {
    case Recents(recents: [Photo])
    case Failed(error: RecentsError)
}

public struct Photo {
    let id: String
    let title: String
    let thumbnailUrl: String
    let fullSizeUrl: String
}

public enum RecentsError: Error {
    case FailedToRetrieveResult
    case FailedToParseResponse
}

public typealias RecentsResponseHandler = (RecentsResponse) -> Void


fileprivate typealias NetworkResponseHandler = (Data?, URLResponse?, Error?) ->  Void



struct RecentsFetcher {

    fileprivate static let recentsRequestUrl = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&format=json&api_key=234d8d2e42054c56240e4dc78740e220&extras=url_q,url_z")!

    fileprivate let sessionConfiguration: URLSessionConfiguration


    public init(sessionConfiguration: URLSessionConfiguration = URLSessionConfigurationProvider.defaultMainConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }


    public func fetchRecents(url: URL = recentsRequestUrl, withCompletion completionHandler: @escaping RecentsResponseHandler) {

        let networkCompletion: NetworkResponseHandler = { (data, urlResponse, error) in

            let parser = RecentsParser()

            guard error == nil, let data = data, let recents = parser.recentsFrom(data: data) else {
                completionHandler(RecentsResponse.Failed(error: .FailedToRetrieveResult)) // RJT: Improve errors
                return
            }
            //print("Recents:\n\(String(describing: recents))")

            completionHandler(RecentsResponse.Recents(recents: recents))
        }

        guard let dataTask = getTask(for: url, networkResponseHandler: networkCompletion) else {
            return
        }

        dataTask.resume()
    }

    fileprivate func getTask(for url: URL, networkResponseHandler: @escaping NetworkResponseHandler) -> URLSessionDataTask? {
        let dataTask = URLSession(configuration: sessionConfiguration).dataTask(with:url, completionHandler: networkResponseHandler)
        return dataTask
    }

}


fileprivate struct RecentsParser {

    func recentsFrom(data: Data) -> [Photo]? {

        let responseString = String(bytes: data, encoding: .utf8)
        let trimmedJson = String(responseString!.dropFirst(14).dropLast())
        let json = trimmedJson.data(using: .utf8)



        var response: Any? = nil
        do {
            response = try JSONSerialization.jsonObject(with: json!, options:[])
        }
        catch {
            print("\(error)")
        }

        guard let responseDictionary = response as? [String : Any],
        let photosPaged = responseDictionary["photos"] as? [String : Any],
        let photos = photosPaged["photo"] as? [[String : Any]]
            else {
                return nil
        }

        //print("Response:\n\(responseDictionary)")

        let extractedPhotos = extractPhotos(photoDictionaries: photos)

        return extractedPhotos
    }

   fileprivate func extractPhotos(photoDictionaries: [[String : Any]]) -> [Photo] {
        var recents: [Photo] = []

        for photoDictionary in photoDictionaries {
            guard let recent = extractPhoto(from: photoDictionary) else {
                break
            }
            recents += [recent]
        }
        return recents
    }

    fileprivate func extractPhoto(from photoDictionary: [String : Any]) -> Photo? {
        guard
            let id = photoDictionary["id"] as? String,
            let title = photoDictionary["title"] as? String,
            let thumb = photoDictionary["url_q"] as? String
            else {
                return nil
        }
        let big = photoDictionary["url_z"] as? String ?? ""

        return Photo(id: id, title: title, thumbnailUrl: thumb, fullSizeUrl: big)
    }
}


fileprivate struct URLSessionConfigurationProvider {

    static var userAgentString: String? = nil

    static var defaultMainConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        //configuration.httpShouldSetCookies = true
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy //reloadRevalidatingCacheData
        configuration.timeoutIntervalForRequest = 100
        //configuration.urlCache = URLCache.shared
        if let userAgentString = userAgentString {
            configuration.httpAdditionalHeaders = ["User-Agent" : userAgentString]
        }
        return configuration
    }

}
