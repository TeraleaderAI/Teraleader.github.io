# Work History

## 2026-04-29

### 초기 검토

- 현재 작업 폴더의 `src` 구조 확인
- 기존 `src/index.html`, `src/css/style.css`가 한글 깨짐과 placeholder 중심의 초안 상태임을 확인
- 작업지시 이미지 `작업지시관련/layout1-mainpage.jpg` 확인
- 초기 레이아웃 방향 파악:
  - 로고/메뉴
  - 대표 제품 배너
  - 제품 1~4 영역
  - 공지사항
  - 회사소개 썸네일
  - 제품안내 썸네일

### 구버전 홈페이지 원본 검토

구버전 소스 위치:

```text
old_src/wwwhome
```

확인 결과:

- ASP 기반
- EUC-KR 인코딩
- frameset 사용
- Artyboard 게시판 엔진 포함
- MSSQL DB 접속 사용

구버전 메뉴 구조:

- 회사소개
  - 연혁
  - 사업영역
  - 찾아오시는길
- 제품안내
- 기술정보
  - 보유기술
  - 인증서
- 커뮤니티
  - 공지사항
  - Q&A

구버전 제품 목록:

- CELL JIG
- OVEN
- DIGITAL PRESS
- AMPOULE FURNACE
- Thermal Analysis System
- TBS System
- RTP SYSTEM
- SUBSTRATE HEATER

`RTP SYSTEM`, `SUBSTRATE HEATER`는 구버전에서 비활성/주석 처리 상태로 판단했다.

### 기존 게시판/DB 구조 확인

확인 파일:

- `old_src/wwwhome/include/dbconnect.asp`
- `old_src/wwwhome/Artyboard/Dbconnect/Dbconnect.asp`
- `old_src/wwwhome/pages/board/board01.asp`
- `old_src/wwwhome/pages/board/board02.asp`
- `old_src/wwwhome/main/mainNotice.asp`

결론:

- 공지사항과 Q&A는 모양만 있는 것이 아니라 실제 DB 기반 게시판
- `notice`, `qanda` 게시판 ID 사용
- 메인 공지사항은 저장 프로시저를 통해 최신 글 조회

### 과거 개편 시도본 검토

참고 경로:

```text
\\192.168.0.9\web\teraleaderHomePage
```

확인 결과:

- `admin/`
- `api/`
- `data/`
- `server.js`
- `setup_db.sql`

Node/Express, PHP API, ASP API, DB 설계가 섞인 개편 시도본이었다.

재활용 판단:

- 관리자 UI 아이디어와 파일 기반 CMS 구조는 참고
- 운영 서버에 관리자/API를 올리는 방식은 채택하지 않음
- 로컬 전용 관리 툴 방향으로 전환

## 2026-04-29 ~ 2026-04-30

### 새 Astro 정적 사이트 생성

새 작업 폴더:

```text
site/
```

구성:

- Astro 정적 사이트
- 제품/공지/회사 데이터를 JSON으로 분리
- 제품 상세 페이지 자동 생성
- 모바일 대응 CSS 작성

초기 페이지:

- `/`
- `/company/`
- `/products/`
- `/products/[id]/`
- `/technology/`
- `/support/`

### 구버전 자산 선별 복사

복사 대상:

- 로고
- 메인 대표 이미지
- 제품 카드 이미지
- 제품 상세 이미지
- PDF/ZIP 다운로드 파일

복사 위치:

```text
site/public/images/
site/public/downloads/
```

### 제품 데이터화

`site/src/data/products.json` 작성.

공개 제품:

- CELL JIG
- OVEN
- DIGITAL PRESS
- AMPOULE FURNACE
- Thermal Analysis System
- TBS System

비공개 보관 제품:

- RTP SYSTEM
- SUBSTRATE HEATER

### 테스트 서버 배포

테스트 서버 경로:

```text
\\192.168.0.9\web\teraleaderHomePage
```

테스트 URL:

```text
https://teraleader.synology.me:50081/
```

초기 배포 후 응답 확인:

- `/`
- `/products/`
- `/products/cell-jig/`

### 화면/데이터 개선

반영 내용:

- 메인 hero 정보 보강
- 제품 카드에 순번, subtitle, category, tags 표시
- 제품 상세 페이지에 태그와 문의 버튼 추가
- 구버전 상세 페이지 기준으로 제품 사양 보강
- 문의/A/S 페이지에 이메일 문의 흐름 추가

### 공지사항 정적 페이지 추가

추가 페이지:

- `/notices/`
- `/notices/[id]/`

메인 공지사항 카드가 상세 페이지로 연결되도록 변경.

### 기본 정적 사이트 요소 추가

추가 항목:

- `404.html`
- `favicon.svg`
- `robots.txt`
- `sitemap.xml`
- Open Graph/Twitter meta

### 검증/배포 스크립트 추가

추가 파일:

- `site/scripts/validate-content.mjs`
- `site/scripts/deploy-test.mjs`

추가 명령:

```bash
npm run validate
npm run build
npm run deploy:test
```

### 로컬 전용 관리 툴 1차 구현

위치:

```text
tools/content-manager
```

실행 주소:

```text
http://127.0.0.1:5081/
```

기능:

- 제품 데이터 편집
- 제품 추가/삭제
- 공지사항 편집
- 공지사항 추가/삭제
- 회사 기본정보 편집
- 검증 실행
- 빌드 실행
- 테스트 배포 실행
- 제품 상세 이미지 업로드
- 제품 카드 이미지 업로드
- 제품 다운로드 파일 업로드

### 로고 링크 문제 수정

문제:

- 로고 링크가 `href="/"`로 되어 있어 서버 기본 문서/프록시 설정에 따라 루트 이동이 애매할 수 있음

수정:

- 로고 링크를 `/index.html`로 변경
- 상단 홈 메뉴도 `/index.html`로 변경
- 404 페이지의 홈 링크도 `/index.html`로 변경

### 제품 상세 이미지 정리

요청:

- 제품 상세 대표 이미지에서 글자 부분을 제거하고 제품 형상만 남기기

작업:

- 원본 이미지는 유지
- 상세 페이지용 `*-clean.png` 이미지 생성
- 제품 상세 페이지는 clean 이미지 사용
- 제품 목록 카드는 기존 배너형 이미지 유지

생성 이미지:

- `cell-jig-clean.png`
- `oven-clean.png`
- `digital-press-clean.png`
- `ampoule-furnace-clean.png`
- `thermal-analysis-system-clean.png`
- `tbs-system-clean.png`

## 주요 백업 이력

테스트 서버 배포 시 기존 파일은 백업 폴더로 이동했다.

예:

```text
\\192.168.0.9\web\teraleaderHomePage_backup_20260429_235512
\\192.168.0.9\web\teraleaderHomePage_backup_20260430_000017
\\192.168.0.9\web\teraleaderHomePage_backup_20260430_001250
\\192.168.0.9\web\teraleaderHomePage_backup_20260430_084634
\\192.168.0.9\web\teraleaderHomePage_backup_20260430_091614
```

## 현재 검증 상태

마지막 확인 기준:

- `npm run validate`: 성공
- `npm run build`: 성공
- `npm run deploy:test`: 성공
- 테스트 서버 주요 페이지 응답: `200 OK`

