//
//  RowCellController.swift
//  PomarKit Extension
//
//  Created by Thalia Freitas on 06/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import WatchKit

enum Weekday: String {
    case monday = "monday", tuesday = "tuesday", wednesday = "wednesday", thursday = "thursday", friday = "friday", saturday = "saturday", sunday = "sunday"
}

class RowCellController: NSObject {

    @IBOutlet weak var nameGroupLbl: WKInterfaceLabel!
    @IBOutlet weak var nameDate: WKInterfaceLabel!
    @IBOutlet weak var date: WKInterfaceLabel!
    @IBOutlet weak var nameTime: WKInterfaceLabel!
    @IBOutlet weak var time: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    
    var group: Group? {
        didSet {
            guard let group = group else {return}
            nameGroupLbl.setText(group.name)
            nameDate.setText("Date")
            nameTime.setText("On time")
//            let imageGroup = UIImage(named: "apple")
//            image.setImage(imageGroup)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let formatterHour = DateFormatter()
            formatterHour.dateFormat = "HH:mm:ss"
            
            if group.isWeekly {
                guard let weekday = Weekday(rawValue: (group.schedule?.first?.day)!.lowercased()) else {return}
                guard let hour = group.schedule?.first?.hour else {return}
                time.setText(hour)
                
//                guard let weekdayHour = Weekday(rawValue: (hour)) else {return}
                let day = Date.today().next(weekday)
                //let dayHour = Date.today().next(weekdayHour)
                date.setText(formatter.string(from: day))

            } else {
                let day = group.date
                let dayHour = group.date
                date.setText(formatter.string(from: day ?? Date()))
                time.setText(formatterHour.string(from: dayHour ?? Date()))
            }
            

            
            
            
        }
    }
}

extension Date {
    
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Previous,
                   weekday,
                   considerToday: considerToday)
    }
    func formatToString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex
        
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .Next:
                return .forward
            case .Previous:
                return .backward
            }
        }
    }
    
}

extension Date{
    private static func componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
    
    private static func components(_ fromDate: Date) -> DateComponents! {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
    
    private func components() -> DateComponents  {
        return Date.components(self)!
    }
    
    func setTimeOfDate(_ hour: Int, minute: Int, second: Int) -> Date {
        var components = self.components()
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components)!
    }
}

//extension Date{
//    static func toInt() -> Date{
//        return Date()
//    }
//    
////    func formatToDate(_ group: Group, considerToday: Bool = false) -> Date {
////        let time = group.schedule?.first?.hour
////        var dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "HH:mm"
////        let date = dateFormatter.date(from: time ?? Date())
////        return Date()
////
////        }
//}
