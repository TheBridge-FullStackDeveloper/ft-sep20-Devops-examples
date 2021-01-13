printf "\e[1;33mStarting Minikube\n\e[0m"

# Iniciar minikube con el driver de virtualbox
	minikube start --driver=virtualbox

# Establecer como entorno de docker el de minikube
	eval $(minikube -p minikube docker-env)

printf "\e[1;32mMinikube Started\n\e[0m"



printf "\e[1;33mBuilding Backend Image\n\e[0m"

# Crear la imágen de Backend con la etiqueta myapp-backend-image
	docker build -t myapp-backend-image backend

printf "\e[1;32mBackend Image Builded\n\e[0m"


printf "\e[1;33mBuilding Frontend Image\n\e[0m"

# Crear la imágen de Frontend con la etiqueta myapp-frontend-image
	docker build -t myapp-frontend-image frontend

printf "\e[1;32mFrontend Builded Image\n\e[0m"


printf "\e[1;33mConfiguring MetalLBe\n\e[0m"
# Balanceador de carga MetalLB
	# Instalar el balanceador de carga MetalLB
	# Configuración de: https://metallb.universe.tf/installation/#installation-by-manifest
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
		# Solo se debería de ejecutar en la primera ejecución
		kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

	# Establecer la configuracion de MetalLB
		kubectl apply -f metalLB/metalLB.yaml
printf "\e[1;32mMetalLB configured\n\e[0m"


printf "\e[1;33mStart deployment\n\e[0m"
# Establecer la configuración del despliegue de la app
	kubectl apply -f deploy.yaml
printf "\e[1;32mDeployment started\n\e[0m"

sleep 1;
clear;

printf "\e[1;33mEnabling Dashboard\n\e[0m"
# Habilitar la Dashboard

	minikube addons enable metrics-server
	minikube addons enable dashboard

	printf "Dashboard enabled on: \e[1;32mhttp://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=default\e[0m\n"
	kubectl proxy --port=8001 > /dev/null