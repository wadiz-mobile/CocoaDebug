//
//  Example
//  man
//
//  Created by man on 11/11/2018.
//  Copyright © 2018 man. All rights reserved.
//

import UIKit

protocol WindowDelegate: class {
    func isPointEvent(point: CGPoint) -> Bool
}

class CocoaDebugWindow: UIWindow {
    
    static let y: CGFloat = 0.0000000000001
    
    weak var delegate: WindowDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
        #if swift(>=4.2)
        self.windowLevel = UIWindow.Level(rawValue: 2100 - CocoaDebugWindow.y)
        #else
        self.windowLevel = 2100 - CocoaDebugWindow.y
        #endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.delegate?.isPointEvent(point: point) ?? false
    }
}

extension WindowHelper: WindowDelegate {
    func isPointEvent(point: CGPoint) -> Bool {
        return self.vc.shouldReceive(point: point)
    }
}
