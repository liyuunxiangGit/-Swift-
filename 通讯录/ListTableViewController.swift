//
//  ListTableViewController.swift
//  通讯录
//
//  Created by liyunxiang on 2017/6/20.
//  Copyright © 2017年 liyunxiang. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    /// 联系人数组
    var personList = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        
        
        loadData { (list) in
            print(list)
            //拼接数组 闭包中定义好的
            self.personList += list
            
            //刷新表格
            self.tableView.reloadData()
        }
        
        }


    /// 模拟异步 利用闭包回调
    private func loadData(completion:@escaping (_ list:[Person])->()) -> () {
        DispatchQueue.global().async {
            print("正在努力加载中")
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM = [Person]()
            
            for i in 0..<20{
                let p = Person()
                p.name = "zhangsan - \(i)"
                p.phone = "1860"+String(format: "%06d", arc4random_uniform(1000000))
                p.title = "boss"
                
                arrayM.append(p)
            }
            //主线程回调
            DispatchQueue.main.async(execute: { 
                //回调执行闭包
                completion(arrayM)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
  
        return cell
    }
    @IBAction func newPerson(_ sender: Any) {
        //跳转控制器  执行segue 跳转界面
        //执行 segue
        performSegue(withIdentifier: "list2detail", sender: nil)
        
    }
    //MARK: -控制器跳转方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! DetailViewController
        //设置选中的person
        if let indexPath = sender as? IndexPath {
            //indexPath一定有值
            vc.person = personList[indexPath.row]
            
            //设置编辑完成的闭包
            vc.completionCallBack?()
        }else
        {
            //新建个人
            vc.completionCallBack = {
                //1.获取明细控制器的person
                guard let p = vc.person else {
                    return
                }
                //2.插入数组顶部
                self.personList.insert(p, at: 0)
                //3.刷新表格
                self.tableView.reloadData()
            }
            
        }
    }
    
    //MARK: -代理方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //执行 segue
        performSegue(withIdentifier: "list2detail", sender: indexPath)
    }

  
}
