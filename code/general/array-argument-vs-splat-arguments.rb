require "benchmark/ips"

module M
  ITEMS = (1..10000).to_a.freeze
  REALISTIC_ITEMS = (1..6).to_a.freeze

  def self.func(*args)
  end

  def self.array_func(args)
  end

  def self.array_wrap(args)
    args.is_a?(Array) ? args : [args]
  end
end

# NOTE: will double wrap array
def array
  M.func(M::ITEMS)
end

def splat
  M.func(*M::ITEMS)
end

# NOTE: will double wrap array
def realistic_array
  M.func(M::REALISTIC_ITEMS)
end

def realistic_splat
  M.func(*M::REALISTIC_ITEMS)
end

def realistic_static
  M.func(1, 2, 3, 4, 5, 6)
end

def realistic_manual
  M.func(M::ITEMS[0], M::ITEMS[1], M::ITEMS[2], M::ITEMS[3], M::ITEMS[4], M::ITEMS[5])
end

# NOTE: will double wrap array
def realistic_static_array
  M.func([1, 2, 3, 4, 5, 6])
end

def no_splat_array
  M.array_func(M::ITEMS)
end

def realistic_no_splat_array
  M.array_func(M::REALISTIC_ITEMS)
end

def realistic_no_splat_static_array
  M.array_func([1, 2, 3, 4, 5, 6])
end

def realistic_array_wrap
  M.array_wrap(M::ITEMS)
end

def realistic_array_wrap_static
  M.array_wrap(M::ITEMS)
end

Benchmark.ips do |x|
  x.report("Function with array argument") { array }
  x.report("Function with splat arguments") { splat }
  x.report("Function with realistic array argument") { realistic_array }
  x.report("Function with realistic splat arguments") { realistic_splat }
  x.report("Function with realistic static arguments") { realistic_static }
  x.report("Function with realistic manual arguments") { realistic_manual }
  x.report("Function with realistic static array arguments") { realistic_static_array }
  x.report("Function with no splat array arguments") { no_splat_array }
  x.report("Function with realistic no splat array arguments") { realistic_no_splat_array }
  x.report("Function with realistic no splat static array arguments") { realistic_no_splat_static_array }
  x.report("Function with realistic array wrap arguments") { realistic_array_wrap }
  x.report("Function with realistic array wrap static arguments") { realistic_array_wrap_static }
  x.compare!
end
