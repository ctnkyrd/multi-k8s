docker build -t ctnkyrd/multi-client:latest -t ctnkyrd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ctnkyrd/multi-server:latest -t ctnkyrd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ctnkyrd/multi-worker:latest -t ctnkyrd/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ctnkyrd/multi-client:latest
docker push ctnkyrd/multi-server:latest
docker push ctnkyrd/multi-worker:latest

docker push ctnkyrd/multi-client:$SHA
docker push ctnkyrd/multi-server:$SHA
docker push ctnkyrd/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ctnkyrd/multi-server:$SHA
kubectl set image deployments/client-deployment client=ctnkyrd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ctnkyrd/multi-worker:$SHA