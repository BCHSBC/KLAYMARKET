import 'package:flutter/material.dart';
import 'package:klaymarket/screens/main_screen.dart';
import 'package:klaymarket/widgets/image_list_view.dart';
import 'package:klaymarket/tools/metamask_provider.dart';
import 'package:metamask/metamask.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold는 구글의 Material Design을 기반으로 하는 위젯
    return Scaffold(
      backgroundColor: const Color(0xff010101),
      // Stack은 Column과 다르게 정해진 위치나 규칙없이 배치만 하므로
      // Container들이 겹친다. 따라서 Positioned Class를 이용해 위치를 정한다
      body: ChangeNotifierProvider(
          create: (context) => MetaMaskProvider()..start(),
          builder: (context, child) {
            return Stack(
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
                          child: Consumer<MetaMaskProvider>(
                              builder: (context, provider, child) {
                            late final String message;
                            if (provider.isConnected &&
                                provider.isInOperatingChain) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> const MainScreen()),
                              );
                            } else if (provider.isConnected &&
                                !provider.isInOperatingChain) {
                              message =
                                  'Wrong Chain. Please Connect to ${MetaMaskProvider.operatingChain}';
                            } else if (provider.isEnabled) {
                              return ElevatedButton(
                                onPressed: () => {
                                  context.read<MetaMaskProvider>().connect()
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff3000ff),
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
                            } else {
                              message = 'Please use a Web3 supported browser';
                            }
                            return Container(
                              child:  Text(
                                message,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
