//
//  APIExtensions.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

extension CityWeatherRequest : APIEndpoint {
    
    func endpoint() -> String {
        return "/data/2.5/weather"
    }
    
    func params() -> String {
        return "?q=\(self.q.formatToAPI())&appid=\(self.appid)&units=\(self.units)"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: CityWeatherResponse) -> Void),
        onFailure failureHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)) {
            
            APIRequest.get (
                request: self,
                onSuccess: successHandler,
                onError : failureHandler
            )
        }
}

extension CoordinateWeatherRequest : APIEndpoint {
    
    func endpoint() -> String {
        return "/data/2.5/weather"
    }
    
    func params() -> String {
        return "?lat=\(self.lat)&lon=\(self.lon)&appid=\(self.appid)&units=\(self.units)"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: CityWeatherResponse) -> Void),
        onFailure failureHandler: @escaping ((_: APIRequest.ErrorResponse?, _: Error) -> Void)) {
            
            APIRequest.get (
                request: self,
                onSuccess: successHandler,
                onError : failureHandler
            )
        }
}

extension APIRequest {
    public static func get<R: Codable & APIEndpoint, T: Codable, E: Codable>(
        request: R,
        onSuccess: @escaping ((_: T) -> Void),
        onError: @escaping ((_: E?, _: Error) -> Void)) {

        guard var endpointRequest = self.urlRequest(from: request) else {
            onError(nil, APIError.invalidEndpoint)
            return
        }
            
        endpointRequest.httpMethod = "GET"
        endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        URLSession.shared.dataTask(
            with: endpointRequest,
            completionHandler: { (data, urlResponse, error) in
                DispatchQueue.main.async {
                    self.processResponse(data, urlResponse, error, onSuccess: onSuccess, onError: onError)
                }
        }).resume()
    }
    
    public static func processResponse<T: Codable, E: Codable>(
        _ dataOrNil: Data?,
        _ urlResponseOrNil: URLResponse?,
        _ errorOrNil: Error?,
        onSuccess: ((_: T) -> Void),
        onError: ((_: E?, _: Error) -> Void)) {

        if let data = dataOrNil {
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                onSuccess(decodedResponse)
            } catch {
                let originalError = error

                do {
                    let errorResponse = try JSONDecoder().decode(E.self, from: data)
                    onError(errorResponse, APIError.errorResponseDetected)
                } catch {
                    onError(nil, originalError)
                }
            }
        } else {
            onError(nil, errorOrNil ?? APIError.noData)
        }
    }
    
    public static func urlRequest(from request: APIEndpoint) -> URLRequest? {
        let endpoint = request.endpoint()
        let params = request.params()
        guard let endpointUrl = URL(string: "\(Constants.API_BASE)\(endpoint)\(params)") else {
            return nil
        }

        var endpointRequest = URLRequest(url: endpointUrl)
        endpointRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return endpointRequest
    }
}
