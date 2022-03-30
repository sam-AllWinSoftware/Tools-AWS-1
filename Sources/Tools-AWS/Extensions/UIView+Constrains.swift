import UIKit

extension UIView {

    /// Adds a view as a subview and constrains it to the edges
    ///
    /// - Parameter subview: view to add as subview and constrain
    internal func addSubViewWithFillConstraints(_ subview: UIView, margin: CGFloat = 0) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false

        subview.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    }

    func addSubViewWithCenteredConstraints(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    public func addSubViewWithFillContriantsToSafeArea(_ subview: UIView) {
        addSubview(subview)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [topAnchor.constraint(equalTo: subview.safeAreaLayoutGuide.topAnchor),
             leadingAnchor.constraint(equalTo: subview.safeAreaLayoutGuide.leadingAnchor),
             bottomAnchor.constraint(equalTo: subview.safeAreaLayoutGuide.bottomAnchor),
             trailingAnchor.constraint(equalTo: subview.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
    }
}
