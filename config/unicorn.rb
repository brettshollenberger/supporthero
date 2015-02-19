SUPPORT_HERO_APP_ROOT = ENV["SUPPORT_HERO_APP_ROOT"]

working_directory SUPPORT_HERO_APP_ROOT

pid File.join(SUPPORT_HERO_APP_ROOT, "pids/unicorn.pid")

stderr_path File.join(SUPPORT_HERO_APP_ROOT, "log/unicorn.stderr")
stdout_path File.join(SUPPORT_HERO_APP_ROOT, "log/unicorn.stdout")

# Unicorn socket
listen "/tmp/unicorn.supporthero.sock"
listen "/tmp/unicorn.myapp.sock"

worker_processes 4

timeout 30
