# Evaluation

CRAFT is evaluated along two axes:

1. **Safety** (paper Table 1) — JailbreakBench and StrongReject. We report
   the StrongReject score on the final response **and** on the intermediate
   reasoning trace; the average of the two is the headline number.
2. **Reasoning capability** (paper Table 2) — AIME 2024, MATH-500, Minerva,
   LiveCodeBench. Run via each benchmark's official harness; we just point
   at the trained checkpoint.

## Safety

### JailbreakBench (final-response + reasoning safety)

```bash
# Replace MODEL_PATH with your CRAFT checkpoint (or HF id).
export MODEL_PATH=./checkpoints/qwen3_4b_thinking_craft/global_step_N/actor
bash jailbreakbench/jbb_qwen.sh "$MODEL_PATH"
```

`jbb_qwen.sh` runs JBB-Behaviors (harmful split). To score the reasoning
trace separately, pass `--target reasoning`. See `jailbreakbench/jbb_qwen.py`
flags.

### StrongReject

`eval/strongreject/` is a copy of [StrongReject](https://github.com/alexandrasouly/strongreject).
The headline score `P(S|y)` is produced by their GPT-4o evaluator; this
requires `OPENAI_API_KEY`.

```bash
export OPENAI_API_KEY="..."
python eval/strongreject/StrongReject.py --responses <your_jbb_responses.jsonl>
```

## Advanced jailbreak robustness (paper §6.3, Fig. 4)

See [`advanced_attacks.md`](advanced_attacks.md) for GPTFuzzer and AutoDAN
reproduction pointers (upstream code; we do not vendor it).

## Reasoning benchmarks (paper Table 2)

| Benchmark | Harness |
| --- | --- |
| AIME 2024 | https://github.com/openai/simple-evals |
| MATH-500 | https://github.com/hendrycks/math |
| Minerva | https://github.com/openai/prm800k |
| LiveCodeBench | https://github.com/LiveCodeBench/LiveCodeBench |

Each harness is run with default settings on the CRAFT checkpoint. We
report Pass@1.
