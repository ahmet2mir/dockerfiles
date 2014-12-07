server {

    listen 443 ssl;
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

    location / {
        proxy_pass {{SERVER_PROTOCOL}}://{{SERVER_IP}}:{{SERVER_PORT}}/;
        proxy_cache cache;
        proxy_cache_valid 12h;
        expires 12h;
        proxy_cache_use_stale error timeout invalid_header updating;
    }

    location ~* ^.+(swf|jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|txt|tar|mid|midi|wav|bmp|rtf|js)$ {
        proxy_pass {{SERVER_PROTOCOL}}://{{SERVER_IP}}:{{SERVER_PORT}};
        proxy_cache cache;
        proxy_cache_valid 2d;
        expires max;
    }

    location ~ ^/(piwik|admin) {
        return 418;
    }

}
