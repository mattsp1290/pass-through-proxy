require "toml"

module Pass::Through::Proxy
  class Port
  end

  VERSION = "0.1.0"
  ports = Array(Port).new
  counter = 0
  while true
    if ENV.includes? "PORT_" + counter.to_s
      port = ENV["PORT_" + counter.to_s]
      puts "Port for " + counter.to_s
      puts port
    else
      break unless counter == 0
    end
    counter += 1
  end

  toml_string = %(
    title = "TOML Example"

    [owner]
    name = "Lance Uppercut"
    dob = 1979-05-27T07:32:00Z
  )

  toml = TOML.parse(toml_string)
  puts toml["title"] #=> "TOML Example"
end
