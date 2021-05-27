//
//  ErrorView.swift
//  NearBy
//
//  Created by Islam Elgaafary on 27/05/2021.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var errorIcon: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    enum ErrorViewTypes {
        case NoDataFound
        case SomeError
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubViews()
    }
    
    @discardableResult
    init(errorType:ErrorViewTypes, onView view:UIView) {
        super.init(frame: CGRect())
        initSubViews()
        
        self.center = CGPoint(x: (view.frame.size.width)  / 2,
                              y: (view.frame.size.height) / 2)
        
        switch errorType {
        case .NoDataFound:
            self.errorLabel.text = "No data Found !!"
            self.errorIcon.image = #imageLiteral(resourceName: "icons8-box_important")
        case .SomeError:
            self.errorLabel.text = "Something went wrong !!"
            self.errorIcon.image = #imageLiteral(resourceName: "icons8-delete_from_cloud")
        }
        
        view.addSubview(self)

    }
    
    
    func initSubViews() {
        let nib = UINib(nibName: "ErrorView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
