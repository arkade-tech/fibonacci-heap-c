#include "fibonacci_heap.h"
#include <stdlib.h>

FibHeap* fib_create(void) {
    return (FibHeap*)calloc(1, sizeof(FibHeap));
}

void fib_insert(FibHeap *h, int key) {
    FibNode *node = (FibNode*)calloc(1, sizeof(FibNode));
    node->key = key;
    node->left = node->right = node;

    if (!h->min) {
        h->min = node;
    } else {
        node->right = h->min;
        node->left = h->min->left;
        h->min->left->right = node;
        h->min->left = node;
        if (key < h->min->key) h->min = node;
    }
    h->n++;
}

static void free_nodes(FibNode *node) {
    if (!node) return;
    FibNode *curr = node;
    do {
        FibNode *next = curr->right;
        if (curr->child) free_nodes(curr->child);
        free(curr);
        curr = next;
    } while (curr != node);
}

void fib_destroy(FibHeap *h) {
    if (h) {
        if (h->min) free_nodes(h->min);
        free(h);
    }
}
