# TodoList
생산성을 높여주는 할 일 관리 앱입니다.

## Project
### TableViewController
이 함수는 메인 화면을 컨트롤합니다. 메인 화면에서는 우측 상단에 추가 버튼과, 좌측 상단에 수정 버튼, 그리고 중간에는 표가 그려저있습니다. 이 함수는 수정, 그리고 할 일 표시를 담당합니다. 함수의 구성은 기본적인 TableView에 관한 셋팅입니다.

<img src="https://github.com/ycostdalp/TodoList/blob/main/%E1%84%86%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AB.png" width="300px" height="600px" title="px(픽셀) 크기 설정" alt="RubberDuck"></img><br/>

<img src="https://github.com/ycostdalp/TodoList/blob/main/%E1%84%89%E1%85%A1%E1%86%A8%E1%84%8C%E1%85%A6.png" width="300px" height="600px" title="px(픽셀) 크기 설정" alt="RubberDuck"></img><br/>


### AddViewController
이 함수는 추가 화면, 그리고 수정 화면을 컨트롤합니다. 추가 화면과 수정 화면의 구분은 Segue를 통한 값의 변화에 따라 결정이 되며, 이러한 값을 이용해 버튼을 보여주거나 숨길 수 있습니다. 처음에는 추가 화면과 수정 화면의 뷰컨트롤러를 다르게 설정하려고 기획했으나, 개발하고 보니 비슷한 부분이 많아 코드를 통일화하여 간편화를 많이 하였습니다.

<img src="https://github.com/ycostdalp/TodoList/blob/main/%E1%84%8E%E1%85%AE%E1%84%80%E1%85%A1.png" width="300px" height="600px" title="px(픽셀) 크기 설정" alt="RubberDuck"></img><br/>

## Closing
깔끔하고 직관적인 인터페이스를 이용하여 생산성을 높여보세요!
