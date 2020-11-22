// 개요
// TableViewController는 메인 화면을 컨트롤하는 함수이다.
// 거의 대부분 TableView 관련 기본적인 셋팅만 되어있는 수준으로, AddViewController보다는 간단하게 코딩되어 있다.
// 웬만한 함수는 건드리지 않으며, Swift 책을 참고하여 제작하였다.


import UIKit

// 1) 전역함수 - 배열
// 이 프로그램의 중심인 배열로, AddViewController에서도 편하게 사용할 수 있도록 전역 Type으로 선언하였다.

var items = [String]()          // 할 일의 제목을 저장하는 변수
var itemsImageFile = [String]() // 할 일의 아이콘, 즉 시계, 카트, 연필 등을 설정한 값에 맞게 저장된 함수.
var Time = [String]()           // 할 일의 시간을 저장한 변수. 설정한 값에 맞게 저장됨.


class TableViewController: UITableViewController {
    
// 2) UITableView 함수와 기본적인 설정들
// 거의 건들 것이 없는 존재로, UITableView를 설정하기 위한 함수이다.
    @IBOutlet var tvListView: UITableView! //UITableView 함수
    
    override func viewWillAppear(_ animated: Bool) {
        
        tvListView.reloadData()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = UIImage(named : itemsImageFile[(indexPath as NSIndexPath).row])

        return cell
    }

    
//  4) 삭제 관련 함수들 - 밀어서 삭제, 혹은 왼쪽 수정 버튼을 눌러 삭제.
//  삭제와 관련된 기능을 처리하는 함수이다. 삭제를 하는 방법은 밀어서 삭제하거나, 왼쪽 수정 버튼을 눌러 삭제를 진행할 수 있다. 혹은 위치를 변경할 수 있다.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            
            items.remove(at: (indexPath as NSIndexPath).row)
            
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    override func tableView(_ tableView : UITableView, titleForDeleteConfirmationButtonForRowAt indexPath : IndexPath) -> String?
    {
        return "삭제"
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        
        items.remove(at : (fromIndexPath as NSIndexPath).row)
        
        itemsImageFile.remove(at : (fromIndexPath as NSIndexPath).row)
        
        items.insert(itemToMove, at : (to as NSIndexPath).row)
        
        itemsImageFile.insert(itemImageToMove, at : (to as NSIndexPath).row)
    }
    
//  5) AddViewController 연결 함수
//  여기에서는 AddViewController로 넘어가는 작업, 즉 추가하기 버튼을 누르거나 아이템을 클릭하였을때 연결되는 함수이다.
//  여기에는 아이템을 추가하거나, 다른 작업들을 하기 위한 여러가지 값들을 넘겨주는 역할을 하고 있다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgDetail"
        {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! AddViewController
            
            detailView.receiveItem(items[((indexPath as NSIndexPath?)?.row)!])
            detailView.receiveTime(Time[((indexPath as NSIndexPath?)?.row)!])
            detailView.indexPath = ((indexPath as NSIndexPath?)?.row)!
            detailView.segueNumber = 1
        }
    }
}
