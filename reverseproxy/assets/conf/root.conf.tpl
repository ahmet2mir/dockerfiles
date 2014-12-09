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


