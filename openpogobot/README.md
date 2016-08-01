Docker OpenPogo image
=====================

This is an Alpine Linux based image with [OpenPoGoBot -  A PokemonGo Python bot](https://github.com/OpenPoGo/OpenPoGoBot).

Quickstart
----------
    
    docker run -d --name openpogobot ahmet2mir/openpogobot [flags]

`flags` are pokecli args located at https://github.com/OpenPoGo/OpenPoGoBot#flags

Example

    docker run -d --name openpogobot ahmet2mir/openpogobot -a google -u tejado -p 1234 --location "New York, Washington Square"

If you wan't to use a config file use `-v` docker arg to mount volume and `--config` pokecli args. See [logs](#logs) for pokecli output

Example
    
    docker run -d --name openpogobot -v /path/to/config/folder:/apps ahmet2mir/openpogobot --config-json /apps/config.json -cp 1000 -iv 0.7

If you need to enter in the container, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it openpogobot bash

### Logs

Output are in docker log collect 
    
    docker logs -f openpogobot

    {'auth_service': 'google', 'walk': 2.5, 'google_directions': None, 'pokemon_potential': 0.4, 'cp': 100, 'json': None, 'location': 'New York, Washington Square', 'test': False, 'item_filter': {1: {'keep': 100}, 101: {'keep': 0}, 102: {'keep': 0}, 103: {'keep': 10}, 104: {'keep': 10}, 201: {'keep': 10}, 202: {'keep': 10}}, 'username': 'tejado', 'gmapkey': None, 'initial_transfer': False, 'recycle_items': False, 'location_cache': False, 'ign_init_trans': '', 'exclude_plugins': [''], 'fill_incubators': None, 'password': '1234', 'use_all_incubators': None, 'distance_unit': 'km', 'mode': 'all', 'debug': False, 'max_steps': 50}
    [2016-08-01 13:43:46] [x] PokemonGO Bot v1.0
    [2016-08-01 13:43:46] [x] Configuration initialized
    [2016-08-01 13:43:46] [Plugins] Loaded plugin "web".
    [2016-08-01 13:43:46] [Plugins] Loaded plugin "recycle_items".
    [2016-08-01 13:43:46] [Plugins] Loaded plugin "transfer_pokemon".
    [2016-08-01 13:43:46] [Plugins] Loaded plugin "catch_pokemon".
    [2016-08-01 13:43:46] [Plugins] Loaded plugin "spin_pokestop".
    [2016-08-01 13:43:46] [Plugins] Plugins loaded: ['catch_pokemon', 'recycle_items', 'spin_pokestop', 'transfer_pokemon', 'web']
    [2016-08-01 13:43:46] [Events] Events available: ['item_bag_full', 'logging', 'pokemon_bag_full', 'pokemon_found', 'pokestop_arrived', 'pokestop_found', 'transfer_pokemon']
    [2016-08-01 13:43:46] [x] Fetching altitude from google
    [2016-08-01 13:43:46] [x] Location was not Lat/Lng.
    [2016-08-01 13:43:46] 
    [2016-08-01 13:43:46] [x] Address found: New York, Washington Square
    ...

-f like tail -f

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
