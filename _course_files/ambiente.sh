kind delete cluster --name cursoistio
sleep 10s
kind create cluster --name cursoistio --config=kind-config.yaml
sleep 60s
cd $1
kubectl apply -f 1-istio-init.yaml
kubectl apply -f 2-istio-minikube.yaml
kubectl apply -f 3-kiali-secret.yaml
kubectl apply -f 4-label-default-namespace.yaml
sleep 30s
status=`kubectl get po -n istio-system`
while [[ $status == *"PodInitializing"* ]] [[ $status == *"ContainerCreating"* ]];
do
    sleep 15s
    status=`kubectl get po -n istio-system`
done
kubectl apply -f 5-application-no-istio.yaml
status=`kubectl get po`
while [[ $status == *"PodInitializing"* ]] || [[ $status == *"ContainerCreating"* ]];
do
    sleep 15s
    status=`kubectl get po`
done
kubectl apply -f 6-gateway.yaml
echo ""
echo "FINISHED"
echo ""
echo "Kiali: http://localhost:31000/"
echo "Jaeger: http://localhost:31001/"
echo "Grafana: http://localhost:31002/"
echo "App: http://localhost:31380/"
