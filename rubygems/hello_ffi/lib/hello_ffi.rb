require 'ffi'

module HelloCLib
  extend FFI::Library

  ffi_lib './lib/libhello.so'

  attach_function :hello, [], :int
  attach_function :write_foo, [:pointer], :int
end

HelloCLib.hello

foo = FFI::MemoryPointer.new :pointer

length = HelloCLib.write_foo(foo)
p foo.read_string(length)
