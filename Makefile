config-k8s:
	@ansible-playbook \
	-i ./ansible/inventory \
	-u ubuntu \
	--ask-pass \
	./ansible/play.yml

config-k8s-master:
	@ansible-playbook \
	--limit master \
	-i ./ansible/inventory \
	-u ubuntu \
	--ask-pass \
	./ansible/play.yml

config-k8s-nodes:
	@ansible-playbook \
	--limit nodes \
	-i ./ansible/inventory \
	-u ubuntu \
	--ask-pass \
	./ansible/play.yml

config-k8s-get-join-command:
	@ansible-playbook \
	--limit master \
	--tags config \
	-i ./ansible/inventory \
	-u ubuntu \
	--ask-pass \
	./ansible/play.yml

burn:
	@echo "Unmounting SD card default volumes";
	umount /dev/sda1;
	umount /dev/sda2;
	@echo "Transfering OS image to SD card";
	@sudo dd \
		if=ubuntu-20.04.2-preinstalled-server-arm64+raspi.img \
		of=/dev/sda \
		bs=1M && \
	sync;
	@read -p "Remove the SD card and press enter to continue..." && \
	read -p "Reconnect the SD card and press enter to continue..." && \
	sleep 12;
	@read -p "SSID: " SSID; \
	read -p "Secret: " -s SECRET; \
	cat network-config | sed "s^{{ssid}}^$${SSID}^" | \
	sed "s^{{ssid-secret}}^$${SECRET}^" > .network-config; \
	echo -e "\n"; \
	unset SSID; \
	unset SECRET; \
	cp .network-config /run/media/$${USERNAME}/system-boot/network-config && \
	sync; \
	rm .network-config; \
	echo -e "All done..."

init:
	@wget https://cdimage.ubuntu.com/releases/20.04.2/release/ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.xz
	@xz --decompress --force ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.xz

cleanup:
	@rm ubuntu-20.04.2-preinstalled-server-arm64+raspi.img

deploy-k8s-nginx-generic:
	kubectl apply -f ./kubernetes/nginx-generic-deployment.yml
	kubectl apply -f ./kubernetes/nginx-generic-service.yml
	kubectl get service/nginx -o jsonpath='{.spec.ports[0].nodePort}'
