//
//  PersonDetailBuilder.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

final class PersonDetailBuilder {
    class func make(viewModel: PersonDetailViewModelProtocol)-> PersonDetailViewController {
        let vc = R.storyboard.person.personDetailViewController()!
        vc.viewModel = viewModel
        return vc
    }
}
