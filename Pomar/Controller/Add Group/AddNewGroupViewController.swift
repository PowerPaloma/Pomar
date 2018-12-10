////
////  addNewGroupViewController.swift
////  Pomar
////
////  Created by Alan Victor Paulino de Oliveira on 28/11/18.
////  Copyright © 2018 Paloma Bispo. All rights reserved.
////
//
//import UIKit
//
//
//
//class AddNewGroupViewController: UIViewController {
//
//    @IBOutlet weak var backgroundCardView: UIView!
//    @IBOutlet weak var tableView: UITableView!
//
//
//
//    @IBAction func cancel(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func done(_ sender: Any) {
//        let visibleCells = tableView.visibleCells
//
//        let nameGroupCell = visibleCells[0] as! DescriptionTableViewCell
//        let nameGroup = nameGroupCell.descriptionTextField.text
////
//        let smallDescriptionCell = visibleCells[1] as! DescriptionTableViewCell
//        let smallDescription = smallDescriptionCell.descriptionTextField.text
////
//        let tagsCell = visibleCells[2] as! TagsTableViewCell
//        let tags = tagsCell.getTags()
//
////        let calendarCell = visibleCells[3] as! CalendarTableViewCell
//        let date = calendarCell.getDate()
//
//
//        let group = Group(name: nameGroup!, description: smallDescription!, tags: tags, schedule: [], date: date, isWeekly: false)
//
//        CKManager.shared.createGroup(group: group) { (record, error) in
//            if error == nil{
//                print("Criou o grupo com sucesso")
//                self.dismiss(animated: true, completion: nil)
//            }else{
//                print("Infelizmente não conseguiu criar o grupo, volta AQUI!")
//                self.dismiss(animated: true, completion: nil)
//            }
//
//
//        }
//
//    }
//
//    @IBOutlet weak var cancel: UIBarButtonItem!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        backgroundCardView.layer.cornerRadius = 8
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "descriptionCell")
//        tableView.register(UINib(nibName: "TagsTableViewCell", bundle: nil), forCellReuseIdentifier: "tagsCell")
//        tableView.register(UINib(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "calendarCell")
//
//
//        // Do any additional setup after loading the view.
//    }
//
////    func getDataFromXib<T>(indexPath: IndexPath) -> T{
////
////    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension AddNewGroupViewController: UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! DescriptionTableViewCell
//            cell.loadCell(typeCell: .name)
//
//            return cell
//        }else if indexPath.section == 1{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! DescriptionTableViewCell
//            cell.loadCell(typeCell: .smallDescription)
//            return cell
//        }else if indexPath.section == 2{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell", for: indexPath) as! TagsTableViewCell
//
//            cell.loadCell()
//
//            cell.tagsField.onDidChangeHeightTo = {_,_ in
//                self.tableView.beginUpdates()
//                self.tableView.endUpdates()
//            }
//            return cell
//        }else {
////            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as! CalendarTableViewCell
//
//            return cell
//        }
//
//
//    }
//
//
//
//}
