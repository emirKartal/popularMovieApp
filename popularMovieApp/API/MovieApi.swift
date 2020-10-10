//
//  MovieAPI.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case getPopularMovies(page: Int)
}

extension MovieApi: TargetType {
    var baseURL: URL { return URL(string: "https://api.themoviedb.org")! }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "3/movie/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopularMovies:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPopularMovies(let page):
            let parameters: [String: Any] = ["api_key": API_KEY, "page": page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json",
        "Content-Type": "application/json"]
    }
}
