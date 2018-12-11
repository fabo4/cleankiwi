//
//  SynchronousNetworkClient.swift
//  CleanKiwi
//
//  Created by Ondrej Fabian on 04/12/2018.
//  Copyright © 2018 Kiwi.com. All rights reserved.
//

import Foundation
import CleanKiwiCore

public enum ContentType {
    case json
    case wwwFormUrlEncoded
}

class SynchronousNetworkClient: NetworkClient {

    func run(request: NetworkClientRequest) throws -> NetworkClientResponse {
        let urlRequest = createNSURLRequest(request)
        let (data, urlResponse) = try sendSynchronousRequest(urlRequest)
        let response = try parseResponse(data, httpUrlResponse: urlResponse)
        return response
    }

    private func sendSynchronousRequest(_ urlRequest: URLRequest) throws
        -> (Data, HTTPURLResponse) {

            var urlData: Data?
            var urlResponse: URLResponse?
            var urlError: NSError?

            let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)

            let conf = URLSessionConfiguration.default
            let session = Foundation.URLSession(configuration: conf)

            session.dataTask(with: urlRequest, completionHandler: { data, response, error in
                urlData = data
                urlResponse = response
                urlError = error as NSError?

                semaphore.signal()
            }) .resume()

            _ = semaphore.wait(timeout: DispatchTime.distantFuture)

            if let error = urlError {
                NSLog("\(error)")
                throw NetworkClientError.networkError
            }

            guard let data = urlData, let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                throw NetworkClientError.networkError
            }

            return (data, httpUrlResponse)
    }

    private func createNSURLRequest(_ request: NetworkClientRequest) -> URLRequest {
        let urlRequest = NSMutableURLRequest()
        urlRequest.url = makeURL(request.urlString, method: request.method, parameters: request.parameters)
        urlRequest.allHTTPHeaderFields = addHeaders(contentType: .json)
        urlRequest.httpMethod = methodString(request.method)

        if request.method != .get {
            urlRequest.httpBody = makeRequestBodyDataIfAnyParams(request.parameters)
        }

        return urlRequest as URLRequest
    }

    private func methodString(_ method: NetworkClientRequest.Method) -> String {
        switch method {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }

    private func addHeaders(contentType: ContentType) -> [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = contentTypeString(contentType)
        return headers
    }

    private func contentTypeString(_ contentType: ContentType) -> String {
        switch contentType {
        case .wwwFormUrlEncoded:
            return "application/x-www-form-urlencoded"
        case .json:
            return "application/json"
        }
    }

    private func makeRequestBodyDataIfAnyParams(_ requestParameters: RequestParameters?) -> Data? {
        var bodyData: Data?
        if let params = requestParameters, !params.isEmpty {
            let bodyString = makeJSONRequestBodyString(params)
            bodyData = encodeBodyString(bodyString)
        }
        return bodyData
    }

    private func makeJSONRequestBodyString(_ params: RequestParameters) -> String {
        var bodyString = "{"
        for (key, value) in params {
            if bodyString.count > 1 {
                bodyString += ","
            }
            bodyString += "\"\(key)\":\"\(value)\""
        }
        return bodyString + "}"
    }

    private func encodeBodyString(_ bodyString: String) -> Data? {
        let data = bodyString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        return data
    }

    private func makeURL(_ urlString: String, method: NetworkClientRequest.Method, parameters: RequestParameters?) -> URL? {
        var urlComponents = URLComponents(string: urlString)

        if method == .get {
            urlComponents?.percentEncodedQuery = parameters?.map {
                urlEncodeParameter($0.key) + "=" + urlEncodeParameter("\($0.value)")
                }.joined(separator: "&") ?? ""
        }
        return urlComponents?.url
    }

    func parseResponse(_ responseBody: Data, httpUrlResponse: HTTPURLResponse) throws -> NetworkClientResponse {
        let body = try deserialize(responseBody)
        return NetworkClientResponse(body: body, statusCode: httpUrlResponse.statusCode)
    }

    private func urlEncode(_ string: String) -> String {
        if let encodedString = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return encodedString
        }

        return string
    }

    public func urlEncodeParameter(_ parameter: String) -> String {
        let unreservedSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-._~"))
        if let encodedString = parameter.addingPercentEncoding(withAllowedCharacters: unreservedSet) {
            return encodedString
        }

        return parameter
    }

    private func deserialize(_ data: Data) throws -> NetworkClientResponse.Body {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            if let dictionary = jsonObject as? [String: Any] {
                return .dictionary(dictionary)
            }

            if let array = jsonObject as? [[String: Any]] {
                return .array(array)
            }

            throw NetworkClientError.networkError

        } catch {
            NSLog("\(error)")
            throw NetworkClientError.networkError
        }
    }
}
