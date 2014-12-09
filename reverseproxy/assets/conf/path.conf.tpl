location /{{SERVER_PATH}}/ {
    rewrite /{{SERVER_PATH}}(.*) $1 break;
    proxy_pass {{SERVER_PROTOCOL}}://{{SERVER_IP}}:{{SERVER_PORT}};
    proxy_redirect     off;
    proxy_set_header   Host             $host;
    proxy_set_header   X-Real-IP        $remote_addr;
    proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
}

location ~* ^/{{SERVER_PATH}}/(.*)\.(swf|jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|txt|tar|mid|midi|wav|bmp|rtf|js)$ {    rewrite /{{SERVER_PATH}}(.*) $1 break;
    proxy_pass {{SERVER_PROTOCOL}}://{{SERVER_IP}}:{{SERVER_PORT}};
    proxy_redirect     off;
    proxy_cache cache;
    proxy_cache_valid 2d;
    expires max;
}


