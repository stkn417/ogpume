
@path = "/home/ec2-user/sinatra/ogpume/"

worker_processes 1
working_directory @path
timeout 300
listen '/tmp/ogpume.sock'
pid "#{@path}tmp/pids/unicorn.pid"

stderr_path "#{@path}log/unicorn.stderr.log"
stdout_path "#{@path}log/unicorn.stdout.log"
preload_app true
