# Node Upgrade Notes

This document summarizes a safe sequence of steps for upgrading a Tempo node.

## 1. Gracefully stop the node

If you are running a localnet via `just`:

    just stop-localnet

If you are running a system service, use your service manager (for example, `systemctl stop tempo`).

## 2. Update the code

Make sure you are on the main branch and up to date:

    git checkout main
    git pull origin main

Then rebuild the binaries:

    just build-all

## 3. Run database migrations (if required)

Consult the release notes and run any migration commands before restarting the node.

## 4. Restart the node

For localnet:

    just localnet

For system services, use your service manager again:

    systemctl start tempo

## 5. Verify health

Use the `scripts/check_tempo_rpc_health.sh` helper (or `curl`) to confirm that RPC responds and the node is syncing correctly.
