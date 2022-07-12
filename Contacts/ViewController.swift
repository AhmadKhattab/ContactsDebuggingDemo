//
//  ViewController.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 11/07/2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var contactsTableView: UITableView!
    // MARK: - Properties
    var contacts: [String] = ["Ahmad Khattab",
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
    
    var contactsDic: [String: [String]] = [:]
    var sectionTiles: [String] = []
    var filteredContacts: [String] = []
    var isSearchBarEmpty: Bool {
        navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        navigationItem.searchController?.isActive ?? false && !isSearchBarEmpty
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContactsTableView()
        setupContactsData()
        setupNavigationItem()
        
        
    }
    // MARK: - Methods
    private func setupContactsTableView() {
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        contactsTableView.layoutMargins = UIEdgeInsets.zero
    }
    
    private func setupContactsData() {
        let firstLetter: Int = 1
        sectionTiles = Array(Set(contacts.compactMap{ String($0.prefix(firstLetter)) })).sorted()
        sectionTiles.forEach { contactsDic[$0] = [] }
        contacts.forEach { contactsDic[String($0.prefix(firstLetter))]?.append($0) }
    }
    
    private func setupNavigationItem() {
        title = contactsTitle
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = searchBarPlaceholder
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }
}
// MARK: - Implementing UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredContacts.count : contactsDic[sectionTiles[section]]?.count ?? .zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let singleSection: Int = 1
        return isFiltering ? singleSection : sectionTiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellReusableIdentifier, for: indexPath)
        var contactName: String = ""
        if isFiltering {
            contactName = filteredContacts[indexPath.row]
        } else {
            contactName = contactsDic[sectionTiles[indexPath.section]]?[indexPath.row] ?? unknownContact
        }
        cell.textLabel?.text = contactName
        return cell
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTiles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isFiltering ? topNameMatches : sectionTiles[section]
    }
}
// MARK: - Handling search capability in search controller
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterContentForSearchText(searchText)
        contactsTableView.reloadData()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredContacts = contacts.filter({ contact in
            contact.lowercased().contains(searchText.lowercased())
        })
    }
}

