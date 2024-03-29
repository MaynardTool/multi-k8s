docker build -t edidock901/multi-client:latest -t edidock901/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t edidock901/multi-server:latest -t edidock901/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t edidock901/multi-worker:latest -t edidock901/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push edidock901/multi-client:latest
docker push edidock901/multi-server:latest
docker push edidock901/multi-worker:latest

docker push edidock901/multi-client:$SHA
docker push edidock901/multi-server:$SHA
docker push edidock901/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=edidock901/multi-server:$SHA
kubectl set image deployments/client-deployment client=edidock901/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=edidock901/multi-worker:$SHA