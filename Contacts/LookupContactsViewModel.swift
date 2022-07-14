//
//  LookUpContacsViewModel.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 13/07/2022.
//

import Foundation
import UIKit

class LookUpContactsViewModel {
    
    private var contacts: [String] = ["Ahmad Khattab",
                              "Ahmad Elfarsisy",
                              "Ahmad Amin",
                              "Bahaa Ibrahim",
                              "Catrin Jack",
                              "Dawood Amer",
                              "Esraa Mustafa",
                              "Fatma Saber",
                              "Ghali Zahir",
                              "Hadi Monir",
                              "Ibrahim Muhammed",
                              "Jody Salah",
                              "Khalid Osama",
                              "Kiro Maged",
                              "Lames Ahmad",
                              "Mounir Amer",
                              "Mohab Ali",
                              "Mina Kamal",
                              "Nada Achraf",
                              "Osama Achraf",
                              "Passant Ayman",
                              "Qusai Adel",
                              "Ramy Malek",
                              "Samy Muhammed",
                              "Soha Achraf",
                              "Tamer Habib",
                              "Usef Nwear",
                              "Varan Nick",
                              "Waleed Elsayed",
                              "Xodia",
                              "Younis Fady",
                              "Zoher Ramy"]
    
    private var contactsDic: [String: [String]] = [:]
    private var sectionTiles: [String] = []
    
    private(set) var contactsObservable: Observable<[String]> = Observable(value: [])
    private(set) var contactsDicObservable: Observable<[String: [String]]> = Observable(value: [:])
    private(set) var sectionTilesObservable: Observable<[String]> = Observable(value: [])
    private(set) var filteredContactsDicObservable: Observable<[String: [String]]> = Observable(value: [:])
    
    
    init() {
        setupContactsData()
        contactsDicObservable.value = contactsDic
        sectionTilesObservable.value = sectionTiles
    }
    
    private func setupContactsData() {
        let firstLetter: Int = 1
        sectionTiles = Array(Set(contacts.compactMap{ String($0.prefix(firstLetter)) })).sorted()
        sectionTiles.forEach { contactsDic[$0] = [] }
        contacts.forEach { contactsDic[String($0.prefix(firstLetter))]?.append($0) }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let filteredContacts = contacts.filter({ contact in
            contact.lowercased().contains(searchText.lowercased())
        })
        filteredContactsDicObservable.value = [topNameMatches: filteredContacts]
    }
}

class Observable<T> {
    typealias Observer = (T) -> Void
    var observers: [Observer]
    var value: T? {
        didSet {
            guard let value = value else {
                return
            }
            notifyObservers(value: value)
        }
    }
    
    init(value: T) {
        self.value = value
        self.observers = []
    }
    
    private func notifyObservers(value: T) {
        observers.forEach { observer in
            observer(value)
        }
    }
    
    func bind(observer: @escaping Observer) {
        observers.append(observer)
        guard let value = value else {
            return
        }
        notifyObservers(value: value)
    }
}
