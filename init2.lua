wifi.setmode(wifi.STATION)
wifi.sta.config('kiss-wrt', '56781234')
wifi.sta.connect()
local HOST = "192.168.0.109"
tmr.alarm(1,5000,1,function() 
  srv = net.createConnection(net.TCP, 0)
  srv:connect(6969,HOST)
  end)
tmr.alarm(0,1000,1,function() 
    uart.setup(0, 9600, 8, 0, 1, 0)
        srv:on("receive", function(sck, c)
          tmr.stop(1)
          print(c)
          uart.write(0, c)
        end)
        uart.on("data", function(data)

        srv:on("connection", function(sck, c)
          print(data)
          sck:send(data)
        end)
        end, 0)

        srv:on("disconnection",function(c)

        end)


end)
