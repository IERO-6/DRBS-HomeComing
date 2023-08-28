import UIKit
import SnapKit
import Then

@available(iOS 16.0, *)
final class CalendarVC: UIViewController {
    //MARK: - Properties
    private lazy var calendarView = UICalendarView().then {
        $0.calendar = .current
        $0.locale = .current
        $0.fontDesign = .rounded
    }
    private var selectedDate: DateComponents?
    weak var calendarDelegate: CalendarDelegate?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingCalendar()
        settingModal()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(calendarView)
        calendarView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }
    
    private func settingCalendar() {
        self.calendarView.delegate = self
        let selectedDate = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectedDate
    }
    private func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
    
    private func settingModal() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = 25
        }
    }
    
    //MARK: - Actions
    
}

//MARK: - UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate

@available(iOS 16.0, *)
extension CalendarVC: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {

        if let date = dateComponents?.date {
            calendarDelegate?.dateSelected(date: date)
            self.dismiss(animated: true)
        }
    }
}
