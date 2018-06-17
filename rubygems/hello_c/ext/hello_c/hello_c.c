#include "hello_c.h"

VALUE rb_mHelloC;

static VALUE fbar_len(VALUE self, VALUE arg) {
    printf("Hello world\n");
    return rb_funcall(arg, rb_intern("size"), 0, 0);
}

void
Init_hello_c(void)
{
  rb_mHelloC = rb_define_module("HelloC");
  rb_define_module_function(rb_mHelloC, "len", fbar_len, 1);
}
