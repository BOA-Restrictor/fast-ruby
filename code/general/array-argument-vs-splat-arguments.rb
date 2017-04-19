require "benchmark/ips"

module M
  ITEMS = (1..10000).to_a.freeze
  REALISTIC_ITEMS = (1..6).to_a.freeze

  def self.func(*args)
  end
end

def fast
  M.func(M::ITEMS)
end

def slow
  M.func(*M::ITEMS)
end

def realistic_fast
  M.func(M::REALISTIC_ITEMS)
end

def realistic_slow
  M.func(*M::REALISTIC_ITEMS)
end

def realistic_static_arguments
  M.func(1, 2, 3, 4, 5, 6)
end

Benchmark.ips do |x|
  x.report("Function with single Array argument") { fast }
  x.report("Function with splat arguments") { slow }
  x.report("Function with realistic single Array argument") { realistic_fast }
  x.report("Function with realistic splat arguments") { realistic_slow }
  x.report("Function with realistic static arguments") { realistic_static_arguments }
  x.compare!
end
