
# CAFE-in 카페-인

## 개요 📝
**CAFE-in**은 카이스트 주변 20개의 카페 정보를 개발자가 직접 가보고 평가한 8개 항목의 점수를 기반으로 보여주는 앱입니다.
카페 찜하기로 연락처를 등록하고, 유저가 어떤 카테고리의 카페를 자주 찾아보는지를 반영해 추천하는 카페 사진을 보여줍니다.

---

## 앱 구성 📱

### 1. **🔍 카페 검색 탭**
- 각 카페의 점수 항목인 8개의 카테고리 아이콘을 클릭 시, 해당 항목의 TOP 5 카페들 리스트가 보입니다.
- 카페 이름이나 메뉴로 검색도 가능합니다.
<p align="center">
  <img src="https://github.com/user-attachments/assets/cd503542-f7f6-4d6d-8d91-0af9dc6734e5" width="300">
  <img src="https://github.com/user-attachments/assets/d5705d04-67a9-4c48-9f72-a5b045a95f1a" width="300">
</p>

### 2. **🗺️ 카페 정보 시트**
- 카페 검색 탭이나 갤러리에서 특정 요소를 클릭 시, 해당 (이미지의)카페 정보가 하단에서 올라옵니다.
- 화면 상단을 채우는 구글맵 API 기반 지도로 카페의 대략적인 위치를 시각화했습니다.
- 드래그가 가능한 하단 시트에는 카페 이름, 연락처, 사진들과 카페 메뉴 리스트가 보입니다.
  - 카페 찜하기 버튼과 카카오맵 URL이 열리는 버튼이 함께 위치해 있습니다.
- *showModalBottomSheet와 DraggableScrollableSheet로 구현하였습니다.*

### 3. **🖼️ 추천하는 카페 갤러리 탭**
- 유저가 주로 어떤 카테고리의 카페를 찾아봤는지를 '추천하는 카페' 갤러리에 반영하여 유저의 취향에 맞을 것 같은 카페 사진들을 우선으로 보여줍니다.
  - 검색 탭에서 각 카테고리의 클릭 수를 기록하여, 사진의 우선순위 정렬에 필요한 8개 항목 점수를 합산할 때 가중치로 사용합니다.
<p align="center">
  <img src="https://github.com/user-attachments/assets/ce42f80a-e4bb-4d2d-8821-40736f94dfd5" width="300">
</p>

### 4. **📞 찜한 카페 연락처 탭**
- 카페 정보 시트에서 유저가 찜한 카페들의 연락처가 보입니다.
- 통화 버튼 옆에 찜하기 버튼으로 찜 취소도 가능합니다.
<p align="center">
  <img src="https://github.com/user-attachments/assets/7e3fc6b9-a3e4-4604-be23-4ca9f163044f" width="300">
</p>

---

## APK 설치 방법 🚀
Github Releases 내 "first release"의 **app-release.apk**를 참고하세요!

---

## 레퍼런스 📚
- **📷 카페 사진:** 카카오맵 및 네이버지도
- **🍴 카페 메뉴:** 카카오맵
- **🎨 로고 및 카테고리 아이콘:** Flaticon [author paulalee](https://www.flaticon.com/kr/authors/paulalee)
---

## 팀원 👥

| 이름   | 소속             | 이메일                  | Github ID                               | 
|------|----------------|----------------------|-----------------------------------------|
| 이혜리  | KAIST 전산학부     | harriet@kaist.ac.kr  | [hye-ilee](https://github.com/hye-ilee) | 
| 조형원  | 서울대학교 전기정보공학부  | dylanhwcho@gmail.com | [dylancho](https://github.com/dylancho) | 

<br>
