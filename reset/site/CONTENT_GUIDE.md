# TeraLeader Site Content Guide

이 폴더는 새 정적 홈페이지의 작업 공간입니다. 운영 서버에는 `dist` 폴더의 결과물만 업로드합니다.

## 주요 데이터 파일

- `src/data/products.json`: 제품 목록, 상세 설명, 사양, 다운로드 파일
- `src/data/company.json`: 회사 정보, 주소, 연락처, 연혁, 기술 정보
- `src/data/notices.json`: 공지사항

## 제품 노출 제어

`products.json`에서 `visible` 값을 조정합니다.

```json
{
  "id": "cell-jig",
  "visible": true
}
```

- `true`: 홈페이지에 노출
- `false`: 데이터는 보관하지만 홈페이지에는 숨김

## 제품 필드

- `id`: URL에 쓰이는 고유값입니다. 예: `/products/cell-jig/`
- `visible`: 공개 여부입니다.
- `status`: 내부 관리 상태입니다. 현재는 `active`, `hidden`을 사용합니다.
- `order`: 정렬 순서입니다.
- `name`, `subtitle`, `summary`, `description`: 화면에 표시되는 문구입니다.
- `tags`: 카드와 상세 페이지에 표시되는 키워드입니다.
- `image`: 상세 페이지 이미지입니다.
- `cardImage`: 목록 카드 이미지입니다.
- `features`: 특징 목록입니다.
- `specs`: 사양표입니다.
- `downloads`: 다운로드 버튼 목록입니다.
- `inquirySubject`: 제품 문의 메일 제목입니다.

## 빌드

```bash
npm run validate
npm run build
```

빌드 결과는 `dist/`에 생성됩니다.

## 테스트 서버 배포

테스트 서버에는 `dist/` 안의 파일만 복사합니다. `src/`, `node_modules/`, `admin/`, `api/`는 운영 서버에 올리지 않습니다.

```bash
npm run deploy:test
```

배포 스크립트는 기존 테스트 서버 파일을 `\\192.168.0.9\web\teraleaderHomePage_backup_YYYYMMDD_HHMMSS`로 이동한 뒤 `dist/`를 복사합니다.
