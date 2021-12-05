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