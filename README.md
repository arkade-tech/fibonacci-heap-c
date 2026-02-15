# Fibonacci Heap (C)

![C](https://img.shields.io/badge/language-C99-blue)
![Build](https://img.shields.io/badge/build-Makefile-green)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

A production-style implementation of a **Fibonacci Heap** in C, designed
with clean architecture, strict compiler settings, modular structure,
and professional build automation.

------------------------------------------------------------------------

## Overview

A **Fibonacci Heap** is an advanced priority queue supporting excellent
amortized performance for graph-heavy algorithms.

  Operation      Amortized Complexity
  -------------- ----------------------
  Insert         O(1)
  Find-Min       O(1)
  Decrease-Key   O(1)
  Union          O(1)
  Extract-Min    O(log n)
  Delete         O(log n)

This implementation includes: - Circular doubly-linked root list -
Cascading cuts - Lazy consolidation - Strict warning flags - Debug /
Release / Sanitized builds

------------------------------------------------------------------------

## Project Structure

    .
    ├── include/            # Public headers
    ├── src/                # Implementation files
    ├── build/              # Generated object files
    ├── bin/                # Generated binary
    ├── Makefile
    ├── build.sh
    └── README.md

------------------------------------------------------------------------

## Build Instructions

### Install Dependencies (Ubuntu 24.04)

``` bash
sudo apt update && sudo apt install -y build-essential make clang-format cppcheck valgrind
```

### Build (Debug - default)

``` bash
make
```

### Build (Release)

``` bash
make BUILD=release
```

### Sanitized Build (ASan + UBSan)

``` bash
make BUILD=sanitize
```

### Using build.sh

``` bash
./build.sh release
./build.sh sanitize --run
```

------------------------------------------------------------------------

## Compiler Settings

-   `-Wall -Wextra -Wpedantic`
-   `-Wshadow -Wformat=2`
-   Dependency auto-generation (`-MMD -MP`)
-   AddressSanitizer & UndefinedBehaviorSanitizer support

------------------------------------------------------------------------

## Example Usage

``` c
FibonacciHeap *heap = create_heap();

insert(heap, 10);
insert(heap, 5);
insert(heap, 20);

FibNode *min = extract_min(heap);
```

------------------------------------------------------------------------

## Tooling

### Static Analysis

``` bash
make lint
```

### Code Formatting

``` bash
make format
```

### Memory Checking

``` bash
valgrind ./bin/fibonacci_heap
```

------------------------------------------------------------------------

## When to Use Fibonacci Heap

Best suited for: - Dijkstra's Algorithm (dense graphs) - Prim's Minimum
Spanning Tree - Network optimization systems - Research and algorithmic
benchmarking

Note: Binary heaps may outperform in small datasets due to lower
constant factors.

------------------------------------------------------------------------

## Engineering Design Principles

-   Modular header/source separation
-   No global state
-   Clean memory ownership
-   Reproducible builds
-   CI-ready structure

------------------------------------------------------------------------

## Roadmap

-   Generic comparator-based implementation
-   Unit test harness
-   Benchmark suite vs Binary Heap
-   Thread-safe wrapper
-   Memory pool allocator

------------------------------------------------------------------------

## License

MIT License (recommended for academic and industrial use)

------------------------------------------------------------------------

## Author

Dr. Subhankar Ghosal\
Assistant Professor -- Theoretical Computer Science\
Center of Excellence in TCS
