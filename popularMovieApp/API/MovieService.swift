//
//  MovieService.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import Moya

class MovieService: ServiceProtocol {
    var provider: MoyaProvider<MovieApi>!
    
    required init(isMock: Bool) {
        if isMock {
            provider = MoyaProvider<MovieApi>(stubClosure: MoyaProvider.immediatelyStub, plugins: self.moyaPlugins())
        } else {
            provider = MoyaProvider<MovieApi>(stubClosure: MoyaProvider.neverStub, plugins: self.moyaPlugins())
        }
    }
    
    func getPopularMovies(page: Int, completion: @escaping(Result<BaseModel<[MovieModel]>, APIError>)-> ()) {
        self.provider.request(.getPopularMovies(page: page)) { (result) in
            switch result {
            case.success(let response):
                do {
                    let responseModel = try Decoders.mainDecoder.decode(BaseModel<[MovieModel]>.self, from: response.data)
                    completion(.success(responseModel))
                }catch {
                    print(error)
                    completion(.failure(.parseError))
                }
                break
            case .failure(let error):
                let errorMessage = self.getResponseError(from: error)
                completion(.failure(errorMessage))
                break
            }
            
        }
    }
}
