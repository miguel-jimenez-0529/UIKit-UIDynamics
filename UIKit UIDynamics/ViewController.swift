//
//  ViewController.swift
//  UIKit UIDynamics
//
//  Created by Macbook Pro on 23/04/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var gravityView : UIView!
    @IBOutlet weak var collitionView : UIView!
    private var animator : UIDynamicAnimator!
    private var snapping : UISnapBehavior!
    private var gravity : UIGravityBehavior!
    private var collision  : UICollisionBehavior!
    private var field : UIFieldBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        snapping = UISnapBehavior(item: cardView, snapTo: view.center)
        gravity = UIGravityBehavior(items: [gravityView])
        collision = UICollisionBehavior(items: [gravityView,collitionView])
        let field = UIFieldBehavior.radialGravityField(position: view.center)
        let vortex = UIFieldBehavior.vortexField()
        vortex.addItem(gravityView)
        field.addItem(gravityView)
        animator.addBehavior(field)
        animator.addBehavior(snapping)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.pannedView(recognizer:)))
        cardView.addGestureRecognizer(panGesture)
        cardView.isUserInteractionEnabled = true
    }
    
    @objc func pannedView(recognizer : UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.removeBehavior(snapping)
        case .changed:
            let translation = recognizer.translation(in: view)
            cardView.center = CGPoint(x: cardView.center.x + translation.x, y: cardView.center.y + translation.y)
            recognizer.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            animator.addBehavior(snapping)
        case .possible:
            break
        }
    }
}

