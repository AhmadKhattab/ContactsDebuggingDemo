//
//  RecentCallsViewController.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 16/07/2022.
//

import UIKit

class RecentCallsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var recentsSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var recentsTableView: UITableView!
    
    @IBAction func indexChanged(_ sender: Any) {
        recentsTableView.reloadData()
    }
    // MARK: - Properties
    private let viewModel: RecentCallsViewModel = RecentCallsViewModel()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecentsTableView()
        registerRecentsTableViewCell()
        registerRecentsTableViewHeader()
    }
    // MARK: - Methods
    private func setupRecentsTableView() {
        recentsTableView.dataSource = self
        recentsTableView.delegate = self
    }
    
    private func registerRecentsTableViewCell() {
        let recentCallTableViewCellNibFile = UINib(nibName: String(describing: RecentCallTableViewCell.self), bundle: nil)

        recentsTableView
            .register(recentCallTableViewCellNibFile, forCellReuseIdentifier: recentCallCellReusableIdentifier)
    }
    
    private func registerRecentsTableViewHeader() {
        recentsTableView
            .register(RecentsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: recentsHeaderReusableIdentifier)
    }
    
    private func getCallsFiltrationOption() -> CallsFiltrationOption? {
        CallsFiltrationOption(rawValue: recentsSegmentedControl.selectedSegmentIndex)
    }
}
// MARK: - UITableViewDataSource & UITableViewDelegate
extension RecentCallsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filtrationOption = getCallsFiltrationOption() else {
            return .zero
        }
        return viewModel.getCallsCount(using: filtrationOption)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recentCallCellReusableIdentifier, for: indexPath) as! RecentCallTableViewCell
        guard let filtrationOption = getCallsFiltrationOption() else {
            return cell
        }
        viewModel.configureCell(using: cell, index: indexPath.row, filtrationOption: filtrationOption)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: recentsHeaderReusableIdentifier)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.recentsTableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.recentsTableViewHeaderHeight
    }
}
// MARK: - Constants
private extension RecentCallsViewController {
    struct Constants {
        static let recentsTableViewRowHeight: CGFloat = 80.0
        static let recentsTableViewHeaderHeight: CGFloat = 60.0
    }
}

enum CallsFiltrationOption: Int {
    case all = 0
    case missed = 1
}



