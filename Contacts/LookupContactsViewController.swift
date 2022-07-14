//
//  ViewController.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 11/07/2022.
//

import UIKit

class LookupContactsViewController: UIViewController {
    typealias DataSource = ContactsTableViewDiffableDataSource
    // MARK: - Outlets
    @IBOutlet private weak var contactsTableView: UITableView!
    // MARK: - Properties
    var isSearchBarEmpty: Bool {
        navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        navigationItem.searchController?.isActive ?? false && !isSearchBarEmpty
    }
    var viewModel: LookupContactsViewModel = LookupContactsViewModel()
    private lazy var dataSource: DataSource = createDataSource()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
        setupContactsTableView()
        setupNavigationItem()
    }
    // MARK: - Methods
    private func configureBinding() {
        viewModel.contactsDicObservable.bind { [weak self] contactsDic in
            self?.dataSource.updateContactsDic(contactsDic)
        }
        
        viewModel.sectionTilesObservable.bind { [weak self] sectionTiles in
            self?.dataSource.updateSectionTiles(sectionTiles)
        }
        
        viewModel.filteredContactsDicObservable.bind { [weak self] filteredContactsDic in
            self?.dataSource.updateFilteredContactsDic(filteredContactsDic)
        }
    }
    
    private func setupContactsTableView() {
        dataSource.applySnapshot()
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
    
    private func createDataSource() -> DataSource {
        let dataSource = DataSource(tableView: contactsTableView) { tableView, indexPath, contactName in
            let cell = tableView.dequeueReusableCell(withIdentifier: contactCellReusableIdentifier, for: indexPath)
            cell.textLabel?.text = contactName
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }
}
// MARK: - Handling search capability in search controller
extension LookupContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        filterContentForSearchText(searchText)
        dataSource.applySnapshot(isFiltering: isFiltering)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.filterContentForSearchText(searchText)
    }
}
