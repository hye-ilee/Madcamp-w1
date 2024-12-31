import 'package:phone_demo/helpers/database_helper.dart';

class DatabaseInitializer {
  static Future<void> initializeDatabase() async {
    final userInfo = {
      'user_name': '형원',
      'vibey_cnt': 1,
      'afternoon_cnt':0,
      'study_cnt': 0,
      'dessert_cnt': 0,
      'coffee_cnt': 0,
      'pet_cnt': 0,
      'space_cnt': 0,
      'time_cnt': 0,
      'profile_img': 'profile_image.png',
      "jjim_list": "[\"2031573995\", \"2044764824\"]"
// Stored as a JSON string
    };
    await DatabaseHelper.instance.insertUserInfo(userInfo);
    print('User info inserted.');

    final sampleCafes = [
      {
        'name': '프리앙',
        'menus': '바닐라빈라떼, 드라이카푸치노, 자두에이드',
        'images': 'assets/friand1.jpg, assets/friand2.jpg',
        'kakao_id': '2044764824',
        'phone': '070-8671-2334',
        'location': '579788, 795476',
        'vibey': 5,
        'afternoon': 6,
        'study': 7,
        'dessert': 10,
        'coffee': 5,
        'pet': 0,
        'space': 5,
        'time': 6,
      },
      {
        'name': '가배로스터스 1호점',
        'menus': '소금커피라떼, 수국차, 조각케이크',
        'images': 'assets/gabae1.jpeg, assets/gabae2.jpg',
        'kakao_id': '2031573995',
        'phone': '010-2932-0896',
        'location': '580490, 796110',
        'vibey': 6,
        'afternoon': 5,
        'study': 10,
        'dessert': 6,
        'coffee': 7,
        'pet': 3,
        'space': 6,
        'time': 7,
      },
      {
        'name': '유성별',
        'menus': '아인슈페너, 단호박라떼, 눈꽃우유팥빙수',
        'images': 'assets/yusungstar1.jpg, assets/yusungstar2.jpg',
        'kakao_id': '1654668564',
        'phone': '042-301-7259',
        'location': '579618, 795682',
        'vibey': 9,
        'afternoon': 6,
        'study': 9,
        'dessert': 6,
        'coffee': 7,
        'pet': 3,
        'space': 7,
        'time': 10,
      },
      {
        'name': '라빅커피',
        'menus': '아이리쉬클래식, 락솔트아인슈페너',
        'images': 'assets/ravic1.jpg',
        'kakao_id': '683530497',
        'phone': 'no_number',
        'location': '578343, 796105',
        'vibey': 5,
        'afternoon': 5,
        'study': 7,
        'dessert': 7,
        'coffee': 6,
        'pet': 8,
        'space': 6,
        'time': 7,
      },
      {
        'name': '레서',
        'menus': '찰쑥크림라떼, 금홍차, 플랫화이트',
        'images': 'assets/lesser1.jpeg',
        'kakao_id': '1551544130',
        'phone': '0502-5551-1267',
        'location': '579907, 795885',
        'vibey': 5,
        'afternoon': 5,
        'study': 8,
        'dessert': 7,
        'coffee': 5,
        'pet': 10,
        'space': 7,
        'time': 7,
      },
      {
        'name': '바리스타빈',
        'menus': '아이스크림푸딩, 쑥크림라떼',
        'images': 'assets/baristabean1.jpg',
        'kakao_id': '12256824',
        'phone': '010-5348-8095',
        'location': '578934, 795726',
        'vibey': 8,
        'afternoon': 7,
        'study': 10,
        'dessert': 8,
        'coffee': 6,
        'pet': 3,
        'space': 8,
        'time': 7,
      },
      {
        'name': '카페 누오보베니에',
        'menus': '살라미와크래커, 뉴올리언즈라떼',
        'images': 'assets/cafe nuovo1.jpg, assets/cafe nuovo2.jpg',
        'kakao_id': '21746723',
        'phone': '042-300-5425',
        'location': '577978, 795815',
        'vibey': 8,
        'afternoon': 6,
        'study': 10,
        'dessert': 9,
        'coffee': 5,
        'pet': 0,
        'space': 9,
        'time': 10,
      },
      {
        'name': '오픈오피스아워즈',
        'menus': '레몬머틀티',
        'images':
            'assets/ooo1.jpg, assets/ooo2.jpeg, assets/ooo3.jpg, assets/ooo4.jpg',
        'kakao_id': '1308811193',
        'phone': '0507-1460-1176',
        'location': '579620, 795425',
        'vibey': 9,
        'afternoon': 9,
        'study': 10,
        'dessert': 5,
        'coffee': 6,
        'pet': 8,
        'space': 7,
        'time': 4,
      },
      {
        'name': '데일리오아시스 대전유성점',
        'menus': '말차먹었소, 수플레팬케이크',
        'images': 'assets/oasis1.png, assets/oasis2.jpg',
        'kakao_id': '317264942',
        'phone': '010-5584-0847',
        'location': '576228, 792830',
        'vibey': 6,
        'afternoon': 10,
        'study': 6,
        'dessert': 10,
        'coffee': 5,
        'pet': 3,
        'space': 7,
        'time': 6,
      },
      {
        'name': '소신',
        'menus': '크림치즈아인슈페너, 초코솔트휘낭시에',
        'images': 'assets/sosin1.jpg, assets/sosin2.jpeg',
        'kakao_id': '1130406500',
        'phone': '010-8558-9746',
        'location': '579132, 795572',
        'vibey': 9,
        'afternoon': 8,
        'study': 5,
        'dessert': 9,
        'coffee': 6,
        'pet': 3,
        'space': 6,
        'time': 6,
      },
      {
        'name': '소속',
        'menus': '달고나라떼, 소속라떼, 빅토리아케이크',
        'images': 'assets/sosoc1.jpg, assets/sosoc2.jpg',
        'kakao_id': '1509017418',
        'phone': '010-2797-4184',
        'location': '579451, 795500',
        'vibey': 5,
        'afternoon': 9,
        'study': 5,
        'dessert': 10,
        'coffee': 6,
        'pet': 10,
        'space': 6,
        'time': 5,
      },
      {
        'name': '글로리데이즈',
        'menus': '흑임자라떼, 히말라야솔트커피',
        'images': 'assets/glory days1.jpg',
        'kakao_id': '32222147',
        'phone': '042-825-9516',
        'location': '578113, 795485',
        'vibey': 9,
        'afternoon': 8,
        'study': 9,
        'dessert': 8,
        'coffee': 5,
        'pet': 8,
        'space': 8,
        'time': 9,
      },
      {
        'name': '카페니치 어은점',
        'menus': '옛날팥빙수, 니치마로끼노',
        'images': 'assets/niche1.jpg',
        'kakao_id': '1573329091',
        'phone': '042-863-0092',
        'location': '579500, 795575',
        'vibey': 9,
        'afternoon': 8,
        'study': 10,
        'dessert': 3,
        'coffee': 5,
        'pet': 10,
        'space': 7,
        'time': 10,
      },
      {
        'name': '빈이어',
        'menus': '커스터드 푸딩, 호지라떼',
        'images': 'assets/beaneer1.jpg',
        'kakao_id': '1605411900',
        'phone': '010-8408-1396',
        'location': '583590, 792665',
        'vibey': 10,
        'afternoon': 9,
        'study': 6,
        'dessert': 7,
        'coffee': 9,
        'pet': 10,
        'space': 6,
        'time': 7,
      },
      {
        'name': 'H&H',
        'menus': '그라니타라떼',
        'images': 'assets/H&H1.jpeg',
        'kakao_id': '2090197459',
        'phone': '010-2038-3916',
        'location': '580153, 795987',
        'vibey': 8,
        'afternoon': 7,
        'study': 8,
        'dessert': 7,
        'coffee': 6,
        'pet': 10,
        'space': 6,
        'time': 6,
      },
      {
        'name': '카페 트웰브오 어은점',
        'menus': '바닐라 말차 바스크치즈케이크, 프렌치토스트',
        'images': 'assets/12o1.jpg',
        'kakao_id': '1176216847',
        'phone': '0507-1370-1327',
        'location': '579420, 795550',
        'vibey': 5,
        'afternoon': 7,
        'study': 5,
        'dessert': 8,
        'coffee': 6,
        'pet': 3,
        'space': 7,
        'time': 2,
      },
      {
        'name': '에이트',
        'menus': '로투스라떼, 히말라야소금라떼',
        'images': 'assets/aight1.jpeg, assets/aight2.jpg',
        'kakao_id': '725432692',
        'phone': '042-716-1195',
        'location': '578485, 795055',
        'vibey': 5,
        'afternoon': 7,
        'study': 8,
        'dessert': 7,
        'coffee': 7,
        'pet': 0,
        'space': 10,
        'time': 10,
      },
      {
        'name': '하이테이블',
        'menus': '메론쉐이크, 햇쌀라떼',
        'images': 'assets/hightable1.jpg, assets/hightable2.jpg',
        'kakao_id': '1904964131',
        'phone': '010-2226-2682',
        'location': '577015, 793624',
        'vibey': 5,
        'afternoon': 7,
        'study': 9,
        'dessert': 7,
        'coffee': 6,
        'pet': 0,
        'space': 10,
        'time': 10,
      },
      {
        'name': '미들슬로우 본점',
        'menus': '츄러스아이스크림, 미니수플레',
        'images': 'assets/middleslow1.jpeg',
        'kakao_id': '1101454804',
        'phone': '0507-1388-8775',
        'location': '591814, 805147',
        'vibey': 5,
        'afternoon': 8,
        'study': 9,
        'dessert': 8,
        'coffee': 10,
        'pet': 3,
        'space': 7,
        'time': 6,
      },
      {
        'name': '카페제작소',
        'menus': '아인슈페너, 유자에이드',
        'images': 'assets/cafe jejakso1.jpg, assets/cafe jejakso2.jpg',
        'kakao_id': '27392152',
        'phone': '042-826-3161',
        'location': '578493, 795864',
        'vibey': 5,
        'afternoon': 6,
        'study': 7,
        'dessert': 6,
        'coffee': 4,
        'pet': 0,
        'space': 7,
        'time': 10,
      },
    ];
    // Insert sample cafes into the database
    for (var cafe in sampleCafes) {
      await DatabaseHelper.instance.insertCafe(cafe);
      print('Cafe inserted: ${cafe['name']}');
    }
  }
}
