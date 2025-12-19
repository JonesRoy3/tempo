# Tempo Crates Layout Overview

This document gives a high-level orientation for contributors working inside the `crates/` workspace.

It is **not** an exhaustive reference. Instead, it explains the common patterns you will encounter and how to navigate them.

## 1. General structure

The `crates/` directory contains the Rust workspace members that together implement the Tempo node:

- Core protocol and execution types (for example, primitives such as transactions and blocks).
- Consensus and networking components.
- Node configuration, storage, and RPC surface.
- Supporting utilities used by multiple parts of the system.

Each crate follows standard Rust conventions:

- `Cargo.toml` describes the crate and its dependencies.
- `src/lib.rs` or `src/main.rs` is the entry point.
- `src/` is organized by domain (e.g. `transaction/`, `consensus/`, `rpc/`).
- `tests/` or `src/tests/` may contain integration or component tests.

## 2. Typical crate roles

While the exact set of crates evolves over time, most of them fall into one of these categories:

- **Primitives & types**  
  Shared low-level types such as transactions, addresses, block identifiers, and signatures that are reused across the node.

- **Execution & EVM integration**  
  Crates that wire Tempo-specific behaviour into the EVM layer, including transaction validation and gas / fee accounting.

- **Consensus & networking**  
  Crates that implement Tempo's consensus protocol, message handling, and peer-to-peer logic.

- **Node services**  
  Crates that expose JSON-RPC APIs, node configuration, telemetry, and operational tooling.

- **Utilities & support**  
  Small helper crates for metrics, logging, feature flags, benchmarking, and similar concerns.

When in doubt, start from the top-level `Cargo.toml`, locate the workspace members, and then open the crate that matches the domain you want to work on.

## 3. How to explore a crate

A quick way to understand a crate is:

1. Open its `Cargo.toml` to see the crate name and its immediate dependencies.
2. Skim `src/lib.rs` or `src/main.rs` for the public API surface.
3. Look for `mod` declarations to find the internal modules.
4. Check `tests/` or `src/tests/` for examples of how the crate is used in practice.

If you are making a cross-cutting change, consider:

- Prefer reusing existing primitives and traits instead of introducing near-duplicates.
- Keeping public APIs small and well-documented.
- Adding or updating tests that demonstrate the intended usage.

## 4. Notes for contributors

- Changes to shared primitives should be made carefully, as they propagate widely across the codebase.
- Prefer clear, explicit types over ad-hoc `String` or `u64` usage where a domain-specific type exists.
- Whenever you introduce a new public type or behaviour, add a short comment or docstring to help future contributors.
- If your change spans multiple crates, consider mentioning the affected crates explicitly in your pull request description.

This document is intentionally high-level and may be extended over time as the crate layout evolves.
