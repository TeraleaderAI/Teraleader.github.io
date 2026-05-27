# TeraLeader Homepage Renewal Docs

테라리더 홈페이지 개편 작업 문서 모음입니다.

## 문서 구성

- [project-overview.md](./project-overview.md): 개편 작업 전체 개요, 기술 방향, 폴더 구조, 운영 원칙
- [work-history.md](./work-history.md): 현재까지 진행한 작업 이력
- [roadmap.md](./roadmap.md): 앞으로 진행할 예정 작업과 우선순위

## 현재 방향 요약

새 홈페이지는 DB와 ASP 의존을 제거하고, 정적 사이트로 운영합니다.

- 운영 서버: HTML/CSS/JS/이미지/PDF/ZIP 정적 파일만 배포
- 개발 방식: Astro 정적 빌드
- 콘텐츠 관리: JSON 데이터 파일 기반
- 내부 관리: 로컬 전용 콘텐츠 관리 툴
- 고객 문의/A/S: 게시판 대신 이메일 문의로 대체

