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
