#!/bin/bash
# DSR Labs — Proxmox GPU Passthrough Checker
# Uso: ejecuta este script en el host de Proxmox para validar el estado del hardware.

echo "--- DSR Labs: Verificando IOMMU ---"
if dmesg | grep -e DMAR -e IOMMU | grep -q "enabled"; then
    echo "[OK] IOMMU está habilitado en el kernel."
else
    echo "[ERROR] IOMMU no detectado. Revisa tu BIOS y el GRUB (intel_iommu=on o amd_iommu=on)."
fi

echo -e "\n--- Verificando Agrupamiento PCI ---"
find /sys/kernel/iommu_groups/ -type l | count_groups=$(wc -l)
if [ "$count_groups" -gt 0 ]; then
    echo "[OK] Se detectaron $count_groups grupos IOMMU."
else
    echo "[ERROR] No se detectaron grupos IOMMU. El passthrough no funcionará."
fi

echo -e "\n--- Listando GPUs NVIDIA ---"
lspci -nn | grep -i nvidia

echo -e "\n--- Verificando vfio-pci configurado ---"
if lsmod | grep -q "vfio_pci"; then
    echo "[OK] El módulo vfio_pci está cargado."
else
    echo "[WARNING] El módulo vfio_pci NO está cargado. Asegúrate de configurarlo en /etc/modules."
fi

echo -e "\nConstruimos sobre fierro real. DSR Labs."
