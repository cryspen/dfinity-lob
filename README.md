# Sample Rust limit order book

This is a bare-bones limit order book. You can add buy/sell limit orders and the book will try to match them as they come in, keeping them in the book otherwise.

There's very basic access control: the right to add orders can optionally be limited to a particular "order admin" principal, (optionally) specified during canister initialization.

There's no time limit on the orders, and orders can always be partially filled (all-or-nothing orders are not supported).

It's the caller's responsibility to ensure that order IDs are unique.

## Running the project locally

To test locally, first get the Internet Computer SDK.

```bash
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
```

Then run the following commands:

```bash
# Starts the replica, running in the background
dfx start --background

# Generates the Candid service description file, so we can get a basic UI
./generate_did.sh
# Deploys your canisters to the replica and generates your Candid interface
dfx deploy
```

The last command will output a URL. Navigate to the URL to get a basic UI.

Note that the canister will lose all data on an upgrade. Furthermore, since the "order admin" is set during initialization, if you want to change it, run:

```bash
dfx canister uninstall-code lob_backend
# Say you want to use your current principal as the order admin
dfx deploy --argument "opt (principal \"$(dfx identity get-principal)\")" --argument-type idl lob_backend
```

