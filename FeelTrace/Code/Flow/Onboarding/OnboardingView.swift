import UIKit
import SnapKit


final class OnboardingView: UIView {
    
    //MARK: - Elements
    
    private let categories = Category.categories
    
    private(set) lazy var customPageControl: CustomPageControlView = {
        let pageControl = CustomPageControlView(numberOfIndicators: 3, currentIndex: 0, progressColor: MyColors.tint.color)
        return pageControl
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 34)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Let’s create your profile!"
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .customSFFont(.regular, size: 15)
        label.textColor = MyColors.black.color
        label.textAlignment = .center
        label.text = "Add your name and your age"
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, textFieldStack, buttonStack, typeButtonStack])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) lazy var textFieldStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTF, ageTF])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        return stackView
    }()
    
    private(set) lazy var buttonStack: UIStackView = {
        let topStackView = UIStackView(arrangedSubviews: [profile1, profile2])
        topStackView.axis = .horizontal
        topStackView.spacing = 16
        let stackView = UIStackView(arrangedSubviews: [topStackView, profile3])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private(set) lazy var typeButtonStack: UIStackView = createButtonStack()
    
    private(set) lazy var nameTF: CustomTextFieldView = {
        let nameTF = CustomTextFieldView()
        nameTF.field.placeholder = "Name"
        return nameTF
    }()
    
    private(set) lazy var ageTF: CustomTextFieldView = {
        let ageTF = CustomTextFieldView()
        ageTF.field.placeholder = "Age"
        return ageTF
    }()
    
    private(set) lazy var profile1: ProfileButtonView = {
        let btn = ProfileButtonView()
        btn.button.setImage(.profile1, for: .normal)
        btn.button.tag = 0
        return btn
    }()
    
    private(set) lazy var profile2: ProfileButtonView = {
        let btn = ProfileButtonView()
        btn.button.setImage(.profile2, for: .normal)
        btn.button.tag = 1
        return btn
    }()
    
    private(set) lazy var profile3: ProfileButtonView = {
        let btn = ProfileButtonView()
        btn.button.setImage(.profile3, for: .normal)
        btn.button.tag = 2
        return btn
    }()
    
    private(set) lazy var nextButton: CustomButtonView = {
        let view = CustomButtonView()
        view.btnUpdate(item: ButtonDM(icon: "", title: "Next", textColor: .white, backColor: MyColors.secondary.color))
        view.actionButton.isEnabled = false
        return view
    }()
    
    lazy var profileButtons = [profile1, profile2, profile3]
    
    lazy var typeButtons: [UIButton] = createTypeButtons()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = UIColor.white
        addSubview(nextButton)
        addSubview(customPageControl)
        addSubview(mainStack)
    }
    
    private func createButtonStack() -> UIStackView {
        let buttons = typeButtons
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        let firstStackButtons = Array(buttons.prefix(3))
        let firstHorizontalStack = UIStackView(arrangedSubviews: firstStackButtons)
        firstHorizontalStack.axis = .horizontal
        firstHorizontalStack.spacing = 8
        firstHorizontalStack.alignment = .center
        stackView.addArrangedSubview(firstHorizontalStack)
        
        let middleStackButtons = Array(buttons[3..<5])
        let middleHorizontalStack = UIStackView(arrangedSubviews: middleStackButtons)
        middleHorizontalStack.axis = .horizontal
        middleHorizontalStack.spacing = 8
        middleHorizontalStack.alignment = .center
        stackView.addArrangedSubview(middleHorizontalStack)
        
        let lastStackButtons = Array(buttons.suffix(3))
        let lastHorizontalStack = UIStackView(arrangedSubviews: lastStackButtons)
        lastHorizontalStack.axis = .horizontal
        lastHorizontalStack.spacing = 8
        lastHorizontalStack.alignment = .center
        stackView.addArrangedSubview(lastHorizontalStack)
        
        return stackView
    }
    
    private func createTypeButtons() -> [UIButton] {
        var buttons = [UIButton]()
        for index in 0..<8 {
            let category = categories[index]
            let button = UIButton(type: .custom)
            button.isUserInteractionEnabled = true
            button.tag = index
            button.layer.cornerRadius = 19
            button.backgroundColor = MyColors.secondary.color
            button.snp.makeConstraints { make in
                make.height.equalTo(36)
                make.width.equalTo(category.width)
            }
            button.setTitle(category.type, for: .normal)
            buttons.append(button)
            
        }
        return buttons
    }
    
    
    
    
    func setUpConstraints() {
        customPageControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-46)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(63)
        }
    }
    
}
