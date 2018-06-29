require 'ffi'

module HelloCLib
  extend FFI::Library

  ffi_lib './lib/libhello.so'

  attach_function :hello, [], :int
end

HelloCLib.hello
