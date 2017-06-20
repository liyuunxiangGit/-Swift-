//
//  DetailViewController.swift
//  通讯录
//
//  Created by liyunxiang on 2017/6/20.
//  Copyright © 2017年 liyunxiang. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    
    var person:Person?
    //完成回调属性
    //闭包的返回值是可选的
//    var completionCallBack:()->()?
    //闭包是可选的
    var completionCallBack:(()->())?
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //判断person是否有值
        if person != nil {
            nameText.text = person?.name
            phoneText.text = person?.phone
            titleText.text = person?.title
        }
        
    }


    @IBAction func savePerson(_ sender: Any) {
        //1.判断person是否为nil，如果是那么就新建
        if person == nil{
            person = Person()
        }
        
        
        //2.用UI更新界面
        person?.name = nameText.text
        person?.phone = phoneText.text
        person?.title = titleText.text
        
        //3.执行闭包回调
        //OC中执行block之前都必须判断是否有值，否则容易崩溃
        //!强行解包
        //?可选解包 如果闭包为nil 就什么也不做
        completionCallBack?()
        
        //4.返回上一级界面
        self.navigationController?.popViewController(animated: true)
    }

}
