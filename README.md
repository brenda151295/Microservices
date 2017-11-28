Microservicios
==================
Herramientas

1. [minikube](https://github.com/kubernetes/minikube)
2. Docker
3. Flask
4. Postgress
5. Envoy

Step 0: Minikube
================
Primero necesitamos empezar Minikude

```minikube start```

Empezar el demonio de docker

```sudo service docker start```

Luego:

```eval $(minikube docker-env)```

Para preparar todo para Minikude:

```
bash prep.sh -
```

Si se desea limpiar todo:

```
bash clean.sh
```

Step 1: App Flask
=======================

Empezar postgress ,usersvc-sds y edge-envoy2
```
bash up.sh postgres
bash up.sh usersvc-sds
bash up.sh edge-envoy2
```

Luego podremos ser capaces de hacer esto:

```
curl $(minikube service --url edge-envoy)/user/health
```

y nos devolverá:

```
{ 
  "hostname": "usersvc-1941676296-zlrt2",
  "msg": "user health check OK",
  "ok": true,
  "resolvedname": "172.17.0.10" 
}
```

Podemos agregar usuarios de esta forma:

```
curl -X PUT \
     -H "Content-Type: application/json" \
     -d '{ "fullname": "Alice", "password": "alicerules" }' \
     $(minikube service --url edge-envoy)/user/alice
```

Y si todo va bien recibiremos lo siguiente:

```
{
  "fullname": "Alice",
  "hostname": "usersvc-1941676296-zlrt2",
  "ok": true,
  "resolvedname": "172.17.0.10",
  "uuid": "44FD5687B15B4AF78753E33E6A2B033B" 
}
```

y para leer el usuario:

```
curl $(minikube service --url edge-envoy)/user/alice
```

Step 3: Crear más pods
=======================

Ejecutamos lo siguiente, para tener 3 replicas de usersrv

```
kubectl scale --replicas=3 deployment/usersvc
```
Deberíamos de ser capaces de consultar por los usuarios:
curl $(minikube service --url edge-envoy)/user/alice
