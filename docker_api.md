# Docker API 

- ## vi /usr/lib/systemd/system/docker.service
- #vi /usr/lib/systemd/system/docker.service
- #grep ExecStart /usr/lib/systemd/system/docker.service -> ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock -H tcp://0.0.0.0:2375
- ## systemctl daemon-reload
- ## systemctl restart docker -> #curl localhost:2375/version

