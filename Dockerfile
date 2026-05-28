# MySQL의 최신 이미지를 기반으로 사용
FROM mariadb:10.6

# 환경 변수 설정 (MySQL 초기화)
ENV MYSQL_ROOT_PASSWORD=root
# ENV MYSQL_DATABASE=my_database
# ENV MYSQL_USER=my_user
# ENV MYSQL_PASSWORD=my_password

# 초기화 스크립트 파일을 컨테이너의 /docker-entrypoint-initdb.d 디렉토리로 복사
COPY ./init.sql /docker-entrypoint-initdb.d

# 컨테이너가 시작될 때 SQL 파일을 실행하여 데이터베이스 초기화
# (이 과정은 Docker가 자동으로 처리)
