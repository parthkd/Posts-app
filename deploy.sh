docker build -t kdsofts/multi-client:latest kdsofts/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kdsofts/multi-server:latest kdsofts/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kdsofts/multi-worker:latest kdsofts/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kdsofts/multi-client:latest
docker push kdsofts/multi-server:latest
docker push kdsofts/multi-worker:latest
docker push kdsofts/multi-client:$SHA
docker push kdsofts/multi-server:$SHA
docker push kdsofts/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kdsofts/multi-server:$SHA
kubectl set image deployments/client-deployment client=kdsofts/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kdsofts/multi-worker:$SHA