#include <stdio.h>
#include "fibonacci_heap.h"

int main() {
    printf("--- Fibonacci Heap: %s ---\n", "fibonacci_heap_c");
    FibHeap *h = fib_create();
    fib_insert(h, 10);
    fib_insert(h, 3);
    fib_insert(h, 15);
    if (h->min) printf("Current Minimum: %d\n", h->min->key);
    fib_destroy(h);
    return 0;
}
