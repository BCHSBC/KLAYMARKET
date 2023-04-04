import 'package:flutter/material.dart';
import 'package:klaymarket/screens/main_screen.dart';
import 'package:klaymarket/widgets/image_list_view.dart';
import 'package:klaymarket/tools/metamask_provider.dart';
import 'package:klaymarket/tools/nft_contract.dart';
import 'package:get/get.dart';
import 'package:web3d/web3d.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  //final controller = Get.put(BCController());
  @override
  Widget build(BuildContext context) {
    final bcController = Get.put(BCController());
    final scController = Get.put(NftController());
    // Scaffold는 구글의 Material Design을 기반으로 하는 위젯
    return Scaffold(
          backgroundColor: const Color(0xff010101),
          // Stack은 Column과 다르게 정해진 위치나 규칙없이 배치만 하므로
          // Container들이 겹친다. 따라서 Positioned Class를 이용해 위치를 정한다
          body: Stack(
            children: [
              // 화면을 꽉채우자
              Positioned.fill(
                // 자식 위젯에 페인트칠하는 거, 색을 덧댄다
                child: ShaderMask(
                  blendMode: BlendMode.dstOut,
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.9),
                        Colors.black,
                      ],
                      stops: const [0, 0.62, 0.67, 0.85, 1],
                    ).createShader(rect);
                  },
                  // Container 크기가 넘쳐서 오버플로우가 날 수 있음
                  // 해당 위젯으로 크기가 넘어가면 스크롤해서 볼 수 있게 한다
                  child: SingleChildScrollView(
                    // 방향은 위아래로
                    child: Column(
                      children: const <Widget>[
                        SizedBox(height: 30),
                        ImageListView(
                          startIndex: 1,
                          duration: 25,
                        ),
                        SizedBox(height: 10),
                        ImageListView(
                          startIndex: 11,
                          duration: 45,
                        ),
                        SizedBox(height: 10),
                        ImageListView(
                          startIndex: 21,
                          duration: 65,
                        ),
                        SizedBox(height: 10),
                        ImageListView(
                          startIndex: 31,
                          duration: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 24,
                right: 24,
                child: Container(
                  height: 170,
                  child: Column(
                    // 세로축을 기준으로 왼쪽으로 정렬
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'NFT MarketPlace by HS',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'TWO',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Based on Mehran Shoghi\'s fast code NFT. Its for Klaytn Token',
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.2,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 140,
                        height: 50,
                        alignment: Alignment.center,
                        // 네모 박스 테두리를 둥글게 만든다
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff3000ff),
                        ),
                        child: 
                          GetBuilder<BCController>(
                            builder: (_) {
                              var message = '';
                              if(bcController.isConnected && bcController.isInOperatingChain){
                                message = 'Connected';
                                debugPrint(message);
                              }else if(bcController.isConnected && !bcController.isInOperatingChain){
                                message = 'Wrong Chain';
                              }else if(Ethereum.isSupported){
                                return ElevatedButton(onPressed: bcController.connectProvider, child: Text('Connect'));
                              }else{
                                message = 'Not Supported';
                              }
                              return ElevatedButton(
                                  onPressed: () => {
                                    GetBuilder<NftController>(
                                      builder: (_){
                                        scController.connect();
                                        return SizedBox.shrink();
                                      },
                                    ),
                                    Navigator.push(context,MaterialPageRoute(builder:(context)=>MainScreen())),
                                  }
                                  ,
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(140, 50),
                                  ),
                                  child: const Text(
                                    'Get Started',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                            }
                          ),
                        
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}