#include <stdio.h>
#include <string.h>

void hello() {
    printf("Hello C shared library\n");
    return;
}

int write_foo(char *str) {
    const char *f_str = "FOO by C shared library\n";
    memcpy(str,f_str, strlen(f_str));
    return strlen(str);
}
