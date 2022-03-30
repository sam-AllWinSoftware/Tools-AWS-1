import UIKit

final class UITextFieldWithToolTip: UITextField {
    
    var toolTipIsVisible: Bool = false
    private var UIToolTip = UIView()
    
    private var toolTipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.contentMode = .center
        label.textColor = .white
        label.layer.cornerRadius = 6
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = ThemeFactory.color(.sunOrange)
        return label
    }()
    
    private var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = ThemeFactory.color(.sunOrange)
        return layer
    }()
    
    private func pointerPath(_ pointerTip: CGPoint, _ pointerBaseLeft: CGPoint, _ pointerBaseRight: CGPoint) -> UIBezierPath {
        let pointer = UIBezierPath()
        pointer.move(to: pointerBaseLeft)
        pointer.addLine(to: pointerTip)
        pointer.addLine(to: pointerBaseRight)
        pointer.close()
        return pointer
    }
    
    private func toolTipLabelSetConstrains() {
        
        toolTipLabel.translatesAutoresizingMaskIntoConstraints = false
        toolTipLabel.bottomAnchor.constraint(equalTo: UIToolTip.bottomAnchor, constant: -8).isActive = true
        toolTipLabel.topAnchor.constraint(equalTo: UIToolTip.topAnchor).isActive = true
        toolTipLabel.leadingAnchor.constraint(equalTo: UIToolTip.leadingAnchor).isActive = true
        toolTipLabel.trailingAnchor.constraint(equalTo: UIToolTip.trailingAnchor).isActive = true
    }
    
    private func uiToolTipSetConstrains(labelWidth: CGFloat, labelHeight: CGFloat) {
        
        UIToolTip.translatesAutoresizingMaskIntoConstraints = false
        UIToolTip.bottomAnchor.constraint(equalTo: topAnchor, constant: -12 + 8).isActive = true
        UIToolTip.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        UIToolTip.heightAnchor.constraint(equalToConstant: labelHeight + 8).isActive = true
        UIToolTip.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
    }
    
    func displayTooltip(_ message: String, _ completion: (() -> Void)? = nil) {
        
        let padding = CGPoint(x: 18, y: 12)
        toolTipIsVisible = true
        toolTipLabel.text = "    \(message)    "
        UIToolTip.addSubview(toolTipLabel)
        toolTipLabelSetConstrains()
        
        let labelHeight = message.setTextDimension(withMeasure: .greatestFiniteMagnitude, font: UIFont.systemFont(ofSize: 12), .height) + padding.y
        let labelWidth  = message.setTextDimension(withMeasure: .zero, font: UIFont.systemFont(ofSize: 12), .width) + padding.x
        
        let pointerTip = CGPoint(x: labelWidth / 2, y: labelHeight + 8)
        let pointerBaseLeft = CGPoint(x: labelWidth / 2 - 14 / 2, y: labelHeight)
        let pointerBaseRight = CGPoint(x: labelWidth / 2 + 14 / 2, y: labelHeight)
        
        shapeLayer.path = pointerPath(pointerTip, pointerBaseLeft, pointerBaseRight).cgPath
        
        UIToolTip.layer.addSublayer(shapeLayer)
        (superview ?? self).addSubview(UIToolTip)
        uiToolTipSetConstrains(labelWidth: labelWidth, labelHeight: labelHeight)
        
        UIToolTip.alpha = 0
        UIView.animate(withDuration: 0.2, animations: { self.UIToolTip.alpha = 0.95 }, completion: { _ in
            completion?()
        })
    }
    
    func hideToolTipIfIsVisible() {
        guard toolTipIsVisible else { return }
        UIView.animate(withDuration: 0.5, delay: 2, animations: { self.UIToolTip.alpha = 0 }) { _ in
            self.UIToolTip.removeFromSuperview()
            self.toolTipIsVisible = false
        }
    }
}

extension String {
    
    enum DimensionType {
        case width, height
    }
    
    func setTextDimension(withMeasure constrainedMeasure: CGFloat, font: UIFont, _ dimensionType: DimensionType) -> CGFloat {
        
        let constraintRect = dimensionType == .height ?
        CGSize(width: .greatestFiniteMagnitude, height: constrainedMeasure) :
        CGSize(width: constrainedMeasure, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return dimensionType == .height ? ceil(boundingBox.height) : ceil(boundingBox.width)
    }
    
}
