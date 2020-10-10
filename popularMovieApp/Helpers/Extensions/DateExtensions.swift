//
//  DateExtensions.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

extension Date {
    func convertToString(format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "tr-TR")
        let dateString = formatter.string(from: self)
        return dateString
    }
}
