//
//  PersonDetailContracts.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

protocol PersonDetailViewModelProtocol {
    var delegate: PersonDetailViewModelDelegate? {get set}
    func load()
    func getPersonDetail()
}

protocol PersonDetailViewModelDelegate: class {
    func handlePersonDetailViewModelOutput(_ output: PersonDetailViewModelOutput)
}

enum PersonDetailViewModelOutput {
    case isLoading(Bool)
    case updateTitle(String)
    case showPersonDetail(PersonModel)
    case showError(String)
}
