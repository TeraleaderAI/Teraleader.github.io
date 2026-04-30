# Project Overview

## 목적

테라리더 구버전 홈페이지를 현대적인 정적 홈페이지로 개편한다.

기존 홈페이지는 ASP, MSSQL, Artyboard 게시판, 프레임/iframe, EUC-KR 기반으로 구성되어 있어 수정과 유지보수가 어렵다. 새 홈페이지는 모바일 대응, 다양한 화면비 대응, 제품 정보 업데이트 편의성, 단순한 배포 구조를 목표로 한다.

## 핵심 결정

### 1. DB 없이 정적 사이트로 운영

기존 구버전은 실제 MSSQL DB를 사용했다. 공지사항과 Q&A는 Artyboard 기반 게시판이었고, `notice`, `qanda` 게시판 ID를 통해 DB 데이터를 조회했다.

새 홈페이지에서는 DB를 사용하지 않는다.

- 공지사항은 정적 JSON 데이터로 관리
- 고객 문의와 A/S 접수는 이메일 문의로 대체
- 제품 정보는 JSON 데이터 파일로 관리
- 정적 빌드 결과물만 서버에 업로드

### 2. ASP 대신 Astro 사용

새 사이트는 Astro 기반 정적 사이트로 구성한다.

서버에서 Node.js를 실행하지 않는다. 개발 PC에서 `npm run build`로 정적 파일을 생성하고, 생성된 `dist/` 폴더만 서버에 배포한다.

운영 서버에는 다음만 올라간다.

- `.html`
- `.css`
- `.js`
- 이미지
- PDF/ZIP 다운로드 파일
- `robots.txt`
- `sitemap.xml`

### 3. 관리자 페이지는 운영 서버에 두지 않음

과거 개편 시도본에는 `admin`, `api`, `server.js`, PHP/ASP API, DB 설계가 섞여 있었다. 이 구조는 운영 서버에 관리자 기능이 노출되고 유지보수 부담이 커진다.

새 방향은 로컬 전용 관리 툴이다.

- 내부 PC에서만 `http://127.0.0.1:5081/`로 실행
- 제품/공지/회사 JSON 데이터 수정
- 이미지/PDF/ZIP 파일 업로드
- 검증/빌드/테스트 배포 실행
- 운영 서버에는 업로드하지 않음

## 현재 폴더 구조

```text
NewTeraleaderPageByVSCODE/
  docs/
    README.md
    project-overview.md
    work-history.md
    roadmap.md

  old_src/
    wwwhome/
      구버전 ASP 홈페이지 원본 보관

  site/
    Astro 정적 홈페이지

  tools/
    content-manager/
      로컬 전용 콘텐츠 관리 툴

  src/
    과거 초안. 현재 메인 작업 대상 아님

  작업지시관련/
    초기 레이아웃 참고 이미지
```

## 새 사이트 구조

```text
site/
  src/
    components/
      ProductCard.astro
    data/
      company.json
      notices.json
      products.json
    layouts/
      BaseLayout.astro
    pages/
      index.astro
      company.astro
      technology.astro
      support.astro
      404.astro
      sitemap.xml.js
      notices/
      products/
    styles/
      global.css

  public/
    downloads/
    images/
    favicon.svg
    robots.txt

  scripts/
    validate-content.mjs
    deploy-test.mjs

  dist/
    빌드 결과물. 서버 업로드 대상
```

## 주요 데이터 파일

### `site/src/data/products.json`

제품 정보 원본이다.

주요 필드:

- `id`: 제품 URL에 쓰이는 고유 ID
- `visible`: 홈페이지 노출 여부
- `status`: 내부 관리 상태
- `order`: 정렬 순서
- `name`: 제품명
- `subtitle`: 보조 문구
- `category`: 제품 분류
- `tags`: 제품 키워드
- `summary`: 카드/목록 요약
- `description`: 상세 설명
- `image`: 상세 페이지 이미지
- `cardImage`: 목록 카드 이미지
- `features`: 특징 목록
- `specs`: 사양표
- `downloads`: 다운로드 파일 목록
- `inquirySubject`: 제품 문의 메일 제목

### `site/src/data/company.json`

회사 정보, 연락처, 연혁, 사업영역, 보유기술 정보를 관리한다.

### `site/src/data/notices.json`

정적 공지사항 목록과 상세 본문을 관리한다.

## 배포 흐름

```bash
cd site
npm run validate
npm run build
npm run deploy:test
```

### 명령 설명

- `npm run validate`: JSON 데이터와 파일 경로 검증
- `npm run build`: Astro 정적 빌드
- `npm run deploy:test`: 테스트 서버 `\\192.168.0.9\web\teraleaderHomePage`에 배포

테스트 서버 배포 시 기존 파일은 다음 형식으로 자동 백업된다.

```text
\\192.168.0.9\web\teraleaderHomePage_backup_YYYYMMDD_HHMMSS
```

## 테스트 URL

```text
https://teraleader.synology.me:50081/
```

## 운영 원칙

- `old_src/wwwhome`은 원본 보관용이며 직접 수정하지 않는다.
- 운영 서버에는 `site/dist` 결과물만 업로드한다.
- `tools/content-manager`는 로컬 전용이며 운영 서버에 올리지 않는다.
- DB 연결 정보, 관리자 코드, API 서버 코드는 운영 배포물에 포함하지 않는다.
- 제품 자료는 가능한 한 데이터 파일과 public 자산으로 관리한다.

