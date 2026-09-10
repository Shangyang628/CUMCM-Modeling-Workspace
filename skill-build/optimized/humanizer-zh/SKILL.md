---
name: humanizer-zh
description: Revise existing Chinese or mixed-language academic prose to reduce templated AI-like phrasing while preserving every technical fact. Use for language polishing, sentence rhythm, repetition, empty transitions, and restrained tone after substantive content exists; do not draft missing research, change evidence, or alter formulas and results.
---

# Humanizer ZH

Edit expression only. The purpose is readable, restrained academic prose, not evasion of detection systems.

## Immutable Content

Do not change data, numbers, formulas, definitions, variables, units, parameters, citations or their meaning, evidence strength, conclusions, uncertainty, table/figure references, or technical facts. Do not omit a weak result to improve tone.

## Editing Pass

- remove empty praise, vague significance claims, and unsupported causal language;
- replace mechanical “first/second/finally” patterns with logical transitions;
- vary sentence length without changing scope or modality;
- use concrete nouns and verbs instead of generic abstractions;
- merge repetition and split overloaded sentences;
- preserve necessary domain terms and qualifiers;
- compare the edited text against the source fact by fact.

If an apparent language problem is actually a factual contradiction, flag it instead of rewriting around it. If the user asks to create new scientific content, use an appropriate drafting skill first.

## Output

Provide the revised text and briefly list any ambiguity that prevented a safe edit. When editing a file, preserve a reviewable source or diff unless the user explicitly requests replacement.
