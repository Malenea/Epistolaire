import Foundation

public extension Date {

    var toFormattedString: String {
        let calendar = Calendar.current
        guard !calendar.isDateInYesterday(self) else { return "Yesterday" }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = calendar.isDateInToday(self) ? "HH:mm"  : "dd/MM/YYYY"
        return dateFormatter.string(from: self)
    }

}
