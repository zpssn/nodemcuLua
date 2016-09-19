wifi.setmode(wifi.SOFTAP)

cfg={}
cfg.ssid="LoraReceive"
cfg.pwd="56781234"

cfg.ip="192.168.0.1"
cfg.netmask="255.255.255.0"
cfg.gateway="192.168.0.1"

port = 9876

--wifi.ap.setip(cfg)
wifi.ap.config(cfg)


tmr.alarm(0,1000,0,function()

    uart.setup(0, 115200, 8, 0, 1, 0)

    srv=net.createServer(net.TCP, 28800)
    srv:listen(port,function(conn)

        uart.on("data", function( data)
        local Str1 = data
      
            if(string.sub(Str1,0,9) == "heartbeat") then

            else
            conn:send( data);
        end
        end, 0)

        conn:on("receive",function(conn,payload)
        local Str = payload
  
        if(string.sub(Str,0,9) == "heartbeat") then

        else
          uart.write(0, payload)
        end

        end)

        conn:on("disconnection",function(c)
            uart.on("data")
        end)

    end)
end)
