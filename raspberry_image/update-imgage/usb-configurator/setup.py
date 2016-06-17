#!/usr/bin/env python2.7
import sys
import os
from ConfigParser import ConfigParser

WPA_SUPPLICANT_CONFIG = "/etc/wpa_supplicant/wpa_supplicant.conf"
SETUP_CONFIG_TMPL = "{}/pi.conf"

def read_wpaconfig_and_strip_networks():
   with open(WPA_SUPPLICANT_CONFIG) as f:
      config = f.read()
      in_block = False
      lines = []
      for line in config.split("\n"):
         line = line.strip()
         if line.startswith("#"):
            continue
         if line == "network={" and not in_block:
            in_block = True
         if in_block:
            if line == "}":
               in_block = False
         else:
            lines.append(line);
      return lines

def create_network_section(ssid, psk):
   return ["network={",
           "\tssid=\"{}\"".format(ssid),
           "\tpsk=\"{}\"".format(psk),
           "}"]

def read_setup_config(mnt):
   config_file = SETUP_CONFIG_TMPL.format(mnt)
   print("Looking for config: {}".format(config_file))
   config = ConfigParser()
   if os.path.exists(config_file):
      print("Parsing config: {}".format(config_file))
      config.read(config_file)
   return config

def update_hostname(hostname):
   print("Updating hostname to: {}".format(hostname))
   old_hostname = open("/etc/hostname").read().strip()
   open("/etc/hostname", "w").write("{}\n".format(hostname))
   hosts = open("/etc/hosts").read()
   open("/etc/hosts", "w").write(hosts.replace(old_hostname, hostname))

def setup(dev, mnt, label):
   changed = False
   config = read_setup_config(mnt)
   if config.has_option("pi", "ssid") and config.has_option("pi", "psk"):
      print("Configuring network")
      header = read_wpaconfig_and_strip_networks()
      network = create_network_section(config.get("pi", "ssid"),
                                       config.get("pi", "psk"))
      with open(WPA_SUPPLICANT_CONFIG, "w") as f:
         print("Writing network configuration")
         f.write("\n".join(header + network))
         changed = True
   if config.has_option("pi", "hostname"):
      update_hostname(config.get("pi", "hostname"))
      changed = True
   return changed

def poweroff():
   print("Powering off")
   os.system("poweroff")

def main():
   if len(sys.argv) != 4:
      print("invalid number of arguments")
      sys.exit(1)
   dev = sys.argv[1]
   mnt = sys.argv[2]
   label = sys.argv[3]
   if setup(dev, mnt, label):
      poweroff()

if __name__ == "__main__":
   main()
