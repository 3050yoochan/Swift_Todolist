// "개요"
//  AddViewController는 "추가 화면"과 "수정 화면"을 동시에 컨트롤한다.
//  Segue에 들어오는 값을 다르게 하여 각각 상황마다 다르게 기능을 수행할 수 있도록 코딩하였다.
//  아이템과 이미지들은 모두 배열로 구성하였다. 그러한 나머지, 배열의 특성인 remove 등을 사용하여 제작하였다.


import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
//  1) 변수들
    var receiveItem = "" // TableViewController에서 받아들여온 아이템들. 여기에는 아이템의 이름을 받을 수 있도록 설정하였다.
    var receiveTime = "" // TableViewController에서 받아들여온 아이템들. 여기에는 아이템의 시간을 받을 수 있도록 설정하였다.
    var iconNumber = 0   // 아이콘의 번호를 저장하여 등록하는 변수.
    var indexPath = 0    // 표의 위치값
    var segueNumber = 0  // 어떤 방식으로 Segue에 들어왔는지를 확인하는 변수. 만약 값이 0이면 Item추가, 1이면 Item 수정으로 결정
    var imageArray = [UIImage?]() //아이콘의 값을 추가하는 UIImage 형태의 함수.
    var imageFileName = ["cart.png", "clock.png", "pencil.png"] //아이콘을 저장하는 함수.
    var time = ""        // 선택한 시간을 저장하는 함수.
    
    
//  2) 스토리보드 관련 변수들 (버튼, 라벨 등)
    @IBOutlet weak var AdjustBtn: UIButton! // "수정 화면"에서 '수정하기'의 기능을 가진 버튼.
    @IBOutlet weak var AddBtn: UIButton!    // "추가 화면"에서 '추가하기'의 기능을 가진 버튼.
    @IBOutlet weak var DeleteBtn: UIButton! // "수정 화면"에서 '삭제하기'의 기능을 가진 버튼.
    @IBOutlet weak var timelbl: UILabel!    // 시간을 알려주는 라벨.
    @IBOutlet var titleTextField: UITextField!   // 제목을 적을 수 있는 텍스트필드
    @IBOutlet var iconPickerView: UIPickerView! // 아이콘을 고를 수 있는 피커뷰.
    
    
//  3) 피커뷰 함수
    
    // 아이콘 피커뷰의 피커 갯수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 아이콘 피커뷰의 종목 갯수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    // 아이콘 피커뷰 종목 이름 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName[row]
    }
    
    //피커뷰 이미지 프레임
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let imageView = UIImageView(image:imageArray[row])
        
        iconNumber = row
        
        imageView.frame = CGRect(x:0,y:0,width:44,height:44)
        
        return imageView
    }
    
//  4) TableViewController에서 받아온 값
    
    func receiveItem(_ item: String)
    {
        receiveItem = item
    }
    
    func receiveTime(_ item : String)
    {
        receiveTime = item
    }
    
    
//  5) ViewDidLoad 함수, 여기서 이미지 추가, 버튼 Visibility 등등을 설정한다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<3{
            let image = UIImage(named:imageFileName[i])
            imageArray.append(image)
        }
        
        // SegueNumber에 따라서 버튼을 숨길 것인지, 보여줄 것인지 설정할 수 있다.
        if (segueNumber == 0)
        {
            AddBtn.isHidden = false
            AdjustBtn.isHidden = true
            DeleteBtn.isHidden = true
        }
        else
        {
            AddBtn.isHidden = true
            AdjustBtn.isHidden = false
            DeleteBtn.isHidden = false
        }
        
        
        titleTextField.text = receiveItem
        timelbl.text = receiveTime
        
    }
    
    
//  6) 버튼 함수 - 버튼별 기능을 설정한다.
    
    // 시간을 고르는 DatePicker 설정
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        
        let datePickerView = sender
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        
        time = formatter.string(from: datePickerView.date)
        
        timelbl.text = time.description
    }
    
    // 추가하기 버튼 설정
    @IBAction func btnAddItem(_ sender: UIButton) {
        
        Time.append(time)
        
        items.append(titleTextField.text!)
        
        itemsImageFile.append(imageFileName[iconNumber])
        
        titleTextField.text = ""
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    // 수정하기 버튼 설정
    @IBAction func btnAdjustItem(_ sender: UIButton) {
        
        Time[indexPath] = time
        
        items[indexPath] = titleTextField.text!
        
        itemsImageFile[indexPath] = imageFileName[iconNumber]
        
        titleTextField.text = ""
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    
    // 삭제 버튼 설정, 오직 '수정하기' 버튼에서만 실행됨.
    @IBAction func btnDeleteItem(_ sender: UIButton) {
        
        items.remove(at: indexPath) // 아이템 제거
        
        itemsImageFile.remove(at: indexPath) // 이미지 제거
        
        _ = navigationController?.popViewController(animated: true) // 메인 화면으로 이동
        
    }
    
    // Segue값 설정. 이 함수를 통해 이 함수를 부른 이유가 "추가하기"를 부르기 위함인지, "수정하기"를 부르기 위함인지를 알 수 있다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 'sgAdd'란 Segue (하나의 터널로 생각하면 좋다. 어떤 버튼을 누르르냐에 따라 값이 다르다) 중 "추가하기"를 실행하기 위한 값이다.
        // Segue의 종류로는 "sgAdd"와 "sgDetail"이 있다. 각각 "추가하기", "수정하기"의 의미를 담고 있다.
        // 'sgAdd'는 메인화면 테이블뷰에서 우측 상단 추가 버튼을 누르면 실행된다.
        // 'sgDetail'은 메인화면 테이블뷰에서 아이템을 누르면 실행된다.
        
        if segue.identifier == "sgAdd"
        {
            segueNumber = 0
        }
        
        else
        {
            segueNumber = 1
        }
    }

}
