# -*- coding: utf-8; -*-
# Author::    kgws  (http://d.hatena.ne.jp/kgws/)
# Copyright:: Copyright (c) 2010- kgws.
# License::   This program is licenced under the same licence as kgws.
#
# $--- flare-stats - [ by Ruby ] $
# vim: foldmethod=marker tabstop=2 shiftwidth=2
require 'flare/tools'

module FlareTools
class Stats < Core
  # {{{ constractor
  def initialize()
    # {{{ @format
    @format = "%20.20s:%5.5s"   # hostname:port
    @format += " %6s"           # state
    @format += " %6s"           # role
    @format += " %9s"           # partition
    @format += " %7s"           # balance
    @format += " %8.8s"         # items
    @format += " %4s"           # connection
    @format += " %6.6s"         # behind
    @format += " %3.3s"         # hit
    @format += " %4.4s"         # size
    @format += " %6.6s"         # uptime
    @format += " %7s"           # version
    @format += "\n"
    # }}}
    # {{{ @label
    @label = @format % [
      "hostname",
      "port",
      "state",
      "role",
      "partition",
      "balance",
      "items",
      "conn",
      "behind",
      "hit",
      "size",
      "uptime",
      "version",
    ]
    # }}}
    super
  end
  # }}}
  # {{{ option_on
  def option_on
    super
    @option.on(             '--index-server=[HOSTNAME]',          "index server hostname(default:#{@index_server_hostname})") {|v| @index_server_hostname = v}
    @option.on(             '--index-server-port=[PORT]',         "index server port(default:#{@index_server_port})") {|v| @index_server_port = v.to_i}
  end
  # }}}
  # {{{ sort_node
  def sort_node(nodes)
    # sort partition role hostname
    nodes.sort_by{|key, val| [val['partition'], val['role'], key]}
  end
  # }}}
  # {{{ execute
  def execute
    str = ""
    nodes = self.get_stats_nodes
    nodes = self.sort_node(nodes)
    threads  = self.get_stats_threads
    nodes.each do |hostname_port,data|
      ipaddr, port = hostname_port.split(":", 2)
      begin
        hostname = Resolv.getname(ipaddr).to_s
      rescue Resolv::ResolvError
        hostname = ipaddr
      end
      stats = self.get_stats(ipaddr, data['port'])
      partition = data['partition'] == "-1" ? "-" : data['partition']
      behind = threads[hostname_port].key?('behind') ? threads[hostname_port]['behind'] : "-"
      uptime = self.str_date(stats['uptime'])
      hit_rate = stats['cmd_get'] == "0" ?  "-" : (stats['get_hits'].to_f / stats['cmd_get'].to_f * 100.0).round
      size =  stats['bytes'] == "0" ? "-" : (stats['bytes'].to_i / 1024 / 1024 / 1024)
      str += @format % [
        hostname,
        port,
        data['state'],
        data['role'],
        partition,
        data['balance'],
        stats['curr_items'],
        stats['curr_connections'],
        behind,
        hit_rate,
        size,
        uptime,
        stats["version"],
      ]
    end
    puts @label + str
  end
  # }}}
end
end
