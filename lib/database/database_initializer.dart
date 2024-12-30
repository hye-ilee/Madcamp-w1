import 'package:phone_demo/helpers/database_helper.dart';

class DatabaseInitializer {
  static Future<void> initializeDatabase() async {
    final userInfo = {
      'name': '형원',
      'music_cnt': 1,
      'study_cnt': 0,
      'dessert_cnt': 0,
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
        'music': 10,
        'study': 10,
        'dessert': 10,
        'pet': 10,
        'space': 10,
        'time': 10,
      },
      {
        'name': '가배로스터스',
        'menus': '소금커피라떼, 수국차, 조각케이크',
        'images': 'assets/gabae1.jpeg, assets/gabae2.jpg',
        'kakao_id': '2031573995',
        'phone': '010-2932-0896',
        'location': '580490, 796110',
        'music': 6,
        'study': 6,
        'dessert': 9,
        'pet': 5,
        'space': 6,
        'time': 7,
      },
      {
        'name': '유성별',
        'menus': '아인슈페너, 단호박라떼, 눈꽃우유팥빙수',
        'images': 'assets/yusungstar1.jpg, assets/yusungstar2.jpg',
        'kakao_id': '1654668564',
        'phone': '042-361-1636',
        'location': '579618, 795682',
        'music': 9,
        'study': 7,
        'dessert': 8,
        'pet': 8,
        'space': 6,
        'time': 9,
      },
      {
        'name': '라빅커피',
        'menus': '아이리쉬클래식, 락솔트아인슈페너',
        'images': 'assets/ravic1.jpg',
        'kakao_id': '683530497',
        'phone': 'no_number',
        'location': '578343, 796105',
        'music': 5,
        'study': 10,
        'dessert': 7,
        'pet': 8,
        'space': 5,
        'time': 9,
      },
      {
        'name': '레서',
        'menus': '찰쑥크림라떼, 금홍차, 플랫화이트',
        'images': 'assets/lesser1.jpeg',
        'kakao_id': '1551544130',
        'phone': '0502-5551-1267',
        'location': '579907, 795885',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '바리스타빈',
        'menus': '아이스크림푸딩, 쑥크림라떼',
        'images': 'assets/baristabean1.jpeg',
        'kakao_id': '12256824',
        'phone': '010-5348-8095',
        'location': '578934, 795726',
        'music': 7,
        'study': 6,
        'dessert': 8,
        'pet': 5,
        'space': 8,
        'time': 6,
      },
      {
        'name': '카페누오보베니에',
        'menus': '살라미와크래커, 뉴올리언즈라떼',
        'images': 'assets/cafe nuovo1.jpg, assets/cafe nuovo2.jpg',
        'kakao_id': '21746723',
        'phone': '042-300-5425',
        'location': '577978, 795815',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '오픈오피스아워즈',
        'menus': '레몬머틀티',
        'images':
            'assets/ooo1.jpg, assets/ooo2.jpeg, assets/ooo3.jpg, assets/ooo4.jpg',
        'kakao_id': '1308811193',
        'phone': 'no_number',
        'location': '579620, 795425',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '데일리오아시스',
        'menus': '말차먹었소, 수플레팬케이크',
        'images': 'assets/oasis1.jpg, assets/oasis2.jpg',
        'kakao_id': '317264942',
        'phone': '010-5584-0847',
        'location': '576228, 792830',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '소신',
        'menus': '크림치즈아인슈페너, 초코솔트휘낭시에',
        'images': 'assets/sosin1.jpg, assets/sosin2.jpeg',
        'kakao_id': '1130406500',
        'phone': 'no_number',
        'location': '579132, 795572',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '소속',
        'menus': '달고나라떼, 소속라떼, 빅토리아케이크',
        'images': 'assets/sosoc1.jpg',
        'kakao_id': '1509017418',
        'phone': '010-2797-4184',
        'location': '579451, 795500',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '글로리데이즈',
        'menus': '흑임자라떼, 히말라야솔트커피',
        'images': 'assets/glory days1.jpg',
        'kakao_id': '32222147',
        'phone': '042-825-9516',
        'location': '578113, 795485',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '카페니치 어은점',
        'menus': '옛날팥빙수, 니치마로끼노',
        'images': 'assets/niche1.jpg',
        'kakao_id': '1573329091',
        'phone': '042-863-0092',
        'location': '579500, 795575',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 10,
        'space': 7,
        'time': 8,
      },
      {
        'name': '카페니치 어은점',
        'menus': '옛날팥빙수, 니치마로끼노',
        'images': 'assets/niche2.jpg',
        'kakao_id': '1949396728',
        'phone': '042-825-9994',
        'location': '566725, 792030',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': 'H&H',
        'menus': '그라니타라떼',
        'images': 'assets/H&H1.jpeg',
        'kakao_id': '2090197459',
        'phone': '010-2038-3916',
        'location': '580153, 795987',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '트웰브오',
        'menus': '메론크림치즈까나페, 애플리코타치즈샐러드',
        'images': 'assets/12o1.jpg',
        'kakao_id': '1050926018',
        'phone': 'no_number',
        'location': '585216, 802233',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '에이트',
        'menus': '로투스라떼, 히말라야소금라떼',
        'images': 'assets/aight1.jpeg, assets/aight2.jpg',
        'kakao_id': '725432692',
        'phone': '042-716-1195',
        'location': '578485, 795055',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '하이테이블',
        'menus': '메론쉐이크, 햇쌀라떼',
        'images': 'assets/hightable1.jpg',
        'kakao_id': '1904964131',
        'phone': '010-2226-2682',
        'location': '577015, 793624',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '미들슬로우',
        'menus': '츄러스아이스크림, 미니수플레',
        'images': 'assets/middleslow1.jpeg',
        'kakao_id': '1101454804',
        'phone': 'no_number',
        'location': '591814, 805147',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
      {
        'name': '카페제작소',
        'menus': '아인슈페너, 유자에이드',
        'images': 'assets/cafe jejakso1.jpg, assets/cafe jejakso2.jpg',
        'kakao_id': '27392152',
        'phone': '042-826-3161',
        'location': '578493, 795864',
        'music': 10,
        'study': 5,
        'dessert': 7,
        'pet': 8,
        'space': 7,
        'time': 8,
      },
    ];
    // Insert sample cafes into the database
    for (var cafe in sampleCafes) {
      await DatabaseHelper.instance.insertCafe(cafe);
      print('Cafe inserted: ${cafe['name']}');
    }
  }
}
