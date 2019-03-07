https://ironscripter.us/iron-scripter-2019-is-coming/

The Challenge

The Get-Counter cmdlet is very useful in obtaining performance counter information. Unfortunately, the Chairman feels the
output is less than friendly. Especially if you wish to consume the output such as with additional filtering, exporting
to a json file or writing to a database.

Your challenge is to create a PowerShell function that takes the output from Get-Counter and transforms it into a more
user friendly object. Each counter sample should be a separate object with these properties:

    Timestamp
    Computername
    CounterSet
    Counter
    Value

You are free to use whatever property names you want as long as it is clear what the values represent.

A sample might look like this:

    PS C:\> Get-Counter -computername server01 | MyFunction

    Datetime    : 2/6/2019 1:34:30 PM
    Computername: SERVER01
    Counterset  : memory
    Counter     : cache faults/sec
    Value       : 0

    Datetime    : 2/6/2019 1:34:30 PM
    Computername: SERVER01
    Counterset  : physicaldisk(_total)
    Counter     : % disk time
    Value       : 5.63389896275325

    PS C:\> Get-Counter -computername server01 | MyFunction

    Datetime    : 2/6/2019 1:34:30 PM
    Computername: SERVER01
    Counterset  : memory
    Counter     : cache faults/sec
    Value       : 0

    Datetime    : 2/6/2019 1:34:30 PM
    Computername: SERVER01
    Counterset  : physicaldisk(_total)
    Counter     : % disk time
    Value       : 5.63389896275325


Advanced Challenge

If you want to really challenge yourself, define a custom type and format view that gives you a result like this:


    PS C:\> get-counter -computername server01 | myfunction

    Timestamp: 2/6/2019 4:51:34 PM

    Computername Counterset                                                  Counter                              Value
    ------------ ----------                                                  -------                              -----
    SERVER01     network interface(intel[r] ethernet connection [2] i219-lm) bytes total/sec            63.933330323139
    SERVER01     processor(_total)                                           % processor time          2.29286092227079
    SERVER01     memory                                                      % committed bytes in use  58.2262708009747
    SERVER01     memory                                                      cache faults/sec          9.98958286299047
    SERVER01     physicaldisk(_total)                                        % disk time               0.06629201377444
    SERVER01     physicaldisk(_total)                                        current disk queue length                0