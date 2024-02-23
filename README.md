Initial attempt (work in progress) at making debuggable 'distroless' Docker containers for golang code.  Has launch.json for vs code.

Includes sample web server and dlv debugger.

docker image build -t go-debug .

docker run -p 8080:8080 -p 40000:40000 -it go-debug

Inside container:

/go/bin/dlv --headless --listen=:40000 exec /go/bin/app

Change .vscode/launch.json to point to remapped debugger port.

Launch debugger.

Profit!