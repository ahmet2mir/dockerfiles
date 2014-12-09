server {
    listen 80;
    listen 443 default ssl;
    server_name {{SERVER_NAME}};

    ssl_certificate    /webapps/ssl/{{SERVER_NAME}}.crt;
    ssl_certificate_key /webapps/ssl/{{SERVER_NAME}}.key;
    ssl_session_timeout 5m;
    ssl_protocols SSLv3 TLSv1;
    ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP;
    ssl_prefer_server_ciphers on;

    access_log  /webapps/logs/{{SERVER_NAME}}.access.log;
    error_log  /webapps/logs/{{SERVER_NAME}}.error.log;

    if ($request_method !~ ^(GET|HEAD|POST)$ ) {
        return 444;
    }

    include /webapps/sites/{{SERVER_NAME}}/*.conf;
    include /webapps/sites/{{SERVER_NAME}}/root;
}
