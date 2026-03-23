# Docker API 

- ## vi /usr/lib/systemd/system/docker.service
- #vi /usr/lib/systemd/system/docker.service
- #grep ExecStart /usr/lib/systemd/system/docker.service -> ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock -H tcp://0.0.0.0:2375
- ## systemctl daemon-reload
- ## systemctl restart docker -> #curl localhost:2375/version

### Commands

- curl  --unix-socket /var/run/docker.sock http://localhost/v1.53/containers/json|jq
- curl -X POST  localhost:2375/v1.53/containers/24b01e713c66d57d69b3fd44d5b8697395d68e6a2f9853aff02d0d1571f02d7f/stop
- curl -X POST  localhost:2375/v1.53/containers/24b01e713c66d57d69b3fd44d5b8697395d68e6a2f9853aff02d0d1571f02d7f/start
-  To see logs of the container:
curl --unix-socket /var/run/docker.sock http://localhost/containers/<Container ID>/logs?stdout=1&stderr=1
- To stop container from running
curl -X POST --unix-socket /var/run/docker.sock http://localhost/containers/<Container ID>/stop | jq
- To delete container from running
curl -X DELETE --unix-socket /var/run/docker.sock http://localhost/containers/<Container ID> | jq
