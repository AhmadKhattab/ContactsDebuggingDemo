//
//  RecentCallViewModel.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 16/07/2022.
//

import Foundation

struct RecentCallViewModel {
    let contactName: String
    let callSource: String
    let callDate: String
    let isOutgoingCall: Bool
    let isMissedCall: Bool
}

protocol RecentCallConfigurable {
    func configureCell(with model: RecentCallViewModel)
}
