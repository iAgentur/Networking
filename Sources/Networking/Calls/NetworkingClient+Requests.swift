//
//  NetworkingClient+Requests.swift
//
//
//  Created by Sacha on 13/03/2020.
//

import Foundation
import Combine

public extension NetworkingClient {

    func getRequest(_ route: String, params: Params = Params()) -> NetworkingRequest {
        request(.get, route, params: params)
    }

    func postRequest(_ route: String, params: Params = Params()) -> NetworkingRequest {
        request(.post, route, params: params)
    }

    func putRequest(_ route: String, params: Params = Params()) -> NetworkingRequest {
        request(.put, route, params: params)
    }
    
    func patchRequest(_ route: String, params: Params = Params()) -> NetworkingRequest {
        request(.patch, route, params: params)
    }

    func deleteRequest(_ route: String, params: Params = Params()) -> NetworkingRequest {
        request(.delete, route, params: params)
    }
    
    internal func request(_ httpMethod: HTTPMethod,
                          _ route: String,
                          params: Params = Params(),
                          encodableBody: Encodable? = nil) -> NetworkingRequest {
        let req = NetworkingRequest()
        req.httpMethod           = httpMethod
        req.route                = route
        req.params               = params
        req.encodableBody        = encodableBody
        
        updateRequest(req)
        req.requestRetrier = { [weak self, weak req] in
            self?.requestRetrier?($0, $1)?
                .handleEvents(receiveOutput: { [weak self, weak req] _ in
                    if let req {
                        self?.updateRequest(req)
                    }
                })
                .eraseToAnyPublisher()
        }
        return req
    }
    
    private func updateRequest(_ req: NetworkingRequest) {
        req.baseURL              = baseURL
        req.logLevel             = logLevel
        req.headers              = headers
        req.parameterEncoding    = parameterEncoding
        req.sessionConfiguration = sessionConfiguration
        req.timeout              = timeout
    }
    
}
