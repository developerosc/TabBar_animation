//
//  ViewController.swift
//  animation
//
//  Created by Oscar Daza on 9/16/19.
//  Copyright © 2019 Oscar Daza. All rights reserved.
//

import UIKit


private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

class ViewController:TabBarCustomViewController {

    private lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layout()
        popupView.addGestureRecognizer(tapRecognizer)
       // tapRecognizer.state = UIGestureRecognizer.State.began
    }
    private var bottomConstraint = NSLayoutConstraint()
    private func layout() {
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 490)
        bottomConstraint.isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 500).isActive = true

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (tapRecognizer.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event!)
        tapRecognizer.state = UIGestureRecognizer.State.began
    }
    private var currentState: State = .closed
    private lazy var tapRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        // ensure that the animators array is empty (which implies new animations need to be created)
        // an animator for the transition
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.popupView.layer.cornerRadius = 20
            case .closed:
                self.bottomConstraint.constant = 490
                self.popupView.layer.cornerRadius = 0
            }
            self.view.layoutIfNeeded()
        })
        // the transition completion block
        transitionAnimator.addCompletion { position in
            // update the state
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            // manually reset the constraint positions
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = 490
            }
        }
        // start all animators
        transitionAnimator.startAnimation()
    }
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // start the animations
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
        case .changed:
            // variable setup
            let translation = recognizer.translation(in: popupView)
            var fraction = -translation.y / 490
            // adjust the fraction for the current state and reversed state
            if currentState == .open { fraction *= -1 }
        case .ended:
            // variable setup
            let yVelocity = recognizer.velocity(in: popupView).y
            let shouldClose = yVelocity > 0
            // if there is no motion, continue all animations and exit early
            if yVelocity == 0 {
                break
            }
        default:
            ()
        }
    }
    
}

