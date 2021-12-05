check:
	cargo check

build:
	cargo build --release

run:
	./target/release/chainteleport-node --dev --tmp

purge:
	./target/release/chainteleport-node purge-chain --base-path /tmp/alice --chain local