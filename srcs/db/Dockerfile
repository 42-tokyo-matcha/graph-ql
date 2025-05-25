FROM mysql:9.3.0

# init.sql をコンテナの初期化スクリプトディレクトリにコピー
COPY init.sql /docker-entrypoint-initdb.d/


# CMD ["mysql"]
CMD ["mysqld"]
