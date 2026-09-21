#!/usr/bin/env python3
"""Exercise 3 -- one task of a parameter sweep.

A job array runs this script ten times, once per config file, each writing its
own result:

    python run_sweep.py --config $INPUT --out results/result_${SLURM_ARRAY_TASK_ID}.csv

Every task is independent -- no communication, no shared state, no ordering.
That is what makes it a job array rather than an MPI job.

Config file format (see inputs/config_1.txt):

    # comments and blank lines are ignored
    param=17

Exactly one `param=` line, one integer value.

Output: a two-line CSV -- a header and one row.

    config_id,parameter,result
    7,53,3.141592653590

Standard library only.
"""

import argparse
import math
import os
import re
import sys

# How many terms of the series each task sums.  The count is scaled by the
# parameter, so tasks do visibly different amounts of work -- an array where
# every task takes exactly the same time hides the very thing (stragglers,
# uneven inputs) that makes array-job monitoring worth teaching.
BASE_ITERATIONS = 400_000


def read_parameter(path):
    """Return the integer value of the single `param=` line in `path`."""
    value = None
    with open(path) as handle:
        for lineno, raw in enumerate(handle, start=1):
            line = raw.split("#", 1)[0].strip()
            if not line:
                continue
            if "=" not in line:
                raise ValueError("%s:%d: expected key=value, got %r"
                                 % (path, lineno, raw.strip()))
            key, _, val = line.partition("=")
            key = key.strip()
            if key != "param":
                raise ValueError("%s:%d: unknown key %r (expected 'param')"
                                 % (path, lineno, key))
            if value is not None:
                raise ValueError("%s:%d: 'param' given more than once" % (path, lineno))
            value = int(val.strip())
    if value is None:
        raise ValueError("%s: no 'param=' line found" % path)
    return value


def config_id_from_path(path):
    """Pull the N out of .../config_N.txt; fall back to the bare stem."""
    stem = os.path.splitext(os.path.basename(path))[0]
    match = re.search(r"(\d+)$", stem)
    return match.group(1) if match else stem


def compute(parameter):
    """A deterministic, parameter-dependent calculation.

    Sums a Leibniz-style alternating series whose length and phase both depend
    on the parameter, so the ten configs produce ten visibly different numbers.
    Deterministic: the same config always gives the same result, which is what
    lets students check that nothing was overwritten by comparing files.
    """
    iterations = BASE_ITERATIONS * parameter
    total = 0.0
    for k in range(iterations):
        total += ((-1.0) ** k) / (2 * k + 1 + parameter)
    return total * math.sqrt(parameter)


def main():
    parser = argparse.ArgumentParser(
        description="Run one parameter-sweep task and write a one-row CSV."
    )
    parser.add_argument("--config", required=True, help="path to a config_N.txt file")
    parser.add_argument("--out", required=True, help="path of the CSV to write")
    args = parser.parse_args()

    try:
        parameter = read_parameter(args.config)
    except (OSError, ValueError) as exc:
        print("run_sweep: %s" % exc, file=sys.stderr)
        return 1

    config_id = config_id_from_path(args.config)
    result = compute(parameter)

    out_dir = os.path.dirname(args.out)
    if out_dir and not os.path.isdir(out_dir):
        print("run_sweep: output directory %r does not exist -- "
              "create it first (mkdir -p results)" % out_dir, file=sys.stderr)
        return 1

    with open(args.out, "w") as handle:
        handle.write("config_id,parameter,result\n")
        handle.write("%s,%d,%.12f\n" % (config_id, parameter, result))

    print("[run_sweep]  config=%s  parameter=%d  result=%.12f  -> %s"
          % (config_id, parameter, result, args.out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
