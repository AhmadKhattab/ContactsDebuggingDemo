//
//  ContactsTableViewDiffableDataSource.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 13/07/2022.
//

import UIKit

class ContactsTableViewDiffableDataSource: UITableViewDiffableDataSource<String, String> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, String>
    
    private var contactsDic: [String: [String]] = [:]
    private var sectionTiles: [String] = []
    private var filteredContactsDic: [String: [String]] = [:]
    
    func updateContactsDic(_ contactsDic: [String: [String]]) {
        self.contactsDic = contactsDic
    }
    
    func updateSectionTiles(_ sectionTiles: [String]) {
        self.sectionTiles = sectionTiles
    }
    
    func updateFilteredContactsDic(_ filteredContactsDic: [String: [String]]) {
        self.filteredContactsDic = filteredContactsDic
    }

    func applySnapshot(animatingDifferences: Bool = true, isFiltering: Bool = false)
    {
        var snapshot = Snapshot()
        let sections: [String] = isFiltering ? [topNameMatches] : sectionTiles
        let items: [String: [String]] = isFiltering ? filteredContactsDic : contactsDic
       
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(items[section] ?? [], toSection: section)
        }
        self.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionIdentifier(for: section)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTiles
    }
}
