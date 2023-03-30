// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@klaytn/contracts/KIP/token/KIP17/KIP17.sol";
import "@klaytn/contracts/KIP/token/KIP17/extensions/KIP17Enumerable.sol";

contract MintNftToken is KIP17Enumerable{
    // 발행한 토큰의 개수, 인덱스 관리용으로 카운터를 사용한다
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;
    // ERC721 토큰의 생성은 이름과 심볼로 구성이되어있다
    constructor() KIP17("HSNM","HM"){}
    // 생성된 토큰들의 ipfs 주소를 담고 있는 매핑을 만들어준다
    mapping(uint => string) public tokenURIs;
    // 토큰의 아이디(인덱스)를 넣어주면 해당 토큰의 주소를 리턴해준다
    function tokenURI(uint _tokenId) override public view returns (string memory) {
        return tokenURIs[_tokenId];
    }
    // 토큰 한개를 민팅
    function mintNFT(string memory _tokenURI) public returns (uint256){
        // 카운터 하나 증가
        _tokenIds.increment();
        // tokenURIs에 새로운 토큰을 추가해준다
        uint256 tokenId = _tokenIds.current();
        tokenURIs[tokenId] = _tokenURI;
        // 민팅
        _mint(msg.sender, tokenId);

        return tokenId;
    }

    // 토큰의 정보를 담고있는 구조체
    struct NftTokenData{
        uint256 nftTokenId;
        string nftTokenURI;
        uint price;
    }

    // 사용자의 주소를 입력으로 넣어 해당 사용자가 가지고 있는 토큰의 정보를 반환한다
    function getNftToken(address _nftTokenOwner) view public returns (NftTokenData[] memory) {
        // 먼저 사용자의 주소에 밸런스(토큰의 수)크기를 가져온다
        uint256 balanceLength = balanceOf(_nftTokenOwner);
        //require(balanceLength != 0,"Owner did not have token");
        
        // 토큰 정보 구조체 배열 선언
        NftTokenData[] memory nftTokenData = new NftTokenData[](balanceLength);

        // 개수 만큼 돌면서 정보를 삽입
        for(uint256 i = 0; i < balanceLength; i++){
            uint256 nftTokenId = tokenOfOwnerByIndex(_nftTokenOwner,i);
            string memory nftTokenURI = tokenURI(nftTokenId);
            uint tokenPrice = getNftTokenPrice(nftTokenId);
            nftTokenData[i] = NftTokenData(nftTokenId,nftTokenURI,tokenPrice);
        }

        return nftTokenData;
    }

    // 토큰의 id를 주면 해당 토큰의 가격을 주는 매핑
    mapping(uint256=>uint256) public nftTokenPrices;
    // 현재 판매되고 있는 토큰의 id
    uint256[] public onSaleNftTokenArray;

    // 토큰의 id와 가격을 입력으로 넣어 판매를 한다
    function setSaleNftToken(uint256 _tokenId, uint256 _price) public {
        // 판매하고자하는 토큰의 주인
        address nftTokenOwner = ownerOf(_tokenId);

        // 판매자가 토큰의 주인인지를 확인
        require(nftTokenOwner == msg.sender , "Caller is not nft token owner.");
        // 판매 가격은 0이상이여야한다
        require(_price > 0, "Price is zero or lower.");
        // 토큰의 가격이 0이면 이미 판매가 완료된 것
        require(nftTokenPrices[_tokenId] == 0, "This nft token is already on sale.");
        // 판매자가 판매 권한이 있는지를 확인
        require(isApprovedForAll(nftTokenOwner,address(this)),"nft token owner did not approve token");

        // 토큰 가격 배열에 해당 토큰의 가격을 추가한다
        nftTokenPrices[_tokenId] = _price;
        // 현재 판매되고 있는 토큰을 담고있는 배열에 판매하고하자는 토큰을 추가한다
        onSaleNftTokenArray.push(_tokenId);
    }

    // 현재 판매 중인 토큰들을 보여주는 함수
    function getSaleNftTokens() public view returns (NftTokenData[] memory) {
        // 현재 판매되고 있는 토큰을 담은 배열
        uint[] memory onSaleNftToken = getSaleNftToken();
        // require(onSaleNftToken.length > 0 , "Not exist on sale Token");

        NftTokenData[] memory onSaleNftTokens = new NftTokenData[](onSaleNftToken.length);

        for(uint i = 0;i < onSaleNftToken.length; i++){
            uint tokenId = onSaleNftToken[i];

            uint tokenPrice = getNftTokenPrice(tokenId);
            onSaleNftTokens[i] = NftTokenData(tokenId, tokenURI(tokenId), tokenPrice);
        }

        return onSaleNftTokens;
    }

    function getSaleNftToken() view public returns(uint[] memory){
        return onSaleNftTokenArray;
    }

    function getNftTokenPrice(uint256 _tokenId) view public returns(uint256) {
        return nftTokenPrices[_tokenId];
    }
    
    // 토큰 구매
    function buyNftToken(uint256 _tokenId) public payable {
        uint256 price = nftTokenPrices[_tokenId];
        address nftTokenOwner = ownerOf(_tokenId);
        // 가격이 0이상
        require(price > 0,"nft token not sale.");
        // 구매자가 보낸 값이 판매 값보다 작으면 안된다
        require(price <= msg.value,"caller sent lower than price.");
        // 구매자가 판매자이면 안된다
        require(nftTokenOwner != msg.sender,"caller is nft token owner.");
        // 판매자 즉, 토큰의 주인이 검증이 된 사람이여야한다
        require(isApprovedForAll(nftTokenOwner,address(this)),"nft token owner did not approve token.");

        // 기존 토큰의 주인에게 돈을 송금
        payable(nftTokenOwner).transfer(msg.value);

        // 오픈제플린에서 제공하는 기능으로, 안전하게 ERC721토큰을 송금
        KIP17(address(this)).safeTransferFrom(nftTokenOwner,msg.sender,_tokenId);

        // 판매 리스트에서 삭제
        removeToken(_tokenId);
    }

    // 토큰 삭제
    function burn(uint256 _tokenId) public {
        address addr_onwer = ownerOf(_tokenId);
        require(addr_onwer == msg.sender,"msg.sender is not the token onwer");
        _burn(_tokenId);
        removeToken(_tokenId);
    }

    // 토큰을 판매 리시트에서 삭제
    function removeToken(uint256 _tokenId) private{
        // 토큰의 가격을 0으로 만든다
        nftTokenPrices[_tokenId] = 0;

        // 판매된 토큰을 리스트의 마지막 부분과 스위치하고 pop
        for(uint256 i = 0; i < onSaleNftTokenArray.length;i++){
            if(nftTokenPrices[onSaleNftTokenArray[i]] == 0){
                onSaleNftTokenArray[i] = onSaleNftTokenArray[onSaleNftTokenArray.length-1];
                onSaleNftTokenArray.pop();
            }
        }
    }
}
