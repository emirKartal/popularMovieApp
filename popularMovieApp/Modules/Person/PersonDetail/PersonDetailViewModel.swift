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
    private var person: PersonModel!
    
    init(isMock: Bool = false, personId: Int) {
        service = PersonService(isMock: isMock)
        self.personId = personId
    }
    
    func load() {
        getPersonDetail()
    }
    
    func getPersonDetail() {
        service.getPersonDetail(id: personId) { [weak self](result) in
            guard let self = self else {return}
            switch result {
            case .success(let person):
                self.person = person
                self.notify(.updateTitle(person.name ?? ""))
                self.getPersonCastMovies()
                break
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
                break
            }
        }
    }
    
    func getPersonCastMovies() {
        service.getPersonMovieCredits(id: personId) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let castList):
                self.person.prepareForPresentation(castList: castList)
                self.notify(.showPersonDetail(self.person))
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
