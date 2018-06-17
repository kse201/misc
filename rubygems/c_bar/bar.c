#include "ruby.h"

static VALUE fbar_len(VALUE self, VALUE arg) {
    return rb_funcall(arg, rb_intern("size"), 0, 0);
}

void Init_bar(void) {
    VALUE cBar = rb_define_class("Bar", rb_cObject);

    rb_define_method(cBar, "len", fbar_len, 1);
}

