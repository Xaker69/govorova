//
//  HighlightedButton.swift
//  PP
//
//  Created by Максим Храбрый on 11.03.2021.
//

import UIKit

class HighlightedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        isExclusiveTouch = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isExclusiveTouch = true
    }
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: [.curveEaseInOut, .allowUserInteraction],
                animations: {
                    let scale: CGFloat = self.isHighlighted ? 0.94 : 1.0
                    self.layer.setAffineTransform(CGAffineTransform(scaleX: scale, y: scale))
            },
                completion: nil
            )
            imageView?.alpha = 1.0
        }
    }

}

