docker build -t amyzeta/multi-client:latest -t amyzeta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amyzeta/multi-server:latest -t amyzeta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amyzeta/multi-worker:latest -t amyzeta/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amyzeta/multi-client:latest
docker push amyzeta/multi-server:latest
docker push amyzeta/multi-worker:latest
docker push amyzeta/multi-client:$SHA
docker push amyzeta/multi-server:$SHA
docker push amyzeta/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amyzeta/multi-server:$SHA
kubectl set image deployments/client-deployment client=amyzeta/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amyzeta/multi-worker:$SHA
