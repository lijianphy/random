A random number generator library implementation in C featuring multiple algorithms including xoshiro256++ and xoshiro256**.

## Features

- Multiple RNG implementations:
  - xoshiro256++ (default)
  - xoshiro256**
  - SplitMix64
- Support for both integer and floating-point random numbers
- Normal distribution sampling using Box-Muller transform
- Parallel stream support via jump operations

## Building

Use make to build the project:

```sh
make
```

This will create the test executable 

```sh
test_random
```

## Usage

The RNG can be configured in `rng_config.h`. Default configuration uses xoshiro256++.

Basic example:

```c
#include <stdio.h>
#include "random.h"

int main(void)
{
    rng_t rng;
    set_seed(&rng, 1234 * 5678 * 31415926);
    for (int i = 0; i < 10; i++)
    {
        printf("%.10f\n", randu(&rng));
    }

// split the RNG into two independent RNGs
#if RNG_HAVE_JUMP
    rng_t rng2;
    split_rng(&rng, &rng2);
    printf("\nNew rng stream:\n");
    for (int i = 0; i < 10; i++)
    {
        printf("%.10f\n", randu(&rng2));
    }
#endif

    return 0;
}
```

## Parallel Streams

For parallel computations, you can split the RNG stream:

```c
rng_t rng1, rng2;
set_seed(&rng1, seed);
split_rng(&rng1, &rng2);  // rng1 and rng2 are now independent
```

## License

This code is released into the public domain.

## Credits

Based on work by [David Blackman and Sebastiano Vigna](https://prng.di.unimi.it).
