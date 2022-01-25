//
//  ErrorView.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 24/01/2022.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func refresh()
}

class ErrorView: UIView {

    @IBOutlet private var view: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    weak var delegate: ErrorViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadNib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        viewSetup()
    }

    @discardableResult private func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)?.first as! UIView
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.frame = bounds
        addSubview(view)
        return view
    }
    
    private func viewSetup() {
        refreshButton.layer.cornerRadius = refreshButton.frame.height/2
        refreshButton.clipsToBounds = true
        isHidden = true
        transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
    }
    
    func showError(with message: String) {
        errorMessageLabel.text = message
        isHidden = false
        showView()
    }
    
    private func showView() {
        
        UIView.animate(withDuration: 0.7/2, delay: 0.3, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: .curveEaseInOut) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.7/3, delay: 0.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: .curveEaseInOut) {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { _ in
                UIView.animate(withDuration: 0.7/4, delay: 0.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }

    }
    
    func dismiss() {
        
        UIView.animate(withDuration: 0.7/2, delay: 0.2, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: .curveEaseInOut) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.7/3, delay: 0.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }, completion: nil)
        }

    }
    
    @IBAction func refresh(_ sender: UIButton) {
        delegate?.refresh()
    }
}
