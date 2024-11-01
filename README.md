<h2>[Recoa]_Resident-Communication-Apartment</h2>

## 📋 목차
- [프로젝트 소개](#프로젝트-소개)
- [화면 구성](#화면-구성)
- [주요 기능](#주요-기능)
- [상세 기능](#상세-기능)

<hr>

### 프로젝트 소개
<img src="src/main/webapp/resources/images/main/mainPage.png"/>

#### (1) 소개 
- Recoa는 대단지 아파트 주민들의 보다 편리한 생활과 주민 간의 높은 유대감을 위한 플랫폼입니다.
- 독서실과 게스트 하우스 예약 기능을 제공하며 공지 게시판과 자유 게시판을 통해 주민들이 소통할 수 있는 공간을 마련했습니다.
- 다른 주민들과 관리자에게 쪽지나 채팅으로 쉽게 연락할 수 있고 고지서 확인 또한 가능합니다.
- 편리하고 유용한 기능들이 가득한 이 사이트에서 주민들이 함께 소통해보세요!

#### (2) 개발 기간 
<span>2024.07 ~ 2024.10 (약 2.5개월)</span>

#### (3) 팀원 구성
| 손민정 | 권예빈 |
| --- | --- |
| <img src="https://avatars.githubusercontent.com/u/152463277?v=4" width="100px" height="100px">|<img src="https://avatars.githubusercontent.com/u/152463087?v=4" width="100px" height="100px">|
| [sohnminjeong](https://github.com/sohnminjeong) | [gwon428](https://github.com/gwon428) |

#### (3_1) 역할 분담
##### 🍎 손민정
- **UI**
    - 페이지 : 로그인, 회원가입, 회원 마이 페이지, 관리자 페이지, 자유 게시판, 쪽지, 채팅
    - 공통 컴포넌트 : 상단 메뉴, 회원 쪽지&채팅&알림 탭
- **기능**
    - Spring Security 활용 _ 로그인 및 로그아웃, 회원가입 및 탈퇴, 아이디 및 비밀번호 찾기, 회원 정보 수정, 비밀번호 암호화
    - 자유 게시판 CRUD, 댓글 CRD, 좋아요 기능
    - 쪽지 CRD
    - WebSocket 활용 _ 1:1 채팅, 게시판 댓글&쪽지&채팅 알림
  
##### 🐶 권예빈
- **UI**
    - 페이지 : 메인 화면, ...
- **기능**
    - 공지 게시판, 독서실 예약, 게스트하우스 예약, 결제, ...

#### (4) Stacks 🧰
|||
|---|---|
|운영체제|Windows|
|사용언어|Java, JavaScript, HTML, CSS|
|FrameWork 및 Library|Spring, MyBatis, Security, Lombok, JSTL, Jackson, jQuery|
|DB|MySQL|
|Tool|JSP, STS(Spring Tool Suite)|
|WAS|Apache-Tomcat|
|Collaboration|Notion, Github, GoogleSheet|

<hr>

### 화면 구성
|메인페이지|
|:---:|
|<img src="src/main/webapp/resources/images/main/mainPage.png"/>|

|로그인|회원가입|
|:---:|:---:|
|![로그인 화면](https://github.com/user-attachments/assets/73db5872-beed-4753-9800-68ce5504bfec)|![회원가입 화면](https://github.com/user-attachments/assets/520b0c13-3a17-48ca-964b-84e89598b146)|

|회원 마이페이지|관리자 마이페이지|
|:---:|:---:|
|![회원 마이페이지](https://github.com/user-attachments/assets/a0fce0cc-27bb-4a52-8969-c558a03bb2eb)|![관리자 마이페이지](https://github.com/user-attachments/assets/37830e70-37d8-4b82-adfc-6a6e12048b1b)|

|공지 게시판|자유 게시판|
|:---:|:---:|
|![공지게시판](https://github.com/user-attachments/assets/905f2a1d-a72c-4b75-a931-d30e00f5dd17)|![자유게시판](https://github.com/user-attachments/assets/0112f37d-c4d5-45a6-b681-984ffe80baf7)|

|독서실 예약|게스트하우스 예약|
|:---:|:---:|
|![독서실 예약](https://github.com/user-attachments/assets/dc9ba069-1b89-4af2-96ea-47a3d4f540af)|![게스트하우스 예약](https://github.com/user-attachments/assets/7295538a-2a15-4091-9984-abb8e52cf5b8)|

|쪽지|채팅|
|:---:|:---:|
|![쪽지](https://github.com/user-attachments/assets/af06ed34-8a97-4db0-bc21-45dab55a16ec)|![채팅](https://github.com/user-attachments/assets/3989b4aa-2d30-4ea9-b7f0-6b52be769ed7)|

|알림목록|알림창|
|:---:|:---:|
|![알림목록](https://github.com/user-attachments/assets/10cd207d-2072-4eb1-b7de-1b3eb23ffc67)|![알림](https://github.com/user-attachments/assets/fa58eb6a-f59c-45f1-bdb7-4d1b032ca345)|

<hr>

### 주요 기능

<hr>

### 상세 기능

