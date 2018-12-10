//
//  AddGroupViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {

    @IBOutlet weak var containerSearch: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var suggestionsView: UIView!
    @IBOutlet weak var smallDescriptionTxtView: UITextView!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var hourView: UIView!
    @IBOutlet var hoursTxtF: [UITextField]!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var collectionMonths: UICollectionView!
    @IBOutlet weak var collectionDays: UICollectionView!
    @IBOutlet weak var dateAndTimeView: UIView!
    let minimumInteritemSpacing: CGFloat = 4
    let minimumLineSpacing:CGFloat = 4
    var hours = ["00:00", "00:00", "00:00", "00:00", "00:00"]
    var modelMonth: ModelMonths!
    var modelDay: ModelDays!
    var activeField: UITextField!
    var hoursPickerController = UIPickerView()
    var modelHoursPicker: HourPicker!
    let tagsFieldSearch = WSTagsField()
    let tagsFieldSuggestions = WSTagsField()
    var tagsCollectionViewDelegateAndDataSource = TagsCollectionViewDelegateAndDataSource()
    var accessoryToolbar: UIToolbar {
        get {
            let toolbarFrame = CGRect(x: 0, y: 0,
                                      width: view.frame.width, height: 44)
            let accessoryToolbar = UIToolbar(frame: toolbarFrame)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(onDoneButtonTapped(sender:)))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
            accessoryToolbar.items = [flexibleSpace, doneButton]
            accessoryToolbar.barTintColor = UIColor.white
            return accessoryToolbar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMonths.register(UINib(nibName: "MonthCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "month")
        collectionDays.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "day")
        
        self.modelDay = ModelDays(month: 2, collection: self.collectionDays)
        modelDay.selectedDaysProtocol = self
        collectionDays.delegate = self.modelDay
        collectionDays.dataSource = self.modelDay
        collectionDays.allowsMultipleSelection = true
        
        self.modelMonth = ModelMonths(collection: self.collectionMonths, modelDays: modelDay)
        collectionMonths.delegate = self.modelMonth
        collectionMonths.dataSource = self.modelMonth
        
        modelHoursPicker = HourPicker()
        hoursPickerController.delegate = modelHoursPicker
        hoursPickerController.dataSource = modelHoursPicker
        modelHoursPicker.textFieldDelegate = self
        
        setupTextFields()
        setupTags()
        setup()
        observeKeyboardNotifications()
    }
    
    private func setup(){
        self.scroll.clipsToBounds = true
        self.scroll.layer.cornerRadius = 12
        self.dateAndTimeView.clipsToBounds = true
        self.dateAndTimeView.layer.cornerRadius = 8
        self.dateAndTimeView.layer.borderWidth = 0.5
        self.dateAndTimeView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.collectionMonths.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.collectionMonths.layer.borderWidth = 0.5
        self.hourView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.hourView.layer.borderWidth = 0.5
        self.hourView.clipsToBounds = true
        self.hourView.layer.cornerRadius = 8
        self.smallDescriptionTxtView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.smallDescriptionTxtView.layer.borderWidth = 0.6
        self.smallDescriptionTxtView.layer.cornerRadius = 8
        self.smallDescriptionTxtView.clipsToBounds = true
        self.containerSearch.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.containerSearch.layer.borderWidth = 0.6
        self.containerSearch.clipsToBounds = true
        self.containerSearch.layer.cornerRadius = 8
        textFieldEvents()
        
//        card.layer.cornerRadius = 12.0
//        card.layer.borderWidth = 1.0
//        card.layer.borderColor = UIColor.clear.cgColor
//        card.layer.masksToBounds = true;
//        
//        card.layer.shadowColor = UIColor.lightGray.cgColor
//        card.layer.shadowOffset = CGSize(width:0,height: 2.0)
//        card.layer.shadowRadius = 5.0
//        card.layer.shadowOpacity = 0.7
//        card.layer.masksToBounds = false;
//        card.layer.shadowPath = UIBezierPath(roundedRect:card.bounds, cornerRadius:card.layer.cornerRadius).cgPath
    }
    
    private func setupTextFields(){
        for txtField in self.hoursTxtF {
            txtField.inputView  = hoursPickerController
            txtField.inputAccessoryView = accessoryToolbar
            txtField.delegate = self
        }
    }
    
    private func setupTags(){
        tagsFieldSearch.placeholder = "Search Tags"
        tagsFieldSearch.font =  UIFont.systemFont(ofSize: 14)
        tagsFieldSearch.cornerRadius = 12
        tagsFieldSearch.textColor = #colorLiteral(red: 0.6980392157, green: 0, blue: 0.02352941176, alpha: 1)
        tagsFieldSearch.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tagsFieldSearch.borderColor = #colorLiteral(red: 0.6980392157, green: 0, blue: 0.02352941176, alpha: 1)
        tagsFieldSearch.borderWidth = 0.5
        tagsFieldSearch.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchView.addSubview(tagsFieldSearch)
        tagsFieldSearch.contentInset = UIEdgeInsets(top: 8 , left: 8, bottom: 8, right: 8)
        tagsFieldSearch.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tagsFieldSearch.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionViewDelegateAndDataSource.delegate = self
        NSLayoutConstraint.activate([
            tagsFieldSearch.topAnchor.constraint(equalTo: searchView.topAnchor),
            tagsFieldSearch.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 0),
            tagsFieldSearch.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: 0),
            searchView.bottomAnchor.constraint(equalTo: tagsFieldSearch.bottomAnchor)
            ])
        suggestionsView.addSubview(tagsFieldSuggestions)
        tagsFieldSuggestions.placeholder = ""
        tagsFieldSuggestions.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        tagsFieldSuggestions.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tagsFieldSuggestions.font =  UIFont.systemFont(ofSize: 14)
        tagsFieldSuggestions.cornerRadius = 12
        tagsFieldSuggestions.textColor = #colorLiteral(red: 0.6980392157, green: 0, blue: 0.02352941176, alpha: 1)
        tagsFieldSuggestions.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tagsFieldSuggestions.borderColor = #colorLiteral(red: 0.6980392157, green: 0, blue: 0.02352941176, alpha: 1)
        tagsFieldSuggestions.borderWidth = 0.5
        tagsFieldSuggestions.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tagsFieldSuggestions.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagsFieldSuggestions.topAnchor.constraint(equalTo: suggestionsView.topAnchor),
            tagsFieldSuggestions.leadingAnchor.constraint(equalTo: suggestionsView.leadingAnchor, constant: 0),
            tagsFieldSuggestions.trailingAnchor.constraint(equalTo: suggestionsView.trailingAnchor, constant: 0),
            suggestionsView.bottomAnchor.constraint(equalTo: tagsFieldSuggestions.bottomAnchor)
            ])

    }
    
    
    fileprivate func observeKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: targetFrame.height + 16, right: 0.0)
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
        
        var aRect = self.view.frame
        aRect.size.height -= targetFrame.height
        if (activeField != nil && !aRect.contains(activeField.frame.origin)) {
            scroll.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    //Not testable
    
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = NSCoder.uiEdgeInsets(for: "")
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
    }
    
    func closePicker(){
        if hoursTxtF[0].isFirstResponder {
            hoursTxtF[0].resignFirstResponder()
        }else  if hoursTxtF[1].isFirstResponder {
            hoursTxtF[1].resignFirstResponder()
        }else  if hoursTxtF[2].isFirstResponder {
            hoursTxtF[2].resignFirstResponder()
        }else  if hoursTxtF[3].isFirstResponder {
            hoursTxtF[3].resignFirstResponder()
        }else  if hoursTxtF[4].isFirstResponder {
            hoursTxtF[4].resignFirstResponder()
        }
    }
    
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
        closePicker()
    }
    
}

