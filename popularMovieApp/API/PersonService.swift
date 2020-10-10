//
//  PersonService.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import Moya

class PersonService: ServiceProtocol {
    var provider: MoyaProvider<MovieApi>!
    
    required init(isMock: Bool) {
        if isMock {
            provider = MoyaProvider<MovieApi>(stubClosure: MoyaProvider.immediatelyStub, plugins: self.moyaPlugins())
        } else {
            provider = MoyaProvider<MovieApi>(stubClosure: MoyaProvider.neverStub, plugins: self.moyaPlugins())
        }
    }
    
    func getPersonDetail(id: Int, completion: @escaping(Result< PersonModel, APIError>)-> ()) {
        provider.request(.personDetail(id: id)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let personModel = try Decoders.mainDecoder.decode(PersonModel.self, from: response.data)
                    completion(.success(personModel))
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
