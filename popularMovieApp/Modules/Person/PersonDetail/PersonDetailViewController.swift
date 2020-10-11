//
//  PersonDetailViewController.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    var viewModel: PersonDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var person: PersonModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
    
    private func setUIElements() {
        
    }

}
extension PersonDetailViewController: PersonDetailViewModelDelegate {
    func handlePersonDetailViewModelOutput(_ output: PersonDetailViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            break
        case .updateTitle(let title):
            self.navigationItem.title = title
            break
        case .showPersonDetail(let person):
            self.person = person
            setUIElements()
            break
        case .showError(let errorMessage):
            showAlert(alertTitle: "Error", alertMessage: errorMessage)
            break
        }
    }
}
