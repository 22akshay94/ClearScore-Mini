//
//  DetailViewController.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 22/01/2022.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    @IBOutlet private weak var creditScoreLabel: UILabel!
    @IBOutlet private weak var maxScoreLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private var creditInfoViewModel: CreditReportInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func injectDependency(_ viewModel: CreditReportInfo)  {
        creditInfoViewModel = viewModel
    }
    
    private func setupView() {
        creditScoreLabel.text = "\(creditInfoViewModel!.score)"
        maxScoreLabel.text = "out of \(creditInfoViewModel!.maxScoreValue)"
        
        let descriptionStr = "Your current short term credit limit is £\(creditInfoViewModel!.currentShortTermCreditLimit) and the report is due for an update in \(creditInfoViewModel!.daysUntilNextReport) days"
        let descAttributedStr = NSMutableAttributedString(string: descriptionStr)
        
        descriptionStr.enumerateSubstrings(in: descriptionStr.startIndex..<descriptionStr.endIndex, options: .byWords) { [weak self] substring, substringRange, _, _ in
            guard let self = self else {return}
            let font = UIFont.systemFont(ofSize: 18, weight: .heavy)
            if substring == "\(self.creditInfoViewModel!.currentShortTermCreditLimit)" {
                descAttributedStr.addAttribute(.font, value: font, range: NSRange(substringRange, in: descriptionStr))
            }
            
            if substring == "\(self.creditInfoViewModel!.daysUntilNextReport)" {
                descAttributedStr.addAttribute(.font, value: font, range: NSRange(substringRange, in: descriptionStr))
            }
        }
        
        descriptionLabel.attributedText = descAttributedStr
    }
}
