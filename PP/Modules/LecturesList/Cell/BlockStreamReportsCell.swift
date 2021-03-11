import UIKit

class ButtonCell: UICollectionViewCell {
        
    let unbanButton: UIButton = {
        let button = UIButton()
        button.setTitle("👌 Разблокировать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return button
    }()
    
    let buttonGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.locations = [0.0, 1.0]
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.colors = [UIColor(hex6: 0x00E10B).cgColor, UIColor(hex6: 0x00774B).cgColor]
        layer.cornerRadius = 10
        
        return layer
    }()
    
    private let reasons = [
        10: "👀 Чужие видео",
        20: "👿 Оскорбления",
        21: "🤬 Матерные слова",
        25: "🔪 Угрозы или насилие",
        30: "🤖 Рассылка спама",
        40: "👙 Непристойный контент",
        50: "🤥 Реклама и обман",
        60: "👶 Младше 18!",
        70: "🚬 Курение или алкоголь",
        0: "🌀 Другое"
    ]
    
    var previews: [BlockStreamUserPreview]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        unbanButton.layer.insertSublayer(buttonGradientLayer, at: 0)
        
        setupCollectionView()
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.disableAnimations {
            buttonGradientLayer.frame = unbanButton.bounds
        }
    }
    
    func setupReports(reports: [Int: Int]?) {
        guard let reports = reports, reportStack.arrangedSubviews.isEmpty else { return }
        
        for report in reports {
            let label = UILabel()
            let atrString = NSMutableAttributedString()
            let countStr: String
            let middleStr: String
            
            countStr = "\(report.value) "
            middleStr = "жалоб на "
            let reason = reasons[report.key] ?? "🌀 Другое"
            
            let countAtr = NSAttributedString(string: countStr, attributes: [
                .font: UIFont.systemFont(ofSize: 13, weight: .bold),
                .foregroundColor: UIColor.white
            ])
            let middleAtr = NSAttributedString(string: middleStr, attributes: [
                .font: UIFont.systemFont(ofSize: 13, weight: .regular),
                .foregroundColor: UIColor.white.withAlphaComponent(0.6)
            ])
            let reportNameAtr = NSAttributedString(string: "\(reason)", attributes: [
                .font: UIFont.systemFont(ofSize: 13, weight: .bold),
                .foregroundColor: UIColor.white
            ])
            
            atrString.append(countAtr)
            atrString.append(middleAtr)
            atrString.append(reportNameAtr)
            
            label.attributedText = atrString
            reportStack.insertArrangedSubview(label, at: reportStack.arrangedSubviews.count)
        }
    }
    
    func setupStreamName(name: String?, startStream: String, endStream: String?) {
        guard streamNameStack.arrangedSubviews.isEmpty else { return }
        
        let barView = LiveListThreeBarView()
        
        let titleContainer = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = name ?? "Без названия"
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        
        let streamTimeLabel = UILabel()
        streamTimeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        streamTimeLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        streamTimeLabel.textAlignment = .left
        
        let endDescrLabel = UILabel()
        endDescrLabel.font = .systemFont(ofSize: 13, weight: .regular)
        endDescrLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        endDescrLabel.textAlignment = .left
        
        let startDate = startStream.iso8601 ?? Date()
         
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.calendar?.locale = Locale(identifier: "ru_RU")
        dateComponentsFormatter.allowedUnits = [.second, .minute, .hour, .day]
        dateComponentsFormatter.unitsStyle = .positional
        
        if let endDateString = endStream {
            let endDate = endDateString.iso8601 ?? Date()
            let streamTime = dateComponentsFormatter.string(from: startDate, to: endDate)
            
            streamTimeLabel.text = "\(streamTime ?? "")                     "
            endDescrLabel.text = findEndDescription(from: endDate)
        } else {
            let streamTime = dateComponentsFormatter.string(from: startDate, to: Date())
            streamTimeLabel.text = streamTime
            
            barView.startAnimating()
        }
        
        titleContainer.addSubview(barView)
        titleContainer.addSubview(titleLabel)
        titleContainer.addSubview(streamTimeLabel)
        
        barView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview().offset(-0.5)
            make.width.equalTo(endStream  == nil ? 13 : 0)
            make.right.equalTo(titleLabel.snp.left).offset(endStream  == nil ? -8 : 0)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        streamTimeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(8)
            make.right.equalToSuperview()
        }
        
        streamNameStack.insertArrangedSubview(titleContainer, at: 0)
        streamNameStack.insertArrangedSubview(endDescrLabel, at: 1)
    }
    
    private func findEndDescription(from endDate: Date) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.calendar = calendar
        dateComponentsFormatter.unitsStyle = .positional
        dateComponentsFormatter.allowedUnits = [.minute]

        let minString = dateComponentsFormatter.string(from: endDate, to: Date())!.replacingOccurrences(of: " ", with: "")
        let minSinceEnd = Int(minString) ?? 0
        
        if minSinceEnd < 60 {
            return "завершён \(minSinceEnd) мин назад"
        }
        
        dateComponentsFormatter.allowedUnits = [.hour]
        let hoursString = dateComponentsFormatter.string(from: endDate, to: Date())!.replacingOccurrences(of: " ", with: "")
        let hoursSinceEnd = Int(hoursString) ?? 0
        
        if hoursSinceEnd < 12 {
            return "завершен \(hoursSinceEnd)ч назад"
        }
        
        dateComponentsFormatter.allowedUnits = [.hour]
        let midnightDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        let daybefore = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let yesterdayMidnightDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: daybefore)!
        let hoursSinceMidnight = Int(dateComponentsFormatter.string(from: midnightDate, to: Date())?.replacingOccurrences(of: " ", with: "") ?? "0") ?? 0
        let hoursSinceYesterdayMidnight = Int(dateComponentsFormatter.string(from: yesterdayMidnightDate, to: Date())?.replacingOccurrences(of: " ", with: "") ?? "0") ?? 0
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: endDate)
        
        if hoursSinceEnd < hoursSinceMidnight {
            return "завершен сегодня в \(time)"
        } else if hoursSinceEnd < hoursSinceYesterdayMidnight {
            return "завершен вчера в \(time)"
        } else {
            dateFormatter.dateFormat = "dd MMMM"
            let day = dateFormatter.string(from: endDate)
            return "завершен \(day) в \(time)"
        }
    }

    private func addSubviews() {
        contentView.addSubview(collectionView)
        contentView.addSubview(reportStack)
        contentView.addSubview(streamNameStack)
        contentView.addSubview(widthView)
        contentView.addSubview(unbanButton)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(StreamPreviewCell.self, forCellWithReuseIdentifier: StreamPreviewCell.description())
    }
    
    private func setupConstraints() {
        widthView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        streamNameStack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.bottom.equalTo(reportStack.snp.top).offset(-15)
        }
        reportStack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(reportStack.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(unbanButton.snp.top)
        }
        unbanButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension BlockStreamReportsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previews?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StreamPreviewCell.description(), for: indexPath) as! StreamPreviewCell
        
        cell.imageView.image = nil
        cell.imageView.kf.setImage(with: previews?[indexPath.row].previewVideo, options: [.transition(.fade(0.25))])
        
        return cell
    }
}
