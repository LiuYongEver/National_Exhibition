//
//  SelectContinentTableViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/5.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class SelectContinentTableViewController: UITableViewController{

    
    
    
    var delegate:selectContinetDelegate?
    
    var selected:String?
    var titles = ["亚洲 (Asia)","欧洲 (Europe)","北美洲 (North America)","南美洲 (South America)","非洲 (Africa)","大洋洲 (Oceania)","南极洲 (Antarctica)" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择大洲"
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backbutton = UIButton(type: .custom)
        backbutton.frame = CGRect(x: 0, y: 0, width:68, height: 60)
        //backbutton.setImage(UIImage(named: "back@1x"), for: .normal)
        let bti = UIImageView.init(frame:( CGRect(x:0, y: 13, width: 22, height: 22)))
        bti.image = #imageLiteral(resourceName: "back@1x")
        backbutton.addSubview(bti)
        
        
        backbutton.addTarget(self, action: #selector(touchReturn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backbutton)
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -5
        //item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItems = [barButtonItem,item]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func getContinent(str:String){
        delegate?.getContinent(str:str)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func touchReturn(){
        self.dismiss(animated: false, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.textColor = title1Color
        cell.textLabel?.text = titles[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected = titles[indexPath.row]
        self.getContinent(str: selected!)

        
        self.dismiss(animated: false, completion: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
