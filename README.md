# LSR worker

- 提供給LSR後台更新MSSQL資料庫 氣象站的ip


### 注意事項
1. 在/html/config.php設定sql server變數

        mssql_ip: SQL SERVER 的 ip
        mssql_port: SQL SERVER 監聽port
        mssql_user: 使用者帳號
        mssql_password: 使用者密碼
        mssql_database: 更新的database名稱

2. build docker image:

        docker build -t image_name .

3. boot docker container

        docker run -tid --name container_name -p 6680:80 image_name
        