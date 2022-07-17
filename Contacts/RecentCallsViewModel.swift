//
//  RecentCallsViewModel.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 16/07/2022.
//

import Foundation

class RecentCallsViewModel {
    // MARK: - Properties
    private let allCalls: [RecentCallViewModel] = [
                                      RecentCallViewModel(contactName: "Ahmad Khattab",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Islam Muhammed",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: true,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Ibrahim Mustafa",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Yousef Sadik",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Osama Mahmood",
                                                          callSource: "mobile",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: true,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Mazen Adel",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: true),
                                      RecentCallViewModel(contactName: "Ziad Adel",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Ismail Ghaly",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Abanoub Maged",
                                                          callSource: "phone",
                                                          callDate: "7:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: true),
                                      RecentCallViewModel(contactName: "Achraf Hamed",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: true,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Sohil Ahmad",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: true),
                                      RecentCallViewModel(contactName: "Ahmad Mustafa",
                                                          callSource: "Phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: true),
                                      RecentCallViewModel(contactName: "Bahaa Ibrahim",
                                                          callSource: "Phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: true),
                                      RecentCallViewModel(contactName: "Osama Allam",
                                                          callSource: "Phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: true),
                                      RecentCallViewModel(contactName: "Ahmad Elmeshad",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: true),
                                      RecentCallViewModel(contactName: "Muhammed Samy",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: true,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Hesham Elsaify",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Sameh Elhelw",
                                                          callSource: "Phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: false,
                                                          isMissedCall: false),
                                      RecentCallViewModel(contactName: "Ahmad Galhoum",
                                                          callSource: "phone",
                                                          callDate: "4:30 PM",
                                                          isOutgoingCall: true,
                                                          isMissedCall: false)]
    private var missedCalls: [RecentCallViewModel] = []
    // MARK: - Initializer(s)
    init() {
        missedCalls = allCalls.filter { $0.isMissedCall }
    }
    // MARK: - Methods
    func getCallsCount(using filtrationOption: CallsFiltrationOption) -> Int {
        var callsCount: Int = .zero
        
        switch filtrationOption {
        case .all:
            callsCount = allCalls.count
        case .missed:
            callsCount = missedCalls.count
        }
        return callsCount
    }

    func configureCell(using cell: RecentCallConfigurable, index: Int, filtrationOption: CallsFiltrationOption) {
        switch filtrationOption {
        case .all:
            cell.configureCell(with: allCalls[index])
        case .missed:
            cell.configureCell(with: missedCalls[index])
        }
    }
}
