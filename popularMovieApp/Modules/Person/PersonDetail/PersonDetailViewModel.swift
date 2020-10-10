//
//  PersonDetailViewModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

final class PersonDetailViewModel: PersonDetailViewModelProtocol {
    weak var delegate: PersonDetailViewModelDelegate?
    private var service: PersonService!
    private var personId: Int
    
    init(isMock: Bool = false, personId: Int) {
        service = PersonService(isMock: isMock)
        self.personId = personId
    }
    
    func load() {
        
    }
    
    func getPersonDetail() {
        service.getPersonDetail(id: personId) { [weak self](result) in
            guard let self = self else {return}
            switch result {
            case .success(let person):
                self.notify(.showPersonDetail(person))
                break
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
                break
            }
        }
    }
    
    private func notify(_ output: PersonDetailViewModelOutput) {
        delegate?.handlePersonDetailViewModelOutput(output)
    }
}
