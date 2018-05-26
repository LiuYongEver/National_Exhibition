import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import SwiftFCXRefresh


class CommunityTableViewController: UIViewController{
    
    public var dataBase:[String:[String]] = [
        "flag":[],
        "name":[],
        "nation_id":[],
        "capital":[],
        "establish_time":[],
        "content":[]
    ]
    
    var index : String?
    var getContinet = ""
    var footerRefreshView:FCXRefreshFooterView?
    fileprivate var tableview:UITableView?
    var page = 1
    
    
    
    
    init(index:String) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        request()
        setTV()
        addRefreshView()
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addRefreshView() {
        footerRefreshView =
            tableview?.addFCXRefreshFooter { [weak self] (refreshHeader) in
                self?.loadMoreAction()
        }
    }
    func loadMoreAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let weakSelf = self,
                let _ = self?.footerRefreshView else {
                    return
            }
            weakSelf.page+=1
            weakSelf.request()
            // weakSelf.rows += 20
            // self?.tableview.reloadData()
        }
        
    }
    
    
    // MARK: - Alarequest
    
    func request(){
       
        
        let url = rootUrl+"/findQuestionLimit"
        let parameter = ["page":"\(self.page)","type":"\(getIndex().IndexCode)"]
        Alamofire.request(url, method: .post,parameters:parameter).responseJSON(completionHandler: {
            response in
            if let al = response.response {
                 print(al)
            }else{
                SVProgressHUD.showError(withStatus: "网络连接失败")
                SVProgressHUD.dismiss(withDelay: 1)
            }
            
            if let js = response.result.value{
                let json = JSON(js)
                print(json)
                if  json["data"].count-1>0{
                    for i in 0...json["data"].count-1{
                        self.dataBase["name"]?.append(json["data"][i]["question_title"].string!)
                        if let flag = json["data"][i]["question_picture"].string{
                            self.dataBase["flag"]?.append(flag)
                        }else{
                            self.dataBase["flag"]?.append("");
                        }
                        if let flag = json["data"][i]["question_date_time"].string{
                            self.dataBase["establish_time"]?.append(flag)
                        }else{
                            self.dataBase["establish_time"]?.append("")
                            
                        }
                        if let flag = json["data"][i]["capital"].string{
                            self.dataBase["capital"]?.append(flag)
                            
                        }else{
                            self.dataBase["capital"]?.append("")
                        }
                        self.dataBase["nation_id"]?.append("\(json["data"][i]["id"].int!)")
                        
                        
                        // 2
                        
//                        if let flag = json["data"][i]["geography"].string{
//                            self.dataBase["content"]?.append(flag)
//                        }else{
//                            self.dataBase["content"]?.append("")
//                        }
//
//                        //3
//
//                        if let flag = json["data"][i]["geography"].string{
//                            self.dataBase["content"]?.append(flag)
//                        }else{
//                            self.dataBase["content"]?.append("")
//                        }

                    }
                    self.footerRefreshView?.endRefresh()
                    SVProgressHUD.dismiss()
                    self.tableview?.reloadData()
                }else{
                    self.footerRefreshView?.showNoMoreData()
                }
                
                
            }
            
        })
        
        SVProgressHUD.dismiss()
        
    }
    
    
    
    
    
    
    func setTV(){
        self.tableview = UITableView(frame:FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-99-54))
        tableview?.delegate = self
        tableview?.dataSource = self
        self.view.addSubview(tableview!)
        
        
    }
    
    

    
    func clearDatabase(){
        for i in dataBase.keys{
            dataBase[i]?.removeAll()
        }
        
    }
    
    func getIndex()->(Index:String,IndexCode:Int){
        let indexx = ["recommend","nationinfo","nature","politic","development","society","technology","relationship","overseas",""]
        let ttitle  =  ["推荐","基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情","国际数据"]
        for i in 0...ttitle.count-1{
            if ttitle[i] == index{
                return (indexx[i],i)
            }
            
        }
        return ("",0)
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension CommunityTableViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func getContinent(str: String) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataBase["name"]?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TabTableViewCell(style: .default ,reuseIdentifier:"cell")
        
        
        let fg = dataBase["flag"]?[indexPath.row]
        if  fg != "" {
            print(imageUrl+fg!)//国旗地址
            let fg2 = fg?.components(separatedBy: "webapps/")
            //print(fg2![1])
            //let ecc  = imageUrl+fg2![1]
            let eco = (imageUrl+fg!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL.init(string:eco!)
            print(url)
            
            cell.flagImage.sd_setImage(with: url, completed: nil)
        }else{
            cell.flagImage.image = #imageLiteral(resourceName: "baccc")
        }
        
        cell.nameTitle.text = (self.dataBase["name"]?[indexPath.row])! + "   \(self.index!)"
        cell.nameTitle.sizeToFit()
        //let content = self.dataBase[]
        if self.getIndex().Index == "nationinfo"{
            
            let n = Int(self.dataBase["establish_time"]![indexPath.row])
            let str = timeFormat(n ?? 0)

            cell.contentLabel.text = "问题描述："+self.dataBase["name"]![indexPath.row]+"提问时间：" + str
            //+"首都："+self.dataBase["capital"]![indexPath.row]
        }else{
            cell.contentLabel.text = self.dataBase["content"]![indexPath.row];
        }
        //cell.contentLabel.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(135)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        for i in (self.navigationController?.navigationBar.subviews)!{
            i.removeFromSuperview()
        }
        
        let vc = QuestionDetailViewController.init(id: self.dataBase["nation_id"]![indexPath.row])
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.hidesBottomBarWhenPushed = false
        
      
    }
    
    
    
}
