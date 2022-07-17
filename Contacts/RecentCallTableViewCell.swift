//
//  RecentCallTableViewCell.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 16/07/2022.
//

import UIKit

class RecentCallTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet private weak var callSourceLabel: UILabel!
    @IBOutlet private weak var callDateLabel: UILabel!
    @IBOutlet private weak var infoImageView: UIImageView!
    @IBOutlet private weak var outgoingCallImageView: UIImageView!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        outgoingCallImageView.isHidden = true
    }
}
// MARK: - Configure Recent Call Cell
extension RecentCallTableViewCell: RecentCallConfigurable {
    func configureCell(with model: RecentCallViewModel) {
        contactNameLabel.text = model.contactName
        callSourceLabel.text = model.callSource
        callDateLabel.text = model.callDate
        outgoingCallImageView.isHidden = model.isOutgoingCall ? false : true
        contactNameLabel.textColor = model.isMissedCall ?  .red : .black
    }
}
