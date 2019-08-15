docker build -t parmanbabra/multi-client:latest -t parmanbabra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t parmanbabra/multi-server:latest -t parmanbabra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t parmanbabra/multi-worker:latest -t parmanbabra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push parmanbabra/multi-client:latest
docker push parmanbabra/multi-server:latest
docker push parmanbabra/multi-worker:latest

docker push parmanbabra/multi-client:$SHA
docker push parmanbabra/multi-server:$SHA
docker push parmanbabra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=parmanbabra/multi-server:$SHA
kubectl set image deployments/client-deployment client=parmanbabra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=parmanbabra/multi-worker:$SHA