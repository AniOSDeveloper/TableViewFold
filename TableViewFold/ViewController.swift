//
//  ViewController.swift
//  TableViewFold
//
//  Created by 陈舒澳 on 16/5/19.
//  Copyright © 2016年 speeda. All rights reserved.
//

import UIKit

class groupModel: NSObject{
    
    var buttonKey :UnsafePointer<Void> = nil
    
    var isOpen: Bool?
    var groupName: String?
    var groupCount: Int?
    var groupArray: Array<String>?
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView :UITableView?
    var firstArray : Array<String>?
    var secondArray : Array<String>?
    var dataSource: Array<groupModel>?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initData()
        
//        initTableView()
        
    }
    func initData(){
        for i in 1...15{
            let str = String(format: "火影%02d", i)
            print(str)
            if i < 6{
                firstArray?.append(str)
                
                print(firstArray)
            }else{
                secondArray?.append(str)
            }
            print("\(i)---\(str)")
        }
        for _ in 1...2{
//            let model = groupModel()
//            model.isOpen = false
//            model.groupName = "小学同学"
//            model.groupArray = firstArray
//            model.groupCount = firstArray?.count
//            dataSource?.append(model)
//            print(dataSource!)
        }
        
    }
    func initTableView(){
        tableView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height), style: .Plain)
        tableView?.separatorInset = UIEdgeInsetsZero
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.registerNib(UINib(nibName: "PersonCustomCell", bundle: nil), forCellReuseIdentifier: "PersonCustomCell")
        self.view.addSubview(tableView!)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (dataSource?.count)!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = dataSource![section]
        if model.isOpen == true{
            return model.groupCount!
        }else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCustomCell", forIndexPath: indexPath) as! PersonCustomCell
        let model = dataSource![indexPath.section]
        let imageName = model.groupArray![indexPath.row]
        cell.iconImageView.image = UIImage(named: imageName)
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0,0,self.view.frame.size.width,44))
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        let model = dataSource![section]
        
        let sectionButton = UIButton(type: .Custom)
        sectionButton.frame = view.frame
        sectionButton.tag = section
        sectionButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        sectionButton.setTitle(model.groupName, forState: .Normal)
        sectionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 60)
        sectionButton.addTarget(self, action: "sectionButtonClicked:", forControlEvents: .TouchUpInside)
        view.addSubview(sectionButton)
        
        let line = UIImageView(frame: CGRectMake(0, sectionButton.frame.size.height - 1, sectionButton.frame.size.width, 1))
        line.image = UIImage(named: "line_real")
        view.addSubview(line)
        
        if model.isOpen == true{
            let smallImage = UIImageView(frame: CGRectMake(10, (44 - 16)/2, 14, 16))
            smallImage.image = UIImage(named: "ico_list")
            view.addSubview(smallImage)
            let currentTransform = smallImage.transform
            let newTransform = CGAffineTransformRotate(currentTransform, CGFloat(M_PI/2.0000001))
            smallImage.transform = newTransform
            
//            objc_setAssociatedObject(sectionButton,buttonKey, smallImage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }else{
            let smallImage = UIImageView(frame: CGRectMake(10, (44 - 16)/2, 14, 16))
            smallImage.image = UIImage(named: "ico_list")
            view.addSubview(smallImage)
//            objc_setAssociatedObject(sectionButton,buttonKey, smallImage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return view
    }
    func sectionButtonClicked(){
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
