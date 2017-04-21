# frozen_string_literal: true

require 'benchmark/ips'

class M
  def self.call
    default
  end

  def self.default
  end
end

class N
  def self.call
    respond_to?(:default) ? default : nil
  end
end

def fast
  M.call
end

def slow
  N.call
end

Benchmark.ips do |x|
  x.report('Default Method')   { fast }
  x.report('Respond to') { slow }
  x.compare!
end
