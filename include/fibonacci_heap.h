#ifndef FIBONACCI_HEAP_H
#define FIBONACCI_HEAP_H

#include <stddef.h>
#include <stdbool.h>

typedef struct FibNode {
    int key;
    int degree;
    bool mark;
    struct FibNode *parent, *child, *left, *right;
} FibNode;

typedef struct FibHeap {
    FibNode *min;
    size_t n;
} FibHeap;

FibHeap* fib_create(void);
void fib_insert(FibHeap *h, int key);
void fib_destroy(FibHeap *h);

#endif
