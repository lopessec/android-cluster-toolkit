#!/usr/bin/env ruby

#
# Android Cluster Toolkit
#
# list.rb - list which android devices are plugged in ($devices and adb_devices)
#
# (c) 2012-2014 Joshua J. Drake (jduck)
#

bfn = __FILE__
while File.symlink?(bfn)
  bfn = File.expand_path(File.readlink(bfn), File.dirname(bfn))
end
$:.unshift(File.join(File.dirname(bfn), 'lib'))

require 'madb'


# load current devices
require 'devices'
$stderr.puts "[*] Loaded #{$devices.length} device#{plural($devices.length)} from 'devices.rb'"

# get a list of devices via 'adb devices'
adb_devices = adb_scan()
$stderr.puts "[*] Found #{adb_devices.length} device#{plural(adb_devices.length)} via 'adb devices'"

# show devices in both sets
$verbose = true
$devices.each { |dev|
  adb_devices.each { |ser|
    if dev[:serial] == ser
      puts "[*] #{dev[:name]} / #{dev[:serial]}"
      break
    end
  }
}

