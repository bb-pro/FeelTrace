import UIKit
import SnapKit

final class OnboardingView: UIView {
    
    //MARK: - Elements
    
    private(set) lazy var onboardingControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = MyColors.tint.color
        pageControl.pageIndicatorTintColor = MyColors.secondaryText.color
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = CommonsFontType.regular.font(size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Let’s create your profile!"
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = CommonsFontType.regular.font(size: 15)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Add your name and your age"
        return label
    }()
    
    private lazy var centerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = UIColor.white
        addSubview(onboardingControl)
        addSubview(centerStack)
    }
    
    func setUpConstraints() {
        onboardingControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
        }
        
        centerStack.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
    }
    
    func setupPageControl() {
        onboardingControl.setIndicatorImage(UIImage(named: "progress"), forPage: 0)
        onboardingControl.setIndicatorImage(UIImage(named: "progress"), forPage: 1)
        onboardingControl.setIndicatorImage(UIImage(named: "progress"), forPage: 2)
    }
}
