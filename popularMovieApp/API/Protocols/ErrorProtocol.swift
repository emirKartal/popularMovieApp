//
//  ErrorProtocol.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import Moya

public enum APIError: Error {
    case generalError
    case parseError
    case apiError(String)
    case connectionError
}

extension APIError: Equatable {
    
    public var localizedDescription: String {
        return getMessage()
    }
    
    private func getMessage()-> String {
        switch self {
        case .generalError, .parseError:
            return "Something went wrong!"
        case .connectionError:
            return "Check your internet connection!"
        case .apiError(let message):
            return message
        }
    }
}

protocol ErrorProtocol{}

extension ErrorProtocol {
    // This func changes type of Moya error to Our custom APIError
    func getResponseError(from error: MoyaError)-> APIError {
        if let data = error.response?.data {
            do{
                let apiError = try Decoders.mainDecoder.decode(ErrorModel.self, from: data)
                return .apiError(apiError.statusMessage ?? "")
            }catch {
                print(error)
                return .generalError
            }

        }else {
            let value = error.errorUserInfo["NSUnderlyingError"] as! APIError
            if value == .connectionError {
                return .connectionError
            }else {
                return .generalError
            }
        }
    }
}

