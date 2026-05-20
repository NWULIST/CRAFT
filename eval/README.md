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

1. Fill in `config.yaml` at the repo root (`paths.craft_model`, `paths.eval_output`,
   and optionally `credentials.openai_api_key`).
2. Run:

```bash
bash eval/jailbreakbench/jbb_qwen.sh
```

The script writes per-prompt responses (including the `<think>...</think>`
reasoning trace) to `<eval_output>/jailbreakbench/responses.json`.
The StrongReject pass below can score both the final answer and the
reasoning trace from that file.

### StrongReject autograder

We use the upstream [StrongReject](https://github.com/dsbowen/strong_reject) autograder to score model responses generated against JailbreakBench prompts. Install the library, then call its evaluator on your model's responses:

```python
from strongreject.evaluate import evaluate
# responses: list of {"forbidden_prompt": str, "response": str}
scores = [evaluate(r["forbidden_prompt"], r["response"]) for r in responses]
```

See `eval/strongreject/strongreject/` for the vendored copy of the library and `eval/strongreject/strongreject_dataset/` for the small evaluation set.

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
