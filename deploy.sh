docker build -t vidhusharma/multi-client:latest -t vidhusharma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vidhusharma/multi-server:latest -t vidhusharma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vidhusharma/multi-worker:latest -t vidhusharma/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vidhusharma/multi-client:latest
docker push vidhusharma/multi-server:latest
docker push vidhusharma/multi-worker:latest

docker push vidhusharma/multi-client:$SHA
docker push vidhusharma/multi-server:$SHA
docker push vidhusharma/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vidhusharma/multi-server:$SHA
kubectl set image deployments/client-deployment client=vidhusharma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vidhusharma/multi-worker:$SHA