docker build -t cray04/multi-client:latest -t cray04/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t cray04/multi-server:latest -t cray04/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t cray04/multi-worker:latest -t cray04/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push cray04/multi-client:latest
docker push cray04/multi-client:$GIT_SHA

docker push cray04/multi-server:latest
docker push cray04/multi-server:$GIT_SHA

docker push cray04/multi-worker:latest
docker push cray04/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cray04/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=cray04/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=cray04/multi-worker:$GIT_SHA
