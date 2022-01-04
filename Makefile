check:
	cargo check

build:
	cargo build --release

run:
	./target/release/chainteleport-node --dev --tmp

purge-alice:
	./target/release/chainteleport-node purge-chain --base-path /tmp/alice --chain local


run-alice:
	./target/release/chainteleport-node \
	--base-path /tmp/alice \
	--chain local \
	--alice \
	--port 30333 \
	--ws-port 9945 \
	--rpc-port 9933 \
	--node-key 0000000000000000000000000000000000000000000000000000000000000001 \
	--telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
	--validator

purge-bob:
	./target/release/chainteleport-node purge-chain --base-path /tmp/bob --chain local -y

run-bob:
	./target/release/chainteleport-node \
	--base-path /tmp/bob \
	--chain local \
	--bob \
	--port 30334 \
	--ws-port 9946 \
	--rpc-port 9934 \
	--telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
	--validator \
	--bootnodes /ip4/127.0.0.1/tcp/30333/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp


generate-keys:
	./target/release/chainteleport-node key generate --scheme Sr25519 --password-interactive

generate-derive-keys:
	./target/release/chainteleport-node key inspect --password-interactive --scheme Ed25519 0xd44687c2ae9c9767027fc2beaf1e7f952bd1f5f1d579430de564245ca2f6ddb8


build-spec:
	./target/release/chainteleport-node build-spec --disable-default-bootnode --chain local > customSpec.json

build-spec-raw:
	./target/release/chainteleport-node build-spec --chain=customSpec.json --raw --disable-default-bootnode > customSpecRaw.json

purge-first-node:
	./target/release/chainteleport-node purge-chain --base-path /tmp/node01 --chain local -y

start-first-node:
	./target/release/chainteleport-node \
	--base-path /tmp/node01 \
	--chain ./customSpecRaw.json \
	--port 30333 \
	--ws-port 9945 \
	--rpc-port 9933 \
	--telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
	--validator \
	--rpc-methods Unsafe \
	--name ChainTeleport01

	Local ID 12D3KooWErQ38CKZJAxwsKzyQ4FtbjMpAbuudkMS7cGNQWkyRXej

aura-keystore:
	./target/release/chainteleport-node key insert --base-path /tmp/node01 \
	--chain customSpecRaw.json \
	--suri 0xd44687c2ae9c9767027fc2beaf1e7f952bd1f5f1d579430de564245ca2f6ddb8 \
	--password-interactive \
	--key-type aura

grandpa-keystore:
	./target/release/chainteleport-node key insert --base-path /tmp/node01 \
	--chain customSpecRaw.json \
	--suri 0xd44687c2ae9c9767027fc2beaf1e7f952bd1f5f1d579430de564245ca2f6ddb8 \
	--password-interactive \
	--key-type gran

check-keystore:
	ls /tmp/node01/chains/local_testnet/keystore

purge-second-node:
	./target/release/chainteleport-node purge-chain --base-path /tmp/node02 --chain local -y


start-second-node:
	./target/release/chainteleport-node \
	--base-path /tmp/node02 \
	--chain ./customSpecRaw.json \
	--port 30334 \
	--ws-port 9946 \
	--rpc-port 9934 \
	--telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
	--validator \
	--rpc-methods Unsafe \
	--name ChainTeleport02 \
	--bootnodes /ip4/127.0.0.1/tcp/30333/p2p/12D3KooWErQ38CKZJAxwsKzyQ4FtbjMpAbuudkMS7cGNQWkyRXej