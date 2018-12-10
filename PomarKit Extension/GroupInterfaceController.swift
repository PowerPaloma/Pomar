//
//  GroupInterfaceController.swift
//  PomarKit Extension
//
//  Created by Thalia Freitas on 05/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import WatchKit
import Foundation


class GroupInterfaceController: WKInterfaceController {
    @IBOutlet weak var tableView: WKInterfaceTable!
    
    var groups = [Group]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        CKManager.shared.fetchGroups { [weak self] (groups, error) in
            guard let groups = groups else {
                print(error!.localizedDescription)
                return
            }
            
//            groups.forEach{print($0.date, $0.schedule?.first?.day)}
//            self?.groups = self?.sortDays(groups: groups) ?? []
            
            self?.tableView.setNumberOfRows(groups.count, withRowType: "groups")
   
            for index in 0..<self!.tableView.numberOfRows {
                guard let controller = self?.tableView.rowController(at: index) as? RowCellController else { continue }
                controller.group = groups[index]
            }
        }
        
    }
    
    func sortDays(groups: [Group]) -> [Group] {
        
        return groups.sorted { (group1, group2) -> Bool in
            var day1 = Date()
            var day2 = Date()
            
            if group1.isWeekly{
                guard let weekday = Weekday(rawValue: (group1.schedule?.first?.day)!.lowercased()) else {return false}
                day1 = Date.today().next(weekday)

            }else{
                guard let day = group1.date else {return false}
                day1 = day
            }
            
            if group2.isWeekly{
                guard let weekday = Weekday(rawValue: (group2.schedule?.first?.day)!.lowercased()) else {return false}
                day2 = Date.today().next(weekday)

            }else{
                guard let day = group2.date else {return false}
                day2 = day
            }
            
            
            print("\(day1) --- \(day2) = \(day1 < day2)", separator: "\n", terminator: "\n")
            
            return day1 < day2
            
//            else if day1 == day2{
//                guard let scheduleList1 = group1.schedule, let scheduleList2 = group2.schedule else {return false}
//                 guard let schedule1 = scheduleList1.first, let schedule2 = scheduleList2.first else {return false}
//                let hour1 = schedule1.hour
//                let hour2 = schedule2.hour
//
//                if hour1 < hour2 {
//                    return true
//                }else {
//                    return false
//                }
//            }
            
        }
    }
    



}


