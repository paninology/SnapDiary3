




#  개발일지

2023.5.17
>프로젝트 시작
>

2023.5.19
> 일기리스트뷰컨

5.30
> 카드선택뷰 편집화면
> 편집시 플러스 셀이 나오고, 그 셀을 누르면 새 카드를 추가하고싶다. 그것만 따로 셀 디자인과 로직을 구별할수 있는지 ...

6.1
> 텍스트뷰에 중앙 정렬 기능이 없어서 
        let contentSize = mainView.textView.contentSize
        let topMargin = (mainView.textView.bounds.height / 2) - (contentSize.height / 2)
        mainView.textView.contentInset = UIEdgeInsets(top: topMargin, left: 0, bottom: 0, right: 0)
>

6.2
>카드 디테일까지 레이아웃 완료. 
>이쯤에서 모델,렘디비 연결 후 속행        
> 깃허브 리모트 새롬 만들었다. 에러나서
    
6.6
>카드리스트뷰(덱뷰) 지우기 로직     
        
# 메모

혜린질문
> 새일기 설정 인셋그룹?그룹?
>요일옵션 휠? 버튼?

1차 전반섹션 개발 계획
> 레이아웃
> 메인->새일기장->덱리스트->카드리스트->카드디테일->일기장보기->일기쓰기(새카드)
> 모델 연결
> 디비
> 디자인 
> 테스트 및 수정: TDD적용


추가 기능
>새카드 만들기에서 기존카드 가져오는 기능
>일기 시작날짜
>날ㅆㅣ정보
