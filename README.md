Initial attempt (work in progress) at making debuggable 'distroless' Docker containers for golang code.  Has launch.json for vs code.

Includes sample web server and dlv debugger.

docker image build -t go-debug .

docker run -P -it go-debug (note mapped ports)

Inside container:

/go/bin/dlv --headless --listen=:40000 exec /go/bin/app

Change launch.json to point to remapped debugger port.

Launch debugger.