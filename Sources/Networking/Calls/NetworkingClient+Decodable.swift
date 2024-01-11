//
//  NetworkingClient+Decodable.swift
//  
//
//  Created by Sacha DSO on 12/04/2022.
//

import Foundation
import Combine

public extension NetworkingClient {

    func get<T: Decodable>(_ route: String,
                                         params: Params = Params(),
                                         keypath: String? = nil) -> AnyPublisher<T, Error> {
        return get(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Array version
    func get<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) -> AnyPublisher<T, Error> where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        return get(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func post<T: Decodable>(_ route: String,
                                          params: Params = Params(),
                                          keypath: String? = nil) -> AnyPublisher<T, Error> {
        return post(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func post<T: Decodable>(_ route: String,
                                          body: Encodable,
                                          keypath: String? = nil
    ) -> AnyPublisher<T, Error> {
        return post(route, body: body)
            .tryMap { json -> T in try NetworkingClient.toModel(json, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Array version
    func post<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) -> AnyPublisher<T, Error> where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        return post(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func put<T: Decodable>(_ route: String,
                                         params: Params = Params(),
                                         keypath: String? = nil) -> AnyPublisher<T, Error> {
        return put(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Array version
    func put<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) -> AnyPublisher<T, Error> where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        return put(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func patch<T: Decodable>(_ route: String,
                                           params: Params = Params(),
                                           keypath: String? = nil) -> AnyPublisher<T, Error> {
        return patch(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    

    func patch<T: Decodable>(_ route: String,
                                          body: Encodable,
                                          keypath: String? = nil
    ) -> AnyPublisher<T, Error> {
        return patch(route, body: body)
            .tryMap { json -> T in try NetworkingClient.toModel(json, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Array version
    func patch<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) -> AnyPublisher<T, Error> where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        return patch(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func delete<T: Decodable>(_ route: String,
                                            params: Params = Params(),
                                            keypath: String? = nil) -> AnyPublisher<T, Error> {
        return delete(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Array version
    func delete<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) -> AnyPublisher<T, Error> where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        return delete(route, params: params)
            .tryMap { [weak self] json -> T in try NetworkingClient.toModel(json, jsonDecoderFactory: self?.jsonDecoderFactory, keypath: keypath) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


public extension NetworkingClient {
    
    func get<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T {
        let json: Any = try await get(route, params: params)
        let model: T = try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
        return model
    }
    
    func get<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        let json: Any = try await get(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func post<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T {
        let json: Any = try await post(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func post<T: Decodable>(_ route: String,
                                          body: Encodable,
                                          keypath: String? = nil
    ) async throws -> T {
        let json: Any = try await post(route, body: body)
        return try NetworkingClient.toModel(json, keypath: keypath)
    }
    
    func post<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        let json: Any = try await post(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func put<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T {
        let json: Any = try await put(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func put<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        let json: Any = try await put(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func patch<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T {
        let json: Any = try await patch(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func patch<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        let json: Any = try await patch(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func patch<T: Decodable>(_ route: String,
                                          body: Encodable,
                                          keypath: String? = nil
    ) async throws -> T {
        let json: Any = try await patch(route, body: body)
        return try NetworkingClient.toModel(json, keypath: keypath)
    }
    
    func delete<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T {
        let json: Any = try await delete(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
    
    func delete<T: Decodable>(_ route: String,
                           params: Params = Params(),
                           keypath: String? = nil) async throws -> T where T: Collection {
        let keypath = keypath ?? defaultCollectionParsingKeyPath
        let json: Any = try await delete(route, params: params)
        return try NetworkingClient.toModel(json, jsonDecoderFactory: jsonDecoderFactory, keypath: keypath)
    }
}
