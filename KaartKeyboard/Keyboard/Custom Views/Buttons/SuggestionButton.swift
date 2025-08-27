//
//  SuggestionButton.swift
//  ELDeveloperKeyboard
//
//  Created by Eric Lin on 2014-07-04.
//  Copyright (c) 2014 Eric Lin. All rights reserved.
//

import Foundation
import UIKit

/**
    The method declared in the SuggestionButtonDelegate protocol allow the adopting delegate to respond to messages from the SuggestionButton class, handling button presses and long presses.
*/
protocol SuggestionButtonDelegate: class {
    /**
        Respond to the SuggestionButton being pressed.
    
        - parameter button: The SuggestionButton that was pressed.
    */
    func handlePressForSuggestionButton(_ button: SuggestionButton)
    
    /**
        Respond to the SuggestionButton being long pressed.
    
        - parameter button: The SuggestionButton that was long pressed.
    */
    func handleLongPressForSuggestionButton(_ button: SuggestionButton)
}

class SuggestionButton: UIButton {
    
    // MARK: Properties
    
    weak var delegate: SuggestionButtonDelegate?
    
    var title: String {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    // MARK: Constructors
    
    init(frame: CGRect, title: String, delegate: SuggestionButtonDelegate?) {
        self.title = title
        self.delegate = delegate
        
        super.init(frame: frame)
        
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18.0)
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.darkGray, for: .highlighted)
        
        titleLabel?.sizeToFit()
        addTarget(self, action: #selector(SuggestionButton.buttonPressed(_:)), for: .touchUpInside)
        
        // Add long press gesture recognizer with crash protection
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(SuggestionButton.buttonLongPressed(_:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.cancelsTouchesInView = true
        longPressGesture.delaysTouchesBegan = false
        addGestureRecognizer(longPressGesture)
        self.isExclusiveTouch = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Event handlers
    
    @objc func buttonPressed(_ button: SuggestionButton) {
        delegate?.handlePressForSuggestionButton(self)
    }
    
    @objc func buttonLongPressed(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        guard longPressGestureRecognizer.state == .began else { return }
        guard let delegate = delegate else { return }
        
        // Add crash protection
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            delegate.handleLongPressForSuggestionButton(self)
        }
    }
}
