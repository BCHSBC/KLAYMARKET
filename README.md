# KLAYMARKET
- 이더리움의 NFT 토큰인 ERC721을 기반으로 만들어진 클레이튼의 KIP17을 사용하는 마켓 플레이스를 구현

# 2023.3.29
- 기존 UI화면에서 Discover버튼을 Get Started버튼으로 바꿔서 버튼 클릭 시 마켓플레이스 메인 페이지 가게 만들었다.
- 마켓플레이스 화면 미 구현

# 2023.3.30
- flutter_web3 패키지를 이용하여 Get started 버튼을 클릭 시 메타 마스크에 로그인 하도록 구현
- 해당 앱은 Klaytn의 테스트 넷인 바오밥 네트워크(일단 이거만)를 위한 것이므로 해당 네트워크에 연결되게 지시한다
- 올바르게 연결되었을 시 마켓플레이스 메인 페이지로 넘어가게 한다

- 다시 로그인 페이지로 돌아가게 미 구현
- web 환경에서 테스트 시 chrome debug 모드에서는 메타마스크가 동작할 수 없어서
- flutter run -d web-server 명령어를 이용한다

# 2023.4.4
- 메타 마스크 로그인 완료 시 메인 화면을 보여준다
- 메인 페이지는 아래에 3개의 bottomNavigation으로 이루어져있고 각각 민팅, 콜렉션, 구매 화면이다
- 민트 화면에는 사용자의 공개 키를 보여주고, 이미지 파일(일단)을 받아 아이템 이름과, 설명 등을 작성한 뒤 create 버튼을 눌러 민팅을 한다. 아직 create 버튼은 미구현
- web3d(flutter_web3 for klaytn)을 이용하여 바오밥 테스트넷(1001)에 deploy된 contract을 불러와서 사용한다
- 해당 방법이 작동하는지 확인하기 위해 임시로 collections 페이지에 있는 버튼을 누르면 console 창에 토큰 이름이 찍히게 하였다.
- 지갑 개체나 컨트랙 개체 모두 getx로 상태 관리를 한다. 컨트롤러를 정의해서 계속 불러와서 사용하는 방식으로 했다(해당 방법이 좋은 지는 모르겠다, 일단 간편해서 좋다)
- flutter_web3를 웹에서 사용할려면 scripts 부분에 꼭 추가(하라는대로하면된다)를 해줘야 잘 돌아간다



# 2023.04.05 해당 앱은 웹앱인데 웹으로 만들면서 IPFS 와 연동하기도 너무 힘들고 지원하는 패키지도 퀄리티가 굉장히 안좋아서 이 프로젝트는 마감하기로 했다. 그냥 Truffle로 만드는 튜토리얼이나 따라해봐야겠다
