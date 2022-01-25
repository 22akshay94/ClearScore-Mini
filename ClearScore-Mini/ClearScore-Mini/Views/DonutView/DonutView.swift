//
//  DonutView.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 22/01/2022.
//

import UIKit

protocol DonutDelegate: AnyObject {
    func donutTapped()
}

class DonutView: UIView {
    
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private  weak var loaderLabel: UILabel!
    private var shapeLayer: CAShapeLayer!
    
    private var startValue: Double!
    private var endValue: Double!
    private var animationDuration: CFTimeInterval!
    private var animationStartDate: Date!
    
    var customTopLine: String = ""
    var customBottomLine: String = ""
    
    weak var delegate: DonutDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .black.withAlphaComponent(0.5)
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configureDonut()
    }
    
    
    @discardableResult private func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed("DonutView", owner: self, options: nil)?.first as! UIView
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.frame = bounds
        addSubview(view)
        return view
    }

    private func configureDonut() {
        
        let centre = CGPoint(x: bounds.midX, y: bounds.midY)
        
        shapeLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: centre, radius: self.bounds.width*0.48, startAngle: -CGFloat.pi/2, endAngle: 1.5*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        self.layer.addSublayer(shapeLayer)
        
        stackView.isHidden = true
        loaderLabel.isHidden = false
        
        self.isUserInteractionEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(donutTapped(_:)))
        addGestureRecognizer(tap)
        
    }
    
    @objc func donutTapped(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.donutTapped()
    }
    
    func loader(show: Bool = true) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = view.frame
        
        let angle = -45*(CGFloat.pi/180)
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        loaderLabel.layer.mask = gradientLayer
        
        let shimmerAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        shimmerAnimation.fromValue = -view.frame.width
        shimmerAnimation.toValue = view.frame.width
        shimmerAnimation.repeatCount = Float.infinity
        shimmerAnimation.duration = 2
        
        
        if show {
            gradientLayer.add(shimmerAnimation, forKey: "shimmerAnimation")
        } else {
            loaderLabel.layer.mask?.removeAllAnimations()
        }
    }
    
    func loadScore(creditInfo: CreditReportInfo, duration: CFTimeInterval) {
        
        stackView.isHidden = false
        loaderLabel.isHidden = true
        self.isUserInteractionEnabled = true
        
        let scoreAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let value: Float = Float(creditInfo.score)/Float(creditInfo.maxScoreValue)
        scoreAnimation.toValue = value
        scoreAnimation.duration = duration
        scoreAnimation.fillMode = .forwards
        scoreAnimation.isRemovedOnCompletion = false
        shapeLayer.add(scoreAnimation, forKey: "scoreAnimation")
        
        showScore(creditInfo: creditInfo, duration: duration)
    }
    
    private func showScore(creditInfo: CreditReportInfo, duration: CFTimeInterval) {
        
        topLabel.text = customTopLine == "" ? "Your credit score is":customTopLine
        
        startValue = Double(creditInfo.minScoreValue)
        endValue = Double(creditInfo.score)
        animationDuration = duration
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateScore))
        displayLink.add(to: .main, forMode: .default)
        
        bottomLabel.text = customBottomLine == "" ? "out of \(creditInfo.maxScoreValue)":customBottomLine
        animationStartDate = Date()
        
    }
    
    @objc private func updateScore() {
        let now = Date()
        let timeElapsed = now.timeIntervalSince(animationStartDate)
        
        if timeElapsed > animationDuration {
            scoreLabel.text = "\(Int(endValue))"
        } else {
            let percentage = timeElapsed/animationDuration
            let score = startValue + percentage * (endValue - startValue)
            scoreLabel.text = "\(Int(score))"
        }
    }
}
