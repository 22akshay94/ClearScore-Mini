//
//  DonutView.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 22/01/2022.
//

import UIKit

class DonutView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var backgroundView: UIView!
    private var shapeLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureDonut()
    }
    
    
    @discardableResult func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed("DonutView", owner: self, options: nil)?.first as! UIView
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.frame = bounds
        addSubview(view)
        return view
    }

    func configureDonut() {
        
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.5
        backgroundView.layer.cornerRadius = backgroundView.frame.height/2
        backgroundView.clipsToBounds = true
        
        
        let centre = CGPoint(x: bounds.midY, y: bounds.midY)
        
        shapeLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: centre, radius: (self.bounds.width - 62)/2, startAngle: -CGFloat.pi/2, endAngle: 1.5*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        
        self.layer.addSublayer(shapeLayer)
        loadScore(score: 514, maxScore: 700)
    }
    
    func loadScore(score: Float, maxScore: Float) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let value: Float = score/maxScore
        basicAnimation.toValue = value
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "donutLoader")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
