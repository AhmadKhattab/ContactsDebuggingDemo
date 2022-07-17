//
//  RecentsTableViewHeader.swift
//  Contacts
//
//  Created by Ahmad Ashraf Khattab on 16/07/2022.
//

import UIKit

class RecentsTableViewHeader: UITableViewHeaderFooterView {
    // MARK: - Properties
    @AutoLayout
    var recentsHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Recents"
        label.font = UIFont.boldSystemFont(ofSize: Constants.recentsHeaderLabelSize)
        label.textColor = .black
        return label
    }()
    // MARK: - Initializer(s)
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Method(s)
    private func configureContents() {
        contentView.addSubview(recentsHeaderLabel)
        NSLayoutConstraint.activate([
            recentsHeaderLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: Constants.recentsHeaderLabelLeading),
            recentsHeaderLabel
                .trailingAnchor
                .constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            recentsHeaderLabel
                .topAnchor
                .constraint(equalTo: self.topAnchor, constant: Constants.recentsHeaderLabelTop),
            self
                .bottomAnchor
                .constraint(equalTo: recentsHeaderLabel.bottomAnchor, constant: Constants.recentsHeaderLabelBottom)
        ])
    }
}
// MARK: - Constants
private extension RecentsTableViewHeader {
    struct Constants {
        static let recentsHeaderLabelSize: CGFloat = 40.0
        static let recentsHeaderLabelLeading: CGFloat = 50.0
        static let recentsHeaderLabelTop: CGFloat = 10.0
        static let recentsHeaderLabelBottom: CGFloat = 10.0
    }
}

@propertyWrapper
struct AutoLayout<View: UIView> {
    var value: View
    var wrappedValue: View {
        get {
            return value
        }
        
        set {
            value = newValue
        }
    }
    
    init(wrappedValue: View) {
        self.value = wrappedValue
        self.value.translatesAutoresizingMaskIntoConstraints = false
    }
}
