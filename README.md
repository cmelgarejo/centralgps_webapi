# CentralGPSWebAPI

This is the API server that will be internal for any website to consume inside the server scope

Built in Elixir & phoenixframework

Example on deploying RELEASE:

user@track:/home/centralgps/server/centralgps_webapi# rm -rf _build/prod && rm -rf rel/&& MIX_ENV=prod mix do compile, phoenix.digest, release && /usr/bin/central_g_p_s_web_a_p_i/bin/central_g_p_s_web_a_p_i stop  && rm -rf /usr/bin/central_g_p_s_web_a_p_i/ && cp rel/central_g_p_s_web_a_p_i /usr/bin -r && chown centralgps:centralgps /usr/bin/central_g_p_s_web_a_p_i/ -hR && /usr/bin/central_g_p_s_web_a_p_i/bin/central_g_p_s_web_a_p_i start
