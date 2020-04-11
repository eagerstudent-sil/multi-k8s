docker build -t eagerstudent/multi-client:latest -t eagerstudent/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eagerstudent/multi-server:latest -t eagerstudent/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eagerstudent/multi-worker:latest -t eagerstudent/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push eagerstudent/multi-client:latest
docker push eagerstudent/multi-client:$SHA
docker push eagerstudent/multi-server:latest
docker push eagerstudent/multi-server:$SHA
docker push eagerstudent/multi-worker:latest
docker push eagerstudent/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eagerstudent/multi-server:$SHA
kubectl set image deployments/client-deployment client=eagerstudent/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eagerstudent/multi-worker:$SHA
