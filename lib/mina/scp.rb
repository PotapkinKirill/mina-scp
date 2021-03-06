def scp_transfer(direction, from, to, options = {})
  remote_prefix = fetch(:domain) + ":"
  remote_prefix = fetch(:user) + "@#{remote_prefix}"
  command = "scp"
  command << " -P " + fetch(:port)
  command << " -r" if options[:recursively]
  case direction
  when :up   then to   = remote_prefix + to
  when :down then from = remote_prefix + from
  end
  command << " #{from} #{to}"
  print_command command if options[:verbose]
  result = %x[#{command}]
  puts result unless result == ""
end

def scp_download(from, to, options = {})
  scp_transfer(:down, from, to, options)
end

def scp_upload(from, to, options = {})
  scp_transfer(:up, from, to, options)
end
