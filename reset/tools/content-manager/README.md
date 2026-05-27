# TeraLeader Content Manager

로컬 전용 콘텐츠 관리 도구입니다. 운영 서버에는 업로드하지 않습니다.

## 실행

```bash
cd tools/content-manager
npm start
```

브라우저에서 `http://127.0.0.1:5081/`을 엽니다.

## 기능

- 제품 데이터 편집
- 공지사항 편집
- 회사 정보 편집
- 제품 상세 이미지 업로드
- 제품 카드 이미지 업로드
- 제품 다운로드 파일 업로드
- 콘텐츠 검증
- 정적 사이트 빌드
- 테스트 서버 배포

## 저장 위치

이 도구는 다음 파일을 직접 수정합니다.

- `site/src/data/products.json`
- `site/src/data/notices.json`
- `site/src/data/company.json`

## 파일 업로드

제품 편집 화면의 파일 업로드 영역에서 파일을 선택한 뒤 반영 버튼을 누릅니다.

- 상세 이미지: `site/public/images/products/`에 복사되고 `image`에 반영됩니다.
- 카드 이미지: `site/public/images/products/`에 복사되고 `cardImage`에 반영됩니다.
- 다운로드 파일: `site/public/downloads/`에 복사되고 `downloads`에 추가됩니다.

파일 반영 후에는 반드시 `제품 저장`을 눌러 데이터 파일에 저장해야 합니다.

## 주의

이 도구는 로컬 전용입니다. 외부 서버에 업로드하지 않습니다.
