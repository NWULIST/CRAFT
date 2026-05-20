# Advanced jailbreak robustness (paper §6.3, Fig. 4)

CRAFT is evaluated against two strong adaptive jailbreaks. We do not vendor
the attack code; the upstream repos below are the authoritative sources.

## GPTFuzzer

Repo: https://github.com/sherdencooper/GPTFuzz
Paper: Yu et al., *GPTFUZZER: Red Teaming Large Language Models with Auto-Generated Jailbreak Prompts*, 2024.

Reproduction:

```bash
git clone https://github.com/sherdencooper/GPTFuzz.git
cd GPTFuzz
# Use the default fuzzer config; point --target_model to the CRAFT checkpoint.
python gptfuzz.py --target_model <PATH_TO_CRAFT_CKPT> \
                  --judge openai \
                  --max_iters 100
```

Score with `eval/strongreject/StrongReject.py` on the produced attack log.

## AutoDAN

Repo: https://github.com/SheltonLiu-N/AutoDAN
Paper: Liu et al., *AutoDAN: Generating Stealthy Jailbreak Prompts on Aligned LLMs*, 2024.

Reproduction:

```bash
git clone https://github.com/SheltonLiu-N/AutoDAN.git
cd AutoDAN
python autodan_hga_eval.py --model <PATH_TO_CRAFT_CKPT>
```

Then score with StrongReject as above.

## What CRAFT reports (Fig. 4)

| Attack | Base + reasoning ASR | CRAFT + reasoning ASR | Base + final ASR | CRAFT + final ASR |
| --- | --- | --- | --- | --- |
| GPTFuzzer | 93.62 % | 27.96 % | 40.43 % | 4.00 % |
| AutoDAN | 94.17 % | 24.52 % | 60.28 % | 10.21 % |
