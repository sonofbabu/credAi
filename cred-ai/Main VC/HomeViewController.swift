//
//  HomeViewController.swift
//  cred-ai
//
//  Created by leyo babu on 23/01/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeScrollView = UIScrollView()
    var mainView = UIView()
    var homeTableView = UITableView()
    var tableViewContainer = UIView()
    var depositView = UIView()
    var depositLabel = UILabel()
    var depositShowView = UIView()
    var depositShowLabel = UILabel()
    var currentAmount = 0
    
    var deviceHeight = UIScreen.main.bounds.size.height
    
    struct Cells {
           static let homeCell = "depositCell"
       }
    
    var sectionArray = [[String]]()
    var sectionHeader = ["deposit speed","deposit from","deposit to"]
    let item1Array = ["Standard (1-3 days) max $ 2000","Convenience (instant) max $ 250"]
    let item2Array = ["Click to enable standard deposit","deposit for customer"]
    let item3Array = ["initial payments"]
    
    var safeAreaheight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMethods()
    }
    

// MARK:- INIT METHOD
    func initMethods(){
        self.view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            let topPadding = window?.safeAreaInsets.top ?? 0.0
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
            self.safeAreaheight = (topPadding + bottomPadding)
        }
        self.createDepositAmountView()
        self.homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: Cells.homeCell)
        self.homeTableView.isScrollEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
     
    func createDepositAmountView(){
        // Create Scroll view
        homeScrollView.contentInsetAdjustmentBehavior = .never
        homeScrollView.frame = view.frame
        view.addSubview(homeScrollView)
        // Create Mian view
        mainView.frame = homeScrollView.frame
        self.homeScrollView.addSubview(self.mainView)
        // Create Top View
        depositView.backgroundColor = UIColor(hexFromString: "#196CB4")
        self.mainView.addSubview(depositView)
        depositView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: deviceHeight/2.5)
        self.createDepositSubviewFrames()
        self.createDepositShowView()
        self.createPanGestureDAV()
        self.preaparingDataFromArray()
        self.configureTableView()
    }
    
    func createDepositShowView(){
        self.mainView.addSubview(depositShowView)
        depositShowView.frame = CGRect(x: 20, y: self.depositView.frame.size.height+40, width: self.view.frame.size.width-40, height: 60)
        depositShowView.backgroundColor = .clear
        depositShowView.layer.borderWidth = 1
        depositShowView.layer.borderColor = UIColor.lightGray.cgColor
        depositShowView.layer.cornerRadius = 15
        
        depositShowLabel.frame = CGRect(x: 0, y: 0, width: depositShowView.frame.size.width, height: depositShowView.frame.size.height)
        depositShowView.addSubview(depositShowLabel)
        depositShowLabel.text = "deposit amount shown"
        depositShowLabel.font = UIFont.boldSystemFont(ofSize: 18)
        depositShowLabel.textColor = UIColor.lightGray
        depositShowLabel.textAlignment = .center
    }
    
    func createDepositSubviewFrames(){
        depositLabel.textColor = .white
        depositLabel.font = UIFont.boldSystemFont(ofSize: 60)
        depositLabel.text = "$0"
        depositLabel.textAlignment = .center
        self.depositView.addSubview(depositLabel)
        depositLabel.frame = CGRect(x: 0, y: depositView.frame.size.height/2, width: self.view.frame.size.width, height: depositView.frame.size.height/4)
        
        
        let fundingLink = UILabel()
        fundingLink.frame = CGRect(x: 20, y: 0, width: self.view.frame.size.width-40, height: self.view.frame.size.height/6)
        self.depositView.addSubview(fundingLink)
        fundingLink.font = UIFont.systemFont(ofSize: 20)
        let myString = NSMutableAttributedString(string: "fundinglink", attributes: nil)
        let myRange = NSRange(location: 0, length: 7)
        myString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 28), range: myRange)
        fundingLink.attributedText = myString
        fundingLink.textColor = UIColor.white
       
        let menuButton = UIImageView()
        menuButton.frame = CGRect(x: self.view.frame.size.width-40, y: 40, width: 30, height: 30)
        self.depositView.addSubview(menuButton)
        menuButton.image = #imageLiteral(resourceName: "D_Order_Gray")
        menuButton.center.y = fundingLink.frame.midY
    }
    
    func createPanGestureDAV(){ // DAV - Deposit Amount View
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureActionsDAV))
        self.depositView.addGestureRecognizer(pangesture)
    }
    
    
    @objc func panGestureActionsDAV(sender: UIPanGestureRecognizer ){ // DAV - Deposit Amount View
        if sender.state == .began {
            
        }else if sender.state == .changed {
            let coordinateDirection = sender.velocity(in: self.depositView)
            if coordinateDirection.x > 0 {
                currentAmount += 5
            }else{
                currentAmount -= 5
            }
            if self.currentAmount >= 0 {
                self.depositLabel.text = "$\(currentAmount)"
                depositShowView.layer.borderColor = UIColor.black.cgColor
                depositShowLabel.textColor = UIColor.black
            }
        }else if sender.state == .ended {
            if currentAmount <= 0 {
                self.currentAmount = 0
                self.depositLabel.text = "$0"
                depositShowView.layer.borderColor = UIColor.lightGray.cgColor
                depositShowLabel.textColor = UIColor.lightGray
            }
        }
        
        
    }

// MARK:- PREPARE DATA FROM ARRAY
    func preaparingDataFromArray(){ // STATIC DATA IS CREATED AS NO FREE API WAS AVAILABLE
        sectionArray.append(item1Array)
        sectionArray.append(item2Array)
        sectionArray.append(item3Array)
    }
    
    
    func configureTableView(){
        // Create tableview container
        tableViewContainer = UIView(frame: CGRect(x: 0, y: (depositShowView.frame.origin.y + depositShowView.frame.size.height), width: view.frame.size.width, height: deviceHeight))
        tableViewContainer.backgroundColor = .clear
        self.mainView.addSubview(tableViewContainer)
        tableViewContainer.addSubview(homeTableView)
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.rowHeight = 110
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.topAnchor.constraint(equalTo: tableViewContainer.topAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor).isActive = true
        homeTableView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor, constant: 0).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor, constant: 0).isActive = true
        
    }
    


}

// MARK:- Extension Of VC for table view delegate and datasource
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       self.sectionArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.homeTableView.dequeueReusableCell(withIdentifier: Cells.homeCell, for: indexPath) as? HomeTableViewCell ?? HomeTableViewCell()
        
        if sectionArray.count > 0 {
            let menuItemName:String = self.sectionArray[indexPath.section][indexPath.row]
            if menuItemName != "" {
                cell.depositDetails.text = menuItemName
            }
        }
        // determine height and change it
        UIView.animate(withDuration: 0, animations: {
            self.homeTableView.layoutIfNeeded()
          }) { complete in
            self.tableViewContainer.frame.size.height = self.homeTableView.contentSize.height
            self.homeScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: (self.homeTableView.contentSize.height + self.depositShowView.frame.size.height + self.depositView.frame.size.height + 40 + self.safeAreaheight))
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 20, y: 7, width: returnedView.frame.size.width-40, height: 25))
        label.text = self.sectionHeader[section]
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        returnedView.addSubview(label)
        return returnedView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK:- UICOLOR EXTENSION
extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
