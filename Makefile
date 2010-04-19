compile:clean
	erlc *.erl
go:compile
	erl -boot start_clean -s engine test
clean:
	rm -rf *.beam
	rm -rf erl_crash.dump

