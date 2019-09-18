//
//  TabBarCustomViewController.swift
//  animation
//
//  Created by Oscar Daza on 9/17/19.
//  Copyright © 2019 Oscar Daza. All rights reserved.
//

import UIKit

class TabBarCustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewtab = loadViewFromNib()
        //viewtab.frame = self.view.bounds
        //self.view.addSubview(viewtab)
        
        var bottomConstraint = NSLayoutConstraint()
        viewtab.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewtab)
        viewtab.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewtab.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = viewtab.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        bottomConstraint.isActive = true
        viewtab.heightAnchor.constraint(equalToConstant: 95).isActive = true
        // Do any additional setup after loading the view.
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TabBarCustom", bundle: bundle)
        return (nib.instantiate(withOwner: self, options: nil).first as? UIView)!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
