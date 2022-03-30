//
//  SelectionStateManager.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 10/20/21.
//

import UIKit

protocol SelectionRepresentable: AnyObject {
    var isSelected: Bool { get set }
}

final class SelectionStateManager<T: SelectionRepresentable> where T: Equatable {

    var fields: [T] = []
    var allowsMultipleSelection: Bool

    init(allowsMultipleSelection: Bool = true) {
        self.allowsMultipleSelection = allowsMultipleSelection
    }

    func selectField(at index: Int) {
        fields[index].isSelected = true
    }

    func deselectField(at index: Int) {
        fields[index].isSelected = false
    }

    func fieldDidUpdate(isSelected: Bool, entity: T, didFinish: (() -> Void)? = nil) {

        if !allowsMultipleSelection {
            fields.forEach { $0.isSelected = false }
        }

        let entity = fields.first { $0 == entity }
        entity?.isSelected = isSelected
        didFinish?()
    }
}

enum SelectionButtonStageImages {

    case checkbox
    case radio
    case dropdown

    var selectedImage: UIImage {
        switch self {
        case .checkbox: return UIImage(named: "SelectedCheckBox")!
        case .radio: return UIImage(named: "SelectedRadio")!
        case .dropdown: return UIImage(systemName: "arrow.down.sware.fill")!
        }
    }

    var unselectedImage: UIImage {
        switch self {
        case .checkbox: return UIImage(named: "UnSelectedCheckBox")!
        case .radio: return UIImage(named: "UnSelectedRadio")!
        case .dropdown: return UIImage(systemName: "arrow.down.sware.fill")!
        }
    }
}

open class SelectionButton: UIButton, SelectionRepresentable {

    var selectionDidUpdate: ((Bool) -> Void)?
    var selectionButtonType: SelectionButtonStageImages = .checkbox {
        didSet {
            setUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    private func setUI() {
        setImage(selectionButtonType.unselectedImage, for: .normal)
        setImage(selectionButtonType.selectedImage, for: .selected)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        if selectionButtonType == .dropdown {
            applyStyleDropDown()
        }
    }

    func applyStyleDropDown() {
        borderWidth = 0.5
        borderColor = UIColor(named: "ApplicationTint")
        contentHorizontalAlignment = .right
        contentMode = .right
        semanticContentAttribute = .forceRightToLeft
        titleEdgeInsets.left = 2
        titleEdgeInsets.right = -2
        imageView?.borderColor = .clear
        backgroundColor = UIColor(named: "ApplicationTint")?.withAlphaComponent(CGFloat(0.08))
        cornerRadius = 10
    }

    @objc private func buttonTapped() {
        isSelected.toggle()
        selectionDidUpdate?(isSelected)
    }
}
