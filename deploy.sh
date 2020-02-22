docker build -t naveedhuq/multi-client:latest -t naveedhuq/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naveedhuq/multi-server:latest -t naveedhuq/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naveedhuq/multi-worker:latest -t naveedhuq/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push naveedhuq/multi-client:latest
docker push naveedhuq/multi-server:latest
docker push naveedhuq/multi-worker:latest

docker push naveedhuq/multi-client:$SHA
docker push naveedhuq/multi-server:$SHA
docker push naveedhuq/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=naveedhuq/multi-server:$SHA
kubectl set image deployments/client-deployments client=naveedhuq/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=naveedhuq/multi-worker:$SHA