extension AddGroupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension AddGroupViewController: SelectedDaysProtocol{
    
    func selected(days: [Bool]) {
        for (index, isSelected) in days.enumerated() {
            if isSelected {
                let txtField = hoursTxtF[index]
                txtField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                txtField.clipsToBounds = true
                txtField.layer.cornerRadius = 8
                txtField.backgroundColor = #colorLiteral(red: 0.2589761913, green: 0.8057302833, blue: 0.4474651814, alpha: 0.3603392551)
                txtField.isEnabled = true
            }else{
                let txtField = hoursTxtF[index]
                txtField.textColor = #colorLiteral(red: 0.8823529412, green: 0.8784313725, blue: 0.8862745098, alpha: 1)
                txtField.clipsToBounds = true
                txtField.layer.cornerRadius = 8
                txtField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                txtField.isEnabled = false
            }
        }
    }
    
    
}

extension AddGroupViewController: TextFieldProtocol {
    
    func send(text: String) {
        if hoursTxtF[0].isFirstResponder {
            hoursTxtF[0].text = text
        }else  if hoursTxtF[1].isFirstResponder {
            hoursTxtF[1].text = text
        }else  if hoursTxtF[2].isFirstResponder {
            hoursTxtF[2].text = text
        }else  if hoursTxtF[3].isFirstResponder {
            hoursTxtF[3].text = text
        }else  if hoursTxtF[4].isFirstResponder {
            hoursTxtF[4].text = text
        }
    }
    
}

extension AddGroupViewController:TagsSuggestionCollectionDelegate {
    
    fileprivate func textFieldEvents(){
        tagsFieldSearch.onDidAddTag = { _, _ in
            print("onDidAddTag")
        }
        
        tagsFieldSearch.onDidRemoveTag = { _, _ in
            print("onDidRemoveTag")
        }
        
        tagsFieldSearch.onDidChangeText = { _, text in
            let suggestionTags = subjects.filter {$0.localizedCaseInsensitiveContains(text ?? "")}
            self.tagsFieldSuggestions.removeTags()
            if suggestionTags.count < 3 {
                self.tagsFieldSuggestions.addTags(suggestionTags)
            }else{
                self.tagsFieldSuggestions.addTags(Array(suggestionTags[0...2]))
            }
            self.tagsFieldSuggestions.cornerRadius = 12
            self.tagsFieldSuggestions.textColor = #colorLiteral(red: 0.6980392157, green: 0, blue: 0.02352941176, alpha: 1)
            self.tagsFieldSuggestions.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.tagsFieldSuggestions.borderColor = #colorLiteral(red: 0.6980392157, green: 0, blue: 0.02352941176, alpha: 1)
            self.tagsFieldSuggestions.borderWidth = 0.5
            self.tagsFieldSuggestions.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            print(suggestionTags)
            print("onDidChangeText")
        }
        
        tagsFieldSearch.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }
        
        tagsFieldSuggestions.onDidSelectTagView = { tgField, tagView in
            self.tagsFieldSearch.addTag(tagView.displayText)
            subjects
        }
        
        tagsFieldSearch.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
    }
    
    func remove(subject: String){
        for sub in subjects{
            subjects
        }
        
    }
    
    func tapInTag(tagText: String) {
        tagsFieldSearch.addTag(tagText)
    }
    func getTags() -> [String] {
        let wsTags = tagsFieldSearch.tags
        let tags = wsTags.map { (tags) -> String in
            return tags.text
        }
        return tags
        
    }
}


